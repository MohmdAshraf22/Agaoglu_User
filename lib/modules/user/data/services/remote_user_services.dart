import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasks/core/utils/firebase_result_handler.dart';
import 'package:tasks/modules/user/data/models/user.dart';
import 'package:tasks/modules/user/data/models/worker_update_form.dart';

abstract class BaseRemoteUserServices {
  // Future<Result<Worker>> getUserInfo();
  Future<Result<void>> loginWithEmailAndPassword(String email, String password);

  Future<Result<void>> resetPassword(String email);
  Future<Result<Worker>> updateWorkerProfile(WorkerUpdateForm form);
  Future<Result<void>> logout();
}

class RemoteUserServices implements BaseRemoteUserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<Result<Worker>> getUserInfo() async {
    try {
      String workerId = _auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("workers").doc("$workerId").get();
      if (snapshot.data() != null) {
        debugPrint(
            "***************************************************************************");
        debugPrint(Worker.fromJson(snapshot).toString());
        debugPrint(
            "***************************************************************************");
        return Result.success(Worker.fromJson(snapshot));
      } else {
        debugPrint(
            "***************************************************************************");
        debugPrint("worker not found");
        debugPrint(
            "***************************************************************************");
        return Result.error(Exception());
      }
    } on Exception catch (e) {
      debugPrint(
          "******************************er*********************************************");
      debugPrint(e.toString());
      debugPrint(
          "***************************************************************************");
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(e);
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

  @override
  Future<Result<void>> logout() async {
    try {
      await _auth.signOut();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Worker>> updateWorkerProfile(WorkerUpdateForm form) async {
    try {
      String workerId = _auth.currentUser!.uid;
      String? imageUrl = form.imageUrl;

      if (form.image != null) {
        imageUrl = await _uploadImage(form.image!, '$workerId.jpg');
      }

      Map<String, dynamic> updateData = {
        'name': form.name,
        'surname': form.surname,
        'phoneNumber': form.phoneNumber,
      };

      if (imageUrl != null) {
        updateData['imageUrl'] = imageUrl;
      }

      await _firestore.collection('workers').doc(workerId).update(updateData);

      if (form.password != null && form.password!.isNotEmpty) {
        await _auth.currentUser!.updatePassword(form.password!);
      }

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('workers').doc(workerId).get();
      return Success(Worker.fromJson(snapshot));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<String?> _uploadImage(File image, String imageName) async {
    String? imageUrl;

    final Reference storageReference =
        _storage.ref().child('workers/$imageName');
    final UploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.then((v) async {
      imageUrl = await v.ref.getDownloadURL();
    });

    return imageUrl;
  }
}
