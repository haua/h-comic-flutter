/// 每一话漫画的数据

class EpisodeModel {
  String sid = '';
  String title = '';
  String createdAt = '';

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    if(json != null) {
      sid = json['sid'] ?? sid;
      title = json['title'] ?? title;
      createdAt = json['createdAt'] ?? createdAt;
    }
  }

  static List<EpisodeModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    if(jsonList is List){
      return jsonList.map((json) => EpisodeModel.fromJson(json));
    }
    return [];
  }
}
