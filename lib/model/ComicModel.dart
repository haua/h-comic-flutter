import 'AuthorModel.dart';
import 'PageModel.dart';
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

  ComicModel.formJson(Map<String, dynamic> json)
      : sid = json['sid'],
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

  Map<String, dynamic> toJson() => <String, dynamic>{
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

  static Future<List<ComicModel>> getPage({int page = 1}) async {
    List<ComicModel> comicList = [];

    const String api = '/comic/page';
    Map data = await Request.get(api, qs: {'page': page});
    if (data == null || !(data['list'] is List)) {
      // 走失败逻辑
      print({'api': api, 'msg': '接口返回错误数据', 'json': data});
      return comicList;
    }

    data['list']
        .forEach((item) => comicList.add(new ComicModel.formJson(item)));

    return comicList;
  }

  static Future<ComicModel> getDetail(sid) async {
    const String api = '/comic/sid';
    Map data = await Request.get(api, qs: {'sid': sid});
    return data == null ? null : new ComicModel.formJson(data);
  }

  // 上面的方法是直接返回list的，这个方法是返回page对象，根据需求用吧
  static Future<PageModel<ComicModel>> getPageData({int page = 1}) async {
    List<ComicModel> comicList = [];

    const String api = '/comic/page';
    Map data = await Request.get(api, qs: {'page': page});
    if (data == null ||
        !(data['list'] is List)) {
      // 走失败逻辑
      print({'api': api, 'msg': '接口返回错误数据', 'json': data});
      return PageModel.formJson(null, comicList);
    }

    data['list']
        .forEach((item) => comicList.add(new ComicModel.formJson(item)));

    return PageModel.formJson(data, comicList);
  }
}
