import 'package:flutter/material.dart';
import '../utils/request.dart';
import '../model/ComicModel.dart';

class ComicList extends StatefulWidget{
  @override
  _ComicListState createState() => new _ComicListState();
}

class _ComicListState extends State<ComicList> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  void _retrieveData() async {
    const String api = '/comic/page';
    var json = await Request.get(api);
    if(json == null || json.data == null || !(json.data['list'] is List)){
      // 走失败逻辑
      print({
        'api': api,
        'msg': '接口返回错误数据',
        'json': json
      });
      return;
    }

    List<ComicModel> comicList = [];

    json.data['list'].forEach((item) => comicList.add(new ComicModel.formJson(item)));

    print(comicList);

    Future.delayed(Duration(seconds: 1)).then((e) {
      Iterable<String> images = [
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'http://b-ssl.duitang.com/uploads/item/201704/12/20170412211122_rzjcK.jpeg',
        'http://b-ssl.duitang.com/uploads/item/201707/24/20170724132543_SCyWG.thumb.700_0.jpeg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
        'https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg',
      ];
      _words.insertAll(_words.length - 1, images);
      setState(() {
        //重新构建列表
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print({
      'msg': '参数：',
      'args': args
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("漫画列表"),
      ),
//      body: Center(
//        child: Column(
//          children: <Widget>[
//            Text("海贼王"),
//            // 我加的，热巴的美照
//            Image.network('https://b-ssl.duitang.com/uploads/item/201807/14/20180714211943_vlvpq.jpg'),
//          ],
//        )
//      )
      body: ListView.separated(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (_words[index] == loadingTag) {
            //不足100条，继续获取数据
            if (_words.length - 1 < 50) {
              //获取数据
              _retrieveData();
              //加载时显示loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)
                ),
              );
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
              );
            }
          }
          //显示单词列表项
//          return ;
          return Column(
            children: <Widget>[
              Image.network(
                _words[index],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover
              ),
              ListTile(title: Text('小热吧'))
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      )
    );
  }
}