import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/news_page/bloc/c_l_conversion.dart';
import 'package:qaz_latin/feature/news_page/bloc/single_news_event.dart';
import 'package:qaz_latin/feature/news_page/bloc/single_news_state.dart';

class SingleNewsBloc extends Bloc<SingleNewsEvent, SingleNewsState> {
  String _news;
  int proportion = 0;

  SingleNewsBloc(this._news) : super(null);

  @override
  Stream<SingleNewsState> mapEventToState(SingleNewsEvent event) async* {
    if (event is ShowSingleNewsEvent) {
      yield ShowNews(event.news, 0);
    }

    if (event is IncreaseLatin) {
      if (proportion < 6) {
        proportion++;
        int c = 0;
        alphabet.forEach((key, value) {
          if (c < (alphabet.length / 6) * proportion) {
            _news = _news.replaceAll(key, value);
            _news = _news.replaceAll(key.toUpperCase(), value.toUpperCase());
          }
          c++;
        });

        yield ShowNews(
            _news, (((7 * (proportion)) / alphabet.length) * 100).round());
      }
    }

    if (event is DecreaseLatin) {
      if (proportion > 0) {
        int c = 0;
        alphabet.forEach((key, value) {
          if (((alphabet.length / 6) * proportion).floor() - c <= 7) {
            _news = _news.replaceAll(value, key);
            _news = _news.replaceAll(value.toUpperCase(), key.toUpperCase());
          }
          c++;
        });
        proportion--;
        yield ShowNews(
            _news, (((7 * (proportion)) / alphabet.length) * 100).round());
      }
    }
  }
}
