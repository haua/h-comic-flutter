/// 漫画阅读器

import 'package:flutter/material.dart';
import '../widget/loading.dart';
import '../widget/listEnd.dart';
import '../model/EpisodeModel.dart';

class ComicViewer extends StatefulWidget {
  @override
  _ComicViewerState createState() => new _ComicViewerState();
}

class _ComicViewerState extends State<ComicViewer>
    with SingleTickerProviderStateMixin {
  String sid;

  EpisodeModel episodeDetailData;
  bool isLoading = true;
  bool isNoMoreData = false;

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
      if (arguments['episodeModel'] is EpisodeModel) {
        episodeDetailData = arguments['episodeModel'];
      }

      this.sid = arguments['sid'];
      _getDetail();
    }
  }

  void _getDetail() async {
    isLoading = true;
    episodeDetailData = await EpisodeModel.getDetail(sid);
    isLoading = false;
    print('漫画详情：${episodeDetailData}');

    setState(() {
      //重新构建列表
    });
  }

  @override
  Widget build(BuildContext context) {
    setArgs(ModalRoute.of(context).settings.arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text(episodeDetailData?.title ?? '漫画内容'),
      ),
      body: ListView.separated(
        // notice 这里的数量表示这个列表要显示多少个item，如果不加1，最后的loading会出不来哦
        itemCount: episodeDetailData.imgs.length + 1,

        // 渲染单个item的方法
        itemBuilder: (context, index) {
          // 到了末尾
          if (index >= episodeDetailData.imgs.length) {
            if (isLoading) {
              return loadingWidget;
            } else if (isNoMoreData) {
              return listEnd;
            } else {
//              nowPage++;
//              _retrieveData();
              return loadingWidget;
            }
          }
          ComicImgModel img = episodeDetailData.imgs[index];
          return Image.network(img.src,
              width: double.infinity);
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      ),
    );
  }
}
