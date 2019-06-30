import 'package:flutter/material.dart';
import '../widget/loading.dart';
import '../model/ComicModel.dart';

class ComicDetail extends StatefulWidget {
  @override
  _ComicDetailState createState() => new _ComicDetailState();
}

class _ComicDetailState extends State<ComicDetail>
    with SingleTickerProviderStateMixin {
  String sid;
  String title;

  bool loading = true;
  ComicModel comicDetailData;

  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
  }

  void setArgs(Map arguments) {
    if (arguments != null &&
        arguments['sid'] is String &&
        this.sid != arguments['sid']) {
      // 从上个页面传进来的对象，如果有这个对象，直接用，但是怕不准确，或者数据不全，同时也还是要发起网络请求。
      if (arguments['comicModel'] is ComicModel) {
        comicDetailData = arguments['comicModel'];
      }

      this.sid = arguments['sid'];
      this.title = arguments['title'];
//      getComicDetail();

      _tabController = TabController(length: tabs.length, vsync: this);
    }
  }

  void getComicDetail() async {
    loading = true;
    comicDetailData = await ComicModel.getDetail(sid);
    loading = false;
    print('漫画详情：${comicDetailData}');

    setState(() {
      //重新构建列表
    });
  }

  @override
  Widget build(BuildContext context) {
    setArgs(ModalRoute.of(context).settings.arguments);

    Widget loadingBody = Center(child: loading ? loadingWidget : Text('加载失败'));

    // 有内容时
    List<Widget> contentList = [
      Image.network(
        comicDetailData.coverBg,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),

      //Tab菜单
      TabBar(
        labelColor: Colors.black,
        controller: _tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      )
    ];

//    if(comicDetailData.comicChannels[0] != null) {
//      comicDetailData.comicChannels[0].episodes.map((episode) {
//
//      });
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? '漫画详情'),
      ),
      body: loading && comicDetailData == null ? loadingBody : Column(
        children: contentList,
      ),
    );
  }
}
