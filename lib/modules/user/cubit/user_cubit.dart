import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks/core/utils/firebase_result_handler.dart';
import 'package:tasks/modules/user/data/models/user.dart';
import 'package:tasks/modules/user/data/models/worker_update_form.dart';
import 'package:tasks/modules/user/data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final UserRepository _userRepository = UserRepository();

  Worker? worker;
  Future<void> getUserInfo() async {
    emit(GetUserInfoLoadingState());
    final result = await _userRepository.getUserInfo();
    if (result is Success<Worker>) {
      worker = result.data;
      emit(GetUserInfoSuccessState(result.data));
    } else if (result is Error<Worker>) {
      emit(UserErrorState(result.exception));
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(LoginLoadingState());
    final result =
        await _userRepository.loginWithEmailAndPassword(email, password);
    if (result is Success<void>) {
      emit(LoginSuccessState());
    } else if (result is Error<void>) {
      emit(UserErrorState(result.exception));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final result = await _userRepository.logout();
    if (result is Success<void>) {
      emit(LogoutSuccessState());
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

  Future<void> updateWorkerProfile(WorkerUpdateForm form) async {
    emit(UpdateWorkerLoadingState());
    final result = await _userRepository.updateWorkerProfile(form);
    if (result is Success<Worker>) {
      worker = result.data;
      emit(UpdateWorkerSuccessState(worker: result.data));
    } else if (result is Error<Worker>) {
      emit(UserErrorState(result.exception));
    }
  }

  File? selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      emit(ImageSelectedState(image: selectedImage!));
    } else {}
  }

  void changePasswordAppearance(bool currentState) {
    emit(ChangePasswordAppearanceState(!currentState));
  }

  static UserCubit? _cubit;

  static UserCubit get() => _cubit ??= UserCubit();
}
