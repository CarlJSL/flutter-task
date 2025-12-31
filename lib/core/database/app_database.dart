import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// MIGRACIÓN V3: Nueva columna priority
  /// Valores: 'low', 'medium', 'high'
  /// Por defecto: 'medium'
  TextColumn get priority => text().withDefault(const Constant('medium'))();
}

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3; //  ACTUALIZADO A v3

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migración v1 → v2: Agregar createdAt
        if (from == 1) {
          await m.addColumn(tasks, tasks.createdAt);
        }

        // Migración v2 → v3: Agregar priority
        if (from <= 2) {
          await m.addColumn(tasks, tasks.priority);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// Obtener todas las taraes ordenadas por fecha de creación
  Future<List<Task>> getAllTasks() async {
    return await (select(tasks)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .get();
  }

  Future<Task?> getTaskById(int id) async {
    return await (select(
      tasks,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> createTask(TasksCompanion task) async {
    return await into(tasks).insert(task);
  }

  Future<bool> updateTask(TasksCompanion task) async {
    return await update(tasks).replace(task);
  }

  Future<int> deleteTask(int id) async {
    return await (delete(tasks)..where((t) => t.id.equals(id))).go();
  }

  Future<void> toggleTaskCompletion(int id) async {
    final task = await getTaskById(id);
    if (task != null) {
      await (update(tasks)..where((t) => t.id.equals(id))).write(
        TasksCompanion(isCompleted: Value(!task.isCompleted)),
      );
    }
  }

  Stream<List<Task>> watchAllTasks() {
    return select(tasks).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tasks.db'));
    return NativeDatabase(file);
  });
}
