import 'package:equatable/equatable.dart';

abstract class SingleNewsState extends Equatable {}

class ShowNews extends SingleNewsState {
  final String news;
  final int percent;

  ShowNews(this.news, this.percent);

  @override
  List<Object> get props => [news];
}
