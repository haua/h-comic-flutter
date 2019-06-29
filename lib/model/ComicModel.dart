import './AuthorModel.dart';
import '../utils/request.dart';

class ComicModel {
  final String sid;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String cover;
  final String coverBg;
  final String desc;
  final String tags;
  final int state;
  final int statePublish;
  final String publicTime;
  final String updateTime;
  final AuthorModel author;

  ComicModel.formJson(Map<String, dynamic> json) :
      sid = json['sid'],
      title = json['title'],
      cover = json['cover'],
      coverBg = json['coverBg'],
      desc = json['desc'],
      tags = json['tags'],
      state = json['state'],
      statePublish = json['statePublish'],
      author = new AuthorModel.formJson(json['author']),
      publicTime = json['publicTime'],
      updateTime = json['updateTime'],
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'sid': sid,
        'title': title,
        'cover': cover,
        'coverBg': coverBg,
        'desc': desc,
        'tags': tags,
        'state': state,
        'statePublish': statePublish,
        'author': author,
        'publicTime': publicTime,
        'updateTime': updateTime,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  static Future<List<ComicModel>> getList () async {
    List<ComicModel> comicList = [];

    const String api = '/comic/page';
    var response = await Request.get(api);
    Map data = response.data;
    if(data == null || data['data'] == null || !(data['data']['list'] is List)){
      // 走失败逻辑
      print({
        'api': api,
        '1': response.data.keys,
        'msg': '接口返回错误数据',
        'json': response
      });
    } else {
      data['data']['list'].forEach((item) => comicList.add(new ComicModel.formJson(item)));
    }

    return comicList;
  }
}