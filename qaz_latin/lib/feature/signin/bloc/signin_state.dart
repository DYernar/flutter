import 'package:equatable/equatable.dart';

abstract class SigninState extends Equatable {}

class ShowLoginButton extends SigninState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SigninState {
  @override
  List<Object> get props => [];
}

class SigninError extends SigninState {
  @override
  List<Object> get props => [];
}
