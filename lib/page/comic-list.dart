import 'package:flutter/material.dart';
import '../utils/request.dart';
import '../model/ComicModel.dart';

class ComicList extends StatefulWidget {
  @override
  _ComicListState createState() => new _ComicListState();
}

class _ComicListState extends State<ComicList> {
  static const loadingTag = "##loading##"; // 表尾标记
  var _words = <String>[loadingTag];
  var comicListAll = <ComicModel>[];

  var isLoading = false;
  var isNoMoreData = false;

  final noMore = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.0),
      child: Text(
        "没有更多了",
        style: TextStyle(color: Colors.grey),
      ));
  final loading = Container(
    padding: const EdgeInsets.all(16.0),
    alignment: Alignment.center,
    child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(strokeWidth: 2.0)),
  );

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  void _retrieveData() async {
    isLoading = true;
    List<ComicModel> comicList = await ComicModel.getList();
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
          itemCount: comicListAll.length,

          // 渲染单个item的方法
          itemBuilder: (context, index) {
            print('正在渲染:${index},数量${comicListAll.length}');
            // 到了末尾
            if (index >= comicListAll.length - 1) {
              if (isLoading) {
                print('正在loading');
                return loading;
              } else if (isNoMoreData) {
                return noMore;
              } else {
                _retrieveData();
                print('正在loading2');
                return loading;
              }
            }
            return MaterialButton(
              minWidth: double.infinity,
              color: Colors.green,
              onPressed: () {
                // 导航到新路由
                Navigator.pushNamed(context, "/ComicDetail", arguments: "hi");
              },
              child: SizedBox(
                width: double.infinity,
                child: Column(
//                mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.network(comicListAll[index].cover,
                        width: double.infinity, height: 200, fit: BoxFit.cover),
                    ListTile(title: Text(comicListAll[index].title))
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(height: .0),
        ));
  }
}
