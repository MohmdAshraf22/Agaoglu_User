import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasks/core/routing/navigation_manager.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/text_styles_manager.dart';
import 'package:tasks/core/widgets/widgets.dart';
import 'package:tasks/generated/l10n.dart';
import 'package:tasks/modules/task/data/model/task.dart';
import 'package:tasks/modules/task/cubit/task_cubit.dart';
import 'package:tasks/modules/task/ui/widgets/custom_task_card.dart';

import '../../../user/cubit/user_cubit.dart';
import '../../../user/ui/screen/login_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late List<TaskModel> _filteredTasks = [];
  late TaskCubit _taskCubit;
  bool _isApprovedTasksSelected = false;

  @override
  void initState() {
    super.initState();
    _taskCubit = context.read<TaskCubit>();
    _taskCubit.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyLight,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.greyLight,
      title: Text(S.of(context).taskList, style: TextStylesManager.authTitle),
      actions: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is LogoutSuccessState) {
              context.pushAndRemove(LoginScreen());
            }
          },
          child: IconButton(
              onPressed: () {
                context.read<UserCubit>().logout();
              },
              icon: const Icon(Icons.logout)),
        )
      ],
      elevation: 4,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTaskFilterButtons(),
        Expanded(child: _buildTaskList()),
      ],
    );
  }

  Widget _buildTaskFilterButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 1.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: ColorManager.grey.withAlpha(59),
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is SelectApprovedTasksState) {
              _isApprovedTasksSelected = state.isSelectApprovedTasks;
              _taskCubit.filterTasksByStatus(_isApprovedTasksSelected);
            }
            return Row(
              children: [
                _buildFilterButton(
                  text: S.of(context).pendingTasks,
                  isSelected: !_isApprovedTasksSelected,
                  onPressed: () => _taskCubit.selectApprovedTasks(false),
                ),
                SizedBox(width: 1.w),
                _buildFilterButton(
                  text: S.of(context).approvedTasks,
                  isSelected: _isApprovedTasksSelected,
                  onPressed: () => _taskCubit.selectApprovedTasks(true),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterButton({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: DefaultButton(
        onPressed: onPressed,
        text: text,
        icon: Padding(
          padding: EdgeInsetsDirectional.only(end: 2.w),
          child: isSelected
              ? Icon(Icons.circle_rounded,
                  color: ColorManager.orange, size: 13.sp)
              : null,
        ),
        textColor: isSelected ? ColorManager.black : ColorManager.grey,
        color: isSelected ? ColorManager.white : ColorManager.transparent,
      ),
    );
  }

  Widget _buildTaskList() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          _taskCubit.filterTasksByStatus(_isApprovedTasksSelected);
        } else if (state is FilterTasksState) {
          _filteredTasks = state.tasks;
        }
        return Skeletonizer(
          enabled: state is TaskLoading,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _filteredTasks.length,
            itemBuilder: (context, index) {
              final TaskModel task = _filteredTasks[index];
              return TaskCard(
                task: task,
                onApprove: _getTaskAction(task.status, task.id),
                onCancel: _isApprovedTasksSelected
                    ? () => _taskCubit.cancelTask(task.id)
                    : null,
                onComplete: _getTaskAction(task.status, task.id),
                inProgress: _getTaskAction(task.status, task.id),
              );
            },
          ),
        );
      },
    );
  }

  VoidCallback? _getTaskAction(TaskStatus status, String id) {
    switch (status) {
      case TaskStatus.pending:
        return () => _taskCubit.acceptTask(id);
      case TaskStatus.inProgress:
        return () => _taskCubit.completeTask(id);
      case TaskStatus.approved:
        return () => _taskCubit.startTask(id);
      default:
        return null;
    }
  }
}
