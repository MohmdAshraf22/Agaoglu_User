part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  const TaskLoaded({required this.tasks});
  @override
  List<Object> get props => [tasks];
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
  final String errorMessage;

  const TaskOperationError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}