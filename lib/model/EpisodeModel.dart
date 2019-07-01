/// 每一话漫画的数据
///
import '../utils/request.dart';
import 'ComicImgModel.dart';
export 'ComicImgModel.dart';

class EpisodeModel {
  String sid = '';
  String title = '';
  String createdAt = '';
  List<ComicImgModel> imgs = [];

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    if(json != null) {
      sid = json['sid'] ?? sid;
      title = json['title'] ?? title;
      createdAt = json['createdAt'] ?? createdAt;
      imgs = ComicImgModel.fromJsonList(json['imgs']);
    }
  }

  static List<EpisodeModel> fromJsonList(List<dynamic> jsonList) {
    if(jsonList is List){
      // 复制多点数据，方便看页面效果
//      if(jsonList.length > 0){
//        List<dynamic> temp = [];
//        jsonList.forEach((item) {
//          temp.add(item);
//        });
//        jsonList.forEach((item) {
//          temp.add(item);
//        });
//        jsonList.forEach((item) {
//          temp.add(item);
//        });
//        jsonList = temp;
//      }
      return jsonList.map((json) => EpisodeModel.fromJson(json)).toList();
    }
    return [];
  }

  /// 获取某一话的详情
  static Future<EpisodeModel> getDetail (String EpisodeSid) async {
    const String api = '/comic/episode';
    Map data = await Request.get(api, qs: {'sid': EpisodeSid});
    return EpisodeModel.fromJson(data);
  }
}
