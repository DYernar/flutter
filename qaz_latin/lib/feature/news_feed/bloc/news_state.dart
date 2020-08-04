import 'package:equatable/equatable.dart';
import 'package:qaz_latin/feature/news_feed/model/news_model.dart';

abstract class NewsState extends Equatable {}

class LoadingNewsState extends NewsState {
  @override
  List<Object> get props => [];
}

class ShowNewsList extends NewsState {
  final List<News> news;

  ShowNewsList(this.news);

  @override
  List<Object> get props => [news];
}
