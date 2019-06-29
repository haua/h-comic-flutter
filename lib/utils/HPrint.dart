/// 封装好一点的print
///
/// 一般这个用在测试用例里打印，应用里的打印建议用devTools的打印，那样好看些
/// ps 应用里用这个打印的内容，其实也能在devTools里看到

class HPrint {
  /// 支持多字段打印：
  /// @example HPrint.log(['你在哪啊', '家里吗？', {'name': 'haua'}]);
  static void log<T>(T objects) {
    if(objects is List){
      print(objects.join(' '));
    } else {
      print(objects);
    }
  }
}
