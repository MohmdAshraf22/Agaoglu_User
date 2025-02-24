import 'package:flutter/material.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/modules/task/data/model/task.dart';

class CustomTaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;
  final VoidCallback? onDone;

  const CustomTaskCard({
    super.key,
    required this.task,
    this.onAccept,
    this.onCancel,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${task.status.name}',
              style: TextStyle(
                color: _getStatusColor(task.status),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onAccept != null)
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: onAccept,
                  ),
                if (onCancel != null)
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: onCancel,
                  ),
                if (onDone != null)
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: onDone,
                  ),
              ],
            ),
          ],
        ),
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
