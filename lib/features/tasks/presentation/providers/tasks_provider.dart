import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repo.dart';
import '../../data/repositories/task_repo_impl.dart';

part 'tasks_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(ref.watch(databaseProvider));
}

@riverpod
Stream<List<TaskEntity>> tasksStream(Ref ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchAllTasks();
}

@riverpod
Future<TaskEntity?> taskById(Ref ref, int id) async {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.getTaskById(id);
}

@riverpod
class TasksNotifier extends _$TasksNotifier {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> createTask({
    required String title,
    required String description,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(taskRepositoryProvider);
      await repository.createTask(title: title, description: description);
    });
  }

  Future<void> updateTask(TaskEntity task) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(taskRepositoryProvider);
      await repository.updateTask(task);
    });
  }

  Future<void> deleteTask(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(taskRepositoryProvider);
      await repository.deleteTask(id);
    });
  }

  Future<void> toggleTaskCompletion(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(taskRepositoryProvider);
      await repository.toggleTaskCompletion(id);
    });
  }
}
