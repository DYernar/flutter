import 'package:equatable/equatable.dart';

abstract class SingleNewsEvent extends Equatable {}

class IncreaseLatin extends SingleNewsEvent {
  @override
  List<Object> get props => [];
}

class DecreaseLatin extends SingleNewsEvent {
  @override
  List<Object> get props => [];
}

class ShowSingleNewsEvent extends SingleNewsEvent {
  final String news;

  ShowSingleNewsEvent(this.news);

  @override
  List<Object> get props => [news];
}
