import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/tasks/presentation/pages/home_page.dart';
import '../../features/tasks/presentation/pages/task_form_page.dart';
import '../../features/tasks/presentation/pages/task_detail_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

class AppRouter {
  static const String home = '/';
  static const String taskForm = '/task-form';
  static const String taskDetail = '/task/:id';

  static final GoRouter router = GoRouter(
    // Ruta inicial de la aplicación
    initialLocation: home,

    // Manejo de errores de navegación
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text('Ruta no encontrada: ${state.uri.path}')),
    ),

    // Definición de rutas
    routes: [
      /// RUTA 1: Home - Lista de tareas
      /// Path: /
      /// Pantalla principal que muestra todas las tareas guardadoS en Drift
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      /// RUTA 2: Formulario de Tarea (Create/Edit)
      /// Path: /task-form?id=X (id opcional para edición)
      /// Pantalla para crear una nueva tarea o editar una existente
      GoRoute(
        path: taskForm,
        name: 'task-form',
        builder: (context, state) {
          // Obtenemos el ID de la query si existe (para modo edición)
          final taskId = state.uri.queryParameters['id'];
          return TaskFormPage(
            taskId: taskId != null ? int.tryParse(taskId) : null,
          );
        },
      ),

      /// RUTA 3: Detalle de Tarea
      /// Path: /task/:id (Deep Link)
      /// Ejemplo: myapp-tecnico/task/1, /task/5
      /// Esta ruta soporta Deep Links para acceder directamente a una tarea
      /// desde fuera de la app (notificaciones, enlaces compartidos, etc.)
      GoRoute(
        path: taskDetail,
        name: 'task-detail',
        builder: (context, state) {
          final id = state.pathParameters['id'];

          if (id == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(child: Text('ID de tarea inválido')),
            );
          }

          final taskId = int.tryParse(id);
          if (taskId == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: const Center(child: Text('ID de tarea debe ser un número')),
            );
          }

          return TaskDetailPage(taskId: taskId);
        },
      ),
    ],
  );

  static void goToHome(BuildContext context) {
    context.go(home);
  }

  static void goToTaskForm(BuildContext context, {int? taskId}) {
    if (taskId != null) {
      context.push('$taskForm?id=$taskId');
    } else {
      context.push(taskForm);
    }
  }

  static void goToTaskDetail(BuildContext context, int taskId) {
    context.push('/task/$taskId');
  }
}
