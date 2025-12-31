import 'package:drift/drift.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repo.dart';
import '../../../../core/database/app_database.dart';

class TaskRepositoryImpl implements TaskRepository {
  final AppDatabase _database;

  TaskRepositoryImpl(this._database);

  TaskEntity _toEntity(Task task) {
    return TaskEntity(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      priority: task.priority, // v3: Incluir priority
    );
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final tasks = await _database.getAllTasks();
    return tasks.map((task) => _toEntity(task)).toList();
  }

  @override
  Future<TaskEntity?> getTaskById(int id) async {
    final task = await _database.getTaskById(id);
    if (task == null) return null;
    return _toEntity(task);
  }

  @override
  Future<int> createTask({
    required String title,
    required String description,
  }) async {
    return await _database.createTask(
      TasksCompanion(
        title: Value(title),
        description: Value(description),
        isCompleted: const Value(false),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _database.updateTask(
      TasksCompanion(
        id: Value(task.id),
        title: Value(task.title),
        description: Value(task.description),
        isCompleted: Value(task.isCompleted),
        createdAt: Value(task.createdAt),
        priority: Value(task.priority), // v3: Incluir priority
      ),
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    await _database.deleteTask(id);
  }

  @override
  Future<void> toggleTaskCompletion(int id) async {
    await _database.toggleTaskCompletion(id);
  }

  @override
  Stream<List<TaskEntity>> watchAllTasks() {
    return _database.watchAllTasks().map(
      (tasks) => tasks.map((task) => _toEntity(task)).toList(),
    );
  }
}
