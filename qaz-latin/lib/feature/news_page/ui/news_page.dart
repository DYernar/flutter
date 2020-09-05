import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qaz_latin/feature/news_feed/model/news_model.dart';
import 'package:qaz_latin/feature/news_page/bloc/single_news_bloc.dart';
import 'package:qaz_latin/feature/news_page/bloc/single_news_event.dart';
import 'package:qaz_latin/feature/news_page/bloc/single_news_state.dart';
import 'package:qaz_latin/static/colors.dart';

class NewsPage extends StatefulWidget {
  final News news;

  const NewsPage(this.news, {Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  SingleNewsBloc _singleNewsBloc;

  @override
  void initState() {
    super.initState();
    _singleNewsBloc = SingleNewsBloc(widget.news.text);
    _singleNewsBloc.add(ShowSingleNewsEvent(widget.news.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _singleNewsBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: scheme_green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.news.title),
              BlocBuilder<SingleNewsBloc, SingleNewsState>(
                  builder: (BuildContext context, SingleNewsState state) {
                if (state is ShowNews) {
                  return Text('${state.percent}%');
                }
                return Container();
              })
            ],
          ),
        ),
        floatingActionButton: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  _singleNewsBloc.add(DecreaseLatin());
                },
                color: scheme_orange,
                child: Center(
                  child: Icon(Icons.remove),
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  _singleNewsBloc.add(IncreaseLatin());
                },
                color: scheme_orange,
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ListView(
              children: <Widget>[
                FadeInImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.news.imgUrl),
                  placeholder: AssetImage("assets/images/placeholder.png"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.news.title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 33.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: ScreenUtil().setWidth(400),
                  child: Column(
                    children: <Widget>[
                      BlocBuilder<SingleNewsBloc, SingleNewsState>(builder:
                          (BuildContext context, SingleNewsState state) {
                        if (state is ShowNews) {
                          return Text(
                            state.news,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          );
                        }
                        return Container();
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
