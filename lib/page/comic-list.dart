import 'package:flutter/material.dart';
import '../model/ComicModel.dart';

import '../widget/loading.dart';
import '../widget/listEnd.dart';

class ComicList extends StatefulWidget {
  @override
  _ComicListState createState() => new _ComicListState();
}

class _ComicListState extends State<ComicList> {
  static const loadingTag = "##loading##"; // 表尾标记
  var comicListAll = <ComicModel>[];

  var nowPage = 1;
  var isLoading = false;
  var isNoMoreData = false;

  @override
  void initState() {
    super.initState();

    _retrieveData();
  }

  void _retrieveData() async {
    isLoading = true;

    List<ComicModel> comicList = await ComicModel.getPage(page: nowPage);
    isLoading = false;

    if (comicList.length <= 0) {
      if (isNoMoreData) {
        return;
      }
      isNoMoreData = true;
    } else {
      isNoMoreData = false;
      comicListAll.addAll(comicList);
    }
    setState(() {
      //重新构建列表
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print({'msg': '参数：', 'args': args});

    return Scaffold(
        appBar: AppBar(
          title: Text("漫画列表"),
        ),
        body: ListView.separated(
          // notice 这里的数量表示这个列表要显示多少个item，如果不加1，最后的loading会出不来哦
          itemCount: comicListAll.length + 1,

          // 渲染单个item的方法
          itemBuilder: (context, index) {
            // 到了末尾
            if (index >= comicListAll.length) {
              if (isLoading) {
                return loading;
              } else if (isNoMoreData) {
                return listEnd;
              } else {
                nowPage++;
                _retrieveData();
                return loading;
              }
            }
            ComicModel comic = comicListAll[index];
            return MaterialButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                // 导航到新路由
                Navigator.pushNamed(context, "/ComicDetail", arguments: {'sid': comic.sid, 'title': comic.title});
              },
              child: Column(
//                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.network(comic.cover,
                      width: double.infinity, height: 200, fit: BoxFit.cover),
                  ListTile(title: Text(comic.title))
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(height: .0),
        ));
  }
}
