import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qaz_latin/feature/news_feed/bloc/news_bloc.dart';
import 'package:qaz_latin/feature/news_feed/bloc/news_event.dart';
import 'package:qaz_latin/feature/news_feed/bloc/news_state.dart';
import 'package:qaz_latin/feature/news_feed/model/news_model.dart';
import 'package:qaz_latin/feature/news_page/ui/news_page.dart';
import 'package:qaz_latin/static/colors.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  NewsBloc _newsBloc = NewsBloc(LoadingNewsState(), []);

  @override
  void initState() {
    super.initState();
    _newsBloc.add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: ScreenUtil().setHeight(750),
            width: ScreenUtil().setWidth(500),
            child: BlocProvider(
              create: (BuildContext context) => _newsBloc,
              child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (BuildContext context, NewsState state) {
                if (state is LoadingNewsState) {
                  return Center(
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is ShowNewsList) {
                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: state.news.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _news(state.news[index]);
                    },
                  );
                }

                return Text('no data found');
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _news(News news) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NewsPage(news),
            ),
          );
        },
        child: Container(
          width: ScreenUtil().setWidth(400),
          height: ScreenUtil().setHeight(200),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 10.0,
                  color: scheme_shadow,
                ),
              ]),
          child: Stack(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: scheme_purple,
                ),
              ),
              Positioned(
                right: -10,
                top: 10.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    height: ScreenUtil().setHeight(180.0),
                    fit: BoxFit.fill,
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    image: NetworkImage(news.imgUrl),
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: scheme_purple.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 30.0),
                child: Text(
                  news.title,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
