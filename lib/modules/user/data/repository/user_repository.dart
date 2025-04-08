import 'package:tasks/core/utils/firebase_result_handler.dart';
import 'package:tasks/modules/user/data/services/remote_user_services.dart';

class UserRepository {
  final RemoteUserServices _remoteUserServices = RemoteUserServices();

  // Future<Result<Worker>> getUserInfo() async {
  //   return await _remoteUserServices.getUserInfo();
  // }

  Future<Result<void>> loginWithEmailAndPassword(
      String email, String password) async {
    return await _remoteUserServices.loginWithEmailAndPassword(email, password);
  }

  Future<Result<void>> resetPassword(String email) async {
    return await _remoteUserServices.resetPassword(email);
  }

  Future<Result<void>> logout() async {
    return await _remoteUserServices.logout();
  }
}
