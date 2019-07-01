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

  int tabBarIndex = 0;

  bool loading = true;
  ComicModel comicDetailData;

  TabController _tabController; //需要定义一个Controller

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
      getComicDetail();
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
    ];

    int channelNum = comicDetailData.comicChannels.length;
    if (channelNum > 0) {
      if (channelNum > 1) {
        // 生成tabBar
        _tabController = TabController(length: channelNum, vsync: this);
        //Tab菜单
        TabBar tabBar = TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          tabs: comicDetailData.comicChannels
              .map((e) => Tab(text: e.name))
              .toList(),
        );
        contentList.add(tabBar);
      }

      // 生成每一集
      if (comicDetailData.comicChannels[tabBarIndex] == null) {
        tabBarIndex = 0;
      }
      ChannelModel showChannel = comicDetailData.comicChannels[tabBarIndex];

      if (showChannel.episodes != null && showChannel.episodes.length > 0) {
        contentList.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
              ),
              child: Wrap(
                spacing: 8.0, // 主轴(水平)方向间距
                children: showChannel.episodes.map((episode) {
                  return OutlineButton(
                    textColor: Colors.black,
                    child: Text(episode.title),
                    onPressed: () {
                      print(episode);
                      Navigator.pushNamed(context, "/ComicViewer", arguments: {'sid': episode.sid, 'episodeModel': episode});
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? '漫画详情'),
      ),
      body: loading || comicDetailData == null
          ? loadingBody
          : Column(
              children: contentList,
            ),
    );
  }
}
