import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks/core/utils/firebase_result_handler.dart';
import 'package:tasks/modules/user/data/models/user.dart';
import 'package:tasks/modules/user/data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final UserRepository _userRepository = UserRepository();

  Future<void> getUserInfo() async {
    emit(GetUserInfoLoadingState());
    final result = await _userRepository.getUserInfo();
    if (result is Success<Worker>) {
      emit(GetUserInfoSuccessState(result.data));
    } else if (result is Error<Worker>) {
      emit(UserErrorState(result.exception));
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(LoginLoadingState());
    final result =
        await _userRepository.loginWithEmailAndPassword(email, password);
    if (result is Success<Worker>) {
      emit(LoginSuccessState(result.data));
    } else if (result is Error<Worker>) {
      emit(UserErrorState(result.exception));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoadingState());
    final result = await _userRepository.resetPassword(email);
    if (result is Success<void>) {
      emit(ResetPasswordSuccessState());
    } else if (result is Error<void>) {
      emit(UserErrorState(result.exception));
    }
  }

  void changePasswordAppearance(bool currentState) {
    emit(ChangePasswordAppearanceState(!currentState));
  }

  static UserCubit? _cubit;
  static UserCubit get() => _cubit ??= UserCubit();
}
