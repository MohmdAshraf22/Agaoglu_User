import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks/core/utils/firebase_result_handler.dart';
import 'package:tasks/modules/user/data/models/user.dart';

abstract class BaseRemoteUserServices {
  Future<Result<Worker>> getUserInfo();
  Future<Result<Worker>> loginWithEmailAndPassword(
      String email, String password);
  Future<Result<void>> resetPassword(String email);
}

class RemoteUserServices implements BaseRemoteUserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Result<Worker>> getUserInfo() async {
    try {
      String workerId = _auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(workerId).doc().get();
      return Success(Worker.fromJson(snapshot));
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<Worker>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return await getUserInfo();
    } on Exception catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
