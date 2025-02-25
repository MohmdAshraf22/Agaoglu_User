import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/constance_manger.dart';
import 'package:tasks/core/utils/text_styles_manager.dart';
import 'package:tasks/core/widgets/widgets.dart';
import 'package:tasks/generated/l10n.dart';
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
        title: Text(S.of(context).taskList, style: TextStylesManager.authTitle),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle))
        ],
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 1.w,
                vertical: .5.h,
              ),
              decoration: BoxDecoration(
                color: ColorManager.grey.withAlpha(59),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      onPressed: () {},
                      text: S.of(context).pendingTasks,
                      color: ColorManager.transparent,
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Expanded(
                    child: DefaultButton(
                      onPressed: () {},
                      textColor: ColorManager.grey,
                      icon: Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: 2.w,
                        ),
                        child: Icon(
                          Icons.circle_rounded,
                          color: ColorManager.orange,
                          size: 13.sp,
                        ),
                      ),
                      text: S.of(context).approvedTasks,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
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

  final VoidCallback? onAccept;
  final VoidCallback? onCancel;
  final VoidCallback? onDone;

  const TaskCard({
    super.key,
    required this.task,
    this.onAccept,
    this.onCancel,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
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
            color: _getStatusColor(task.status),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            task.status.name.toUpperCase(),
            style: TextStyle(
                color: ColorManager.white, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: onAccept,
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
    }
  }
}
