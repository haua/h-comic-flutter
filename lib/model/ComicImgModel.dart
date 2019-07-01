/// 漫画每一张图的model
///

class ComicImgModel {
  String src = '';

  ComicImgModel.fromJson(Map<String, dynamic> json) {
    if(json != null) {
      src = json['src'] ?? src;
    }
  }

  static List<ComicImgModel> fromJsonList(List<dynamic> jsonList) {
    if(jsonList is List){
      return jsonList.map((json) => ComicImgModel.fromJson(json)).toList();
    }
    return [];
  }
}
