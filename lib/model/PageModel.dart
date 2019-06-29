/// 后端所有分页接口的输出格式都是一样的，所以前端也弄一个model对应

class PageModel<T> {
  final int page;
  final int pageSize;
  final int total;
  final List<T> list;
  final bool nextPage;

  PageModel.formJson(Map<String, dynamic> json, list)
      : page = (json == null ? 0 : int.parse(json['page'])) ?? 0,
        pageSize = (json == null ? 10 : json['pageSize']) ?? 10,
        total = (json == null ? -1 : json['total']) ?? -1,
        list = list,
        nextPage = json == null ? true : (list.length >= (json['pageSize'] ?? 0));

  static Map<String, dynamic> formatJson (json) {
    if(json == null) {
      return {
        'page': 0,
        'pageSize': 10,
        'total': -1,
        'nextPage': true,
      };
    }

    return {
      'page': json?.page,
      'pageSize': 10,
      'total': -1,
      'nextPage': true,
    };
  }
}