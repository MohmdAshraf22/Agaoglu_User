import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tasks/core/utils/api_handler.dart';

// import 'package:tasks/modules/task/data/data_source/remote_data_source.dart';
import 'package:tasks/modules/task/data/model/task.dart';
import 'package:tasks/modules/task/data/repository/task_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  final TaskRepository _taskRepository = TaskRepository(); // Change

  void getTasks() {
    emit(TaskLoading());
    _taskRepository.getTasks().listen(
      (tasks) {
        emit(TaskLoaded(tasks: tasks));
      },
      onError: (error) {
        emit(TaskError(errorMessage: 'Failed to load tasks: $error'));
      },
    );
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
}
