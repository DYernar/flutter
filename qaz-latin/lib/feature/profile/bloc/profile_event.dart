import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class GetListEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}
