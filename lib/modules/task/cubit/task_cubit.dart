import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tasks/core/utils/api_handler.dart';
import 'package:tasks/modules/task/data/model/task.dart';
import 'package:tasks/modules/task/data/repository/task_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  final TaskRepository _taskRepository = TaskRepository(); // Change

  List<TaskModel> _tasks = [];

  void getTasks() {
    emit(TaskLoading());
    _taskRepository.getTasks().listen(
      (tasks) {
        _tasks = tasks;
        emit(TaskLoaded());
      },
      onError: (error) {
        emit(TaskError(errorMessage: 'Failed to load tasks: $error'));
      },
    );
  }

  void filterTasksByStatus(bool isSelectApprovedTasks) {
    List<TaskModel> approvedTasks = [], pendingTasks = [];
    if (!isSelectApprovedTasks) {
      pendingTasks = _tasks
          .where((task) =>
              task.status == TaskStatus.pending &&
              task.workerId == FirebaseAuth.instance.currentUser?.uid)
          .toList();
    } else {
      approvedTasks = _tasks
          .where((task) =>
              task.status != TaskStatus.pending &&
              task.workerId == FirebaseAuth.instance.currentUser?.uid)
          .toList();
    }
    emit(FilterTasksState(
        tasks: isSelectApprovedTasks ? approvedTasks : pendingTasks));
  }

  Future<void> acceptTask(String taskId) async {
    emit(TaskOperationLoading());
    final result = await _taskRepository.acceptTask(taskId); // Change
    _handleResult(result, 'accept');
  }

  Future<void> cancelTask(String taskId) async {
    emit(TaskOperationLoading());
    final result = await _taskRepository.cancelTask(taskId); // Change
    _handleResult(result, 'cancel');
  }

  Future<void> completeTask(String taskId) async {
    emit(TaskOperationLoading());
    final result = await _taskRepository.completeTask(taskId); // Change
    _handleResult(result, 'mark as done');
  }

  Future<void> startTask(String taskId) async {
    emit(TaskOperationLoading());
    final result = await _taskRepository.startTask(taskId); // Change
    _handleResult(result, 'start');
  }

  void _handleResult(Result<bool> result, String action) {
    if (result.data == true) {
      debugPrint('Task $action successful');
      emit(TaskOperationSuccess());
    } else {
      emit(TaskOperationError(
          errorMessage: 'Failed to $action task: ${result.errorMessage}'));
      debugPrint('Failed to $action task: ${result.errorMessage}');
    }
  }

  void selectApprovedTasks(bool isSelectApprovedTasks) {
    bool isSelectApprovedTasks0 = isSelectApprovedTasks;
    emit(SelectApprovedTasksState(
        isSelectApprovedTasks: isSelectApprovedTasks0));
  }
}
