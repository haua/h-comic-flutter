import 'package:flutter_test/flutter_test.dart';

import 'package:h_comic_flutter/utils/logger.dart';
import 'package:h_comic_flutter/utils/HPrint.dart';

void main() {
  test('测试logger', () {
    Logger.log2();
    expect(1, 1);
  });
  test('测试HPrint', () {
    HPrint.log(['你在哪啊', '家里吗？', {'name': 'haua'}]);
    expect(1, 1);
  });
  test('测试HPrint-map', () {
    HPrint.log( {'name': 'haua'});
    expect(1, 1);
  });
  test('测试HPrint-string', () {
    HPrint.log('My name is haua');
    expect(1, 1);
  });
  test('测试HPrint-int', () {
    HPrint.log(666);
    expect(1, 1);
  });
}
