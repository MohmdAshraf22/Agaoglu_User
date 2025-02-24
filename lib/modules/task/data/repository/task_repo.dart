import 'package:tasks/core/utils/api_handler.dart';
import 'package:tasks/modules/task/data/data_source/remote_data_source.dart';
import 'package:tasks/modules/task/data/model/task.dart';

class TaskRepository {
  final TaskDataSource _taskDataSource = TaskDataSourceImpl();

  Stream<List<TaskModel>> getTasks() {
    return _taskDataSource.getTasks();
  }

  Future<Result<bool>> acceptTask(String taskId) {
    return _taskDataSource.acceptTask(taskId);
  }

  Future<Result<bool>> updateTaskStatus(String taskId, TaskStatus newStatus) {
    return _taskDataSource.updateTaskStatus(taskId, newStatus);
  }

  Future<Result<bool>> cancelTask(String taskId) {
    return _taskDataSource.cancelTask(taskId);
  }

  Future<Result<bool>> completeTask(String taskId) {
    return _taskDataSource.completeTask(taskId);
  }

  Future<Result<bool>> startTask(String taskId) {
    return _taskDataSource.startTask(taskId);
  }
}
