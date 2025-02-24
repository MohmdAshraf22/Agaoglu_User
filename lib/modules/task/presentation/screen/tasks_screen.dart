import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/constance_manger.dart';
import 'package:tasks/modules/task/data/model/task.dart';
import 'package:tasks/modules/task/presentation/cubit/task_cubit.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<TaskModel> tasks = [];
  late TaskCubit taskCubit = context.read<TaskCubit>();

  @override
  void initState() {
    taskCubit.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyLight,
      appBar: AppBar(
        backgroundColor: ColorManager.greyLight,
        title: const Text("Task List",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle))
        ],
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                    ),
                    onPressed: () {},
                    child: const Text("Pending Tasks",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text("Approved Tasks",
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskLoaded) {
                  tasks = state.tasks;
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task: tasks[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(task.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Assigned: ${ConstanceManger.formatDateTime(task.createdAt)}",
                style: const TextStyle(color: Colors.grey)),
            Text(task.description,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor(task.status),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            task.status.name.toUpperCase(),
            style: TextStyle(
                color: ColorManager.white, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return ColorManager.yellow;
      case TaskStatus.approved:
        return ColorManager.green;
      case TaskStatus.inProgress:
        return ColorManager.blue;
      case TaskStatus.cancelled:
        return ColorManager.red;
      case TaskStatus.completed:
        return ColorManager.grey;
      default:
        return Colors.transparent;
    }
  }
}
