import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks/core/utils/api_handler.dart';
import 'package:tasks/modules/task/data/model/task.dart';

abstract class TaskDataSource {
  Stream<List<TaskModel>> getTasks();

  Future<Result<bool>> acceptTask(String taskId);

  Future<Result<bool>> startTask(String taskId);

  Future<Result<bool>> updateTaskStatus(String taskId, TaskStatus newStatus);

  Future<Result<bool>> cancelTask(String taskId);

  Future<Result<bool>> completeTask(String taskId);
}

class TaskDataSourceImpl implements TaskDataSource {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = 'tasks';

  @override
  Stream<List<TaskModel>> getTasks() {
    return _fireStore.collection(_collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromDocument(doc)).toList();
    }).handleError((error) {
      debugPrint('Error getting tasks: $error');
    });
  }

  @override
  Future<Result<bool>> updateTaskStatus(
      String taskId, TaskStatus newStatus) async {
    try {
      await _fireStore
          .collection(_collectionName)
          .doc(taskId)
          .update(_toTaskStatusJson(newStatus));
      return Result.success(true);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating task status: $e');
      return Result.failure('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Error updating task status: $e');
      return Result.failure('An unexpected error occurred.');
    }
  }

  Map<String, dynamic> _toTaskStatusJson(TaskStatus status) {
    if (status == TaskStatus.cancelled) {
      return {
        'status': TaskStatus.pending.name,
        "workerName": null,
        "workerPhoto": null,
        "workerId": null,
      };
    } else {
      return {'status': status.name};
    }
  }

  @override
  Future<Result<bool>> cancelTask(String taskId) {
    return updateTaskStatus(taskId, TaskStatus.cancelled);
  }

  @override
  Future<Result<bool>> completeTask(String taskId) {
    return updateTaskStatus(taskId, TaskStatus.completed);
  }

  @override
  Future<Result<bool>> startTask(String taskId) {
    return updateTaskStatus(taskId, TaskStatus.inProgress);
  }

  @override
  Future<Result<bool>> acceptTask(String taskId) {
    return updateTaskStatus(taskId, TaskStatus.approved);
  }
}

// // Example usage in a ViewModel (using ChangeNotifier)
// class TaskViewModel extends ChangeNotifier {
//   final TaskDataSource _taskDataSource;
//   List<Task> _tasks = [];
//
//   List<Task> get tasks => _tasks;
//   String? _errorMessage;
//
//   String? get errorMessage => _errorMessage;
//
//   TaskViewModel(this._taskDataSource) {
//     _loadTasks();
//   }
//
//   void _loadTasks() {
//     _taskDataSource.getTasks().listen((tasks) {
//       _tasks = tasks;
//       _errorMessage = null;
//       notifyListeners();
//     }, onError: (error) {
//       _errorMessage = 'Failed to load tasks: $error';
//       notifyListeners();
//     });
//   }
//
//   Future<void> acceptTask(String taskId) async {
//     final result = await _taskDataSource.acceptTask(taskId);
//     _handleResult(result, 'accept');
//   }
//
//   Future<void> cancelTask(String taskId) async {
//     final result = await _taskDataSource.cancelTask(taskId);
//     _handleResult(result, 'cancel');
//   }
//
//   Future<void> markTaskAsDone(String taskId) async {
//     final result = await _taskDataSource.markTaskAsDone(taskId);
//     _handleResult(result, 'mark as done');
//   }
//
//   void _handleResult(Result<bool> result, String action) {
//     if (result.data == true) {
//       debugPrint('Task $action successful');
//       _errorMessage = null;
//       // Optionally, you might want to refresh the task list here
//       // _loadTasks(); // Or just rely on the stream to update the UI
//     } else {
//       _errorMessage = 'Failed to $action task: ${result.errorMessage}';
//       debugPrint(_errorMessage);
//     }
//     notifyListeners();
//   }
// }
