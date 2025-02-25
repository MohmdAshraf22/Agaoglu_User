import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/text_styles_manager.dart';
import 'package:tasks/core/widgets/widgets.dart';
import 'package:tasks/generated/l10n.dart';
import 'package:tasks/modules/task/data/model/task.dart';
import '../../../../core/utils/constance_manger.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;
  final VoidCallback? inProgress;
  final VoidCallback? onApprove; // Added onApprove callback

  const TaskCard({
    super.key,
    required this.task,
    this.onCancel,
    this.inProgress,
    this.onComplete,
    this.onApprove, // Added onApprove to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsetsDirectional.symmetric(
              horizontal: 3.w,
              vertical: 1.h,
            ),
            title: Text(task.title, style: TextStylesManager.cardTitle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(S.of(context).assignedToYou,
                    style: const TextStyle(color: ColorManager.grey)),
                Text(task.description, style: TextStylesManager.cardText),
                if (task.block != null && task.block!.isNotEmpty)
                  Text(task.block!, style: TextStylesManager.cardText),
                if (task.site != null && task.site!.isNotEmpty)
                  Text(task.site!, style: TextStylesManager.cardText),
                if (task.flat != null && task.flat!.isNotEmpty)
                  Text(task.flat!, style: TextStylesManager.cardText),
                Text(ConstanceManger.formatDateTime(task.createdAt),
                    style: TextStylesManager.caption),
              ]
                  .expand(
                    (element) => [element, SizedBox(height: .4.h)],
                  )
                  .toList(),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .6.h),
              decoration: BoxDecoration(
                color: getStatusColor(task.status),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                task.status.name.toUpperCase(),
                style: TextStyle(
                    color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (task.status != TaskStatus.completed)
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 3.w,
                vertical: 1.h,
              ),
              child: Row(
                children: [
                  if (task.status == TaskStatus.approved ||
                      task.status == TaskStatus.inProgress)
                    Expanded(
                      child: DefaultButton(
                        textColor: ColorManager.white,
                        color: ColorManager.red,
                        text: S.of(context).cancelTask,
                        onPressed: onCancel,
                      ),
                    ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(width: 2.w),
                        Expanded(
                          child: DefaultButton(
                            textColor: ColorManager.white,
                            text: getTaskStatusLanguage(task.status, context),
                            color: getStatusColor(task.status),
                            onPressed: _handleTaskStatus(task.status),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (task.status == TaskStatus.completed)
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 3.w,
                vertical: 1.h,
              ),
              child: Center(
                  child: Text("Task Completed",
                      style: TextStylesManager.cardText)),
            ),
        ],
      ),
    );
  }

  _handleTaskStatus(status) {
    switch (status) {
      case TaskStatus.pending:
        return onApprove;
      case TaskStatus.approved:
        return inProgress;
      case TaskStatus.inProgress:
        return onComplete;
    }
  }
}
