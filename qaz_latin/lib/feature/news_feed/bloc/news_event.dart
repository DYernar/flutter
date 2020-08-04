import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class GetNewsEvent extends NewsEvent {
  @override
  List<Object> get props => [];
}
