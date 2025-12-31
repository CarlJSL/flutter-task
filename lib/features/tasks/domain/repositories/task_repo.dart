import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks();
  Future<TaskEntity?> getTaskById(int id);
  Future<int> createTask({required String title, required String description});
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
  Future<void> toggleTaskCompletion(int id);
  Stream<List<TaskEntity>> watchAllTasks();
}
