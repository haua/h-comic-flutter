import 'AuthorModel.dart';
import 'PageModel.dart';
import 'ChannelModel.dart';
import '../utils/request.dart';

class ComicModel {
  String sid = '';
  String createdAt = '';
  String updatedAt = '';
  String title = '';
  String cover = '';
  String coverBg = '';
  String desc = '';
  String tags = '';
  int state = 0;
  int statePublish = 0;
  String publicTime = '';
  String updateTime = '';
  AuthorModel author = AuthorModel.fromJson(null);
  List<ChannelModel> comicChannels = [];

  ComicModel.formJson(Map<String, dynamic> json) {
    if (json != null) {
      sid = json['sid'] ?? sid;
      title = json['title'] ?? title;
      cover = json['cover'] ?? cover;
      coverBg = json['coverBg'] ?? coverBg;
      desc = json['desc'] ?? desc;
      tags = json['tags'] ?? tags;
      state = json['state'] ?? state;
      statePublish = json['statePublish'] ?? statePublish;
      publicTime = json['publicTime'] ?? publicTime;
      updateTime = json['updateTime'] ?? updateTime;
      createdAt = json['createdAt'] ?? createdAt;
      updatedAt = json['updatedAt'] ?? updatedAt;
      author = AuthorModel.fromJson(json['author']);
      comicChannels = ChannelModel.fromJsonList(json['comicChannels']);
    }
  }

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
  @deprecated
  static Future<PageModel<ComicModel>> getPageData({int page = 1}) async {
    List<ComicModel> comicList = [];

    const String api = '/comic/page';
    Map data = await Request.get(api, qs: {'page': page});
    if (data == null || !(data['list'] is List)) {
      // 走失败逻辑
      print({'api': api, 'msg': '接口返回错误数据', 'json': data});
      return PageModel.formJson(null, comicList);
    }

    data['list']
        .forEach((item) => comicList.add(new ComicModel.formJson(item)));

    return PageModel.formJson(data, comicList);
  }
}
