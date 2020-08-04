import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/news_feed/bloc/news_event.dart';
import 'package:qaz_latin/feature/news_feed/bloc/news_state.dart';
import 'package:qaz_latin/feature/news_feed/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<News> news;
  NewsBloc(NewsState initialState, this.news) : super(LoadingNewsState());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is GetNewsEvent) {
      yield LoadingNewsState();
      await _getNews();
      yield ShowNewsList(this.news);
    }
  }

  Future<void> _getNews() async {
    try {
      final response = await http.get(
        'https://evening-oasis-57787.herokuapp.com/getNews',
        headers: {'appToken': 'Qazaq latin app'},
      );

      final v = jsonDecode(response.body);
      if (v != null) {
        v.forEach((k) {
          news.add(new News(k['title'], k['text'], k['img']));
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
