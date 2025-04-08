part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserErrorState extends UserState {
  final Exception exception;
  const UserErrorState(this.exception);
  @override
  List<Object> get props => [exception];
}

class GetUserInfoLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class GetUserInfoSuccessState extends UserState {
  final Worker worker;
  const GetUserInfoSuccessState(this.worker);
  @override
  List<Object> get props => [worker];
}

class LoginLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends UserState {
  @override
  List<Object> get props => [];
}

final class LogoutLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

final class LogoutSuccessState extends UserState {
  @override
  List<Object> get props => [];
}

class ChangePasswordAppearanceState extends UserState {
  final bool isPasswordVisible;
  const ChangePasswordAppearanceState(this.isPasswordVisible);
  @override
  List<Object> get props => [isPasswordVisible];
}

final class ResetPasswordSuccessState extends UserState {
  @override
  List<Object> get props => [];
}

final class ResetPasswordLoadingState extends UserState {
  @override
  List<Object> get props => [];
}
