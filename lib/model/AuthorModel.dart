class AuthorModel {
  String sid;
  String name;

  AuthorModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      sid = json['sid'] ?? sid;
      name = json['name'] ?? name;
    }
  }
}
