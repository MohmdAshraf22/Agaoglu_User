part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  @override
  List<Object> get props => [];
}

final class TaskError extends TaskState {
  final String errorMessage;

  const TaskError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class TaskOperationLoading extends TaskState {}

final class TaskOperationSuccess extends TaskState {}

final class TaskOperationError extends TaskState {
  final Exception errorMessage;

  const TaskOperationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class SelectApprovedTasksState extends TaskState {
  final bool isSelectApprovedTasks;

  const SelectApprovedTasksState({required this.isSelectApprovedTasks});

  @override
  List<Object> get props => [isSelectApprovedTasks];
}

final class FilterTasksState extends TaskState {
  final List<TaskModel> tasks;

  const FilterTasksState({required this.tasks});

  @override
  List<Object> get props => [
        tasks,
      ];
}
