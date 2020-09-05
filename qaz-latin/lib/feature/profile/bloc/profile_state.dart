import 'package:equatable/equatable.dart';
import 'package:qaz_latin/model/user.dart';

abstract class ProfileState extends Equatable {}

class ShowDataState extends ProfileState {
  final User currentUser;

  final List<List<Map>> ranks;
  final List<List<double>> progress;

  ShowDataState(this.currentUser, this.ranks, this.progress);
  @override
  List<Object> get props => [currentUser, ranks, progress];
}

class LoadingProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}
