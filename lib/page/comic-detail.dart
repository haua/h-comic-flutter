import 'package:flutter/material.dart';
import '../widget/loading.dart';
import '../model/ComicModel.dart';

class ComicDetail extends StatefulWidget {
  @override
  _ComicDetailState createState() => new _ComicDetailState();
}

class _ComicDetailState extends State<ComicDetail> {
  String sid;
  String title;

  @override
  void initState() {
    super.initState();
  }

  void setArgs (Map arguments) {
    if (arguments != null && arguments['sid'] is String && this.sid != arguments['sid']){
      this.sid = arguments['sid'];
      this.title = arguments['title'];
      getComicDetail();
    }
  }

  void getComicDetail () async {
    ComicModel comicModel = await ComicModel.getDetail(sid);
    print('漫画详情：${comicModel}');
  }

  @override
  Widget build(BuildContext context) {
    setArgs(ModalRoute.of(context).settings.arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? '漫画详情'),
      ),
      body: Center(
        child: loading
      ),
    );
  }
}