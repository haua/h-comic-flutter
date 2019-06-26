class AuthorModel {
  final String sid;
  final String name;

  AuthorModel.formJson(Map<String, dynamic> json) :
        sid = json['sid'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'sid': sid,
        'name': name
      };
}