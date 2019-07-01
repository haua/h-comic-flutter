import 'EpisodeModel.dart';
export 'EpisodeModel.dart';

class ChannelModel {
  String sid = '';
  String name = '';
  List<EpisodeModel> episodes = [];

  ChannelModel.fromJson(Map<String, dynamic> json) {
    if(json != null){
      sid = json['sid'] ?? sid;
      name = json['name'] ?? name;
      episodes = EpisodeModel.fromJsonList(json['episodes']);
    }
  }

  static List<ChannelModel> fromJsonList(List<dynamic> jsonList) {
    if(jsonList is List) {
      return jsonList.map((json) => ChannelModel.fromJson(json)).toList();
    }
    return [];
  }
}
