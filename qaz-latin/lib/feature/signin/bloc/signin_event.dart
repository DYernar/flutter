import 'package:equatable/equatable.dart';

abstract class SigninEvent extends Equatable {}

class SigninWithGoogleButtonPressed extends SigninEvent {
  @override
  List<Object> get props => [];
}
