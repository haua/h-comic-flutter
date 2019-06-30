/// 工具
class hTools {
  /// 根据定义，把json中缺少的部分生成出来
  /// @param [json]
  /// @param [defJson] 默认的json
  static Map<String, dynamic> createJson (Map<String, dynamic>json, Map<String, dynamic>defJson) {
    if(json == null){
      json = <String, dynamic>{};
    }

    defJson.forEach((String key, dynamic value) {
      if(json[key] == null){
        json[key] = value;
      }
    });

    return json;
  }
}