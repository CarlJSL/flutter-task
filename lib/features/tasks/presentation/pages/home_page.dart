import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/router/app_router.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/empty_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsyncValue = ref.watch(tasksStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        actions: [
          Center(
            child: tasksAsyncValue.when(
              data: (tasks) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${tasks.length} tarea${tasks.length != 1 ? 's' : ''}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
      body: _buildResponsiveBody(context, tasksAsyncValue),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AppRouter.goToTaskForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Tarea'),
      ),
    );
  }

  Widget _buildResponsiveBody(
    BuildContext context,
    AsyncValue<List<dynamic>> tasksAsyncValue,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 600;

        return tasksAsyncValue.when(
          data: (tasks) {
            if (tasks.isEmpty) {
              return const EmptyState();
            }

            if (isDesktop) {
              return _buildGridView(tasks);
            } else {
              return _buildListView(tasks);
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $error'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(List<dynamic> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }

  Widget _buildGridView(List<dynamic> tasks) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }
}
