/**
 * 在这里面定义路由吧
 * */

import 'package:flutter/material.dart';

import './page/home.dart';
import './page/comic-detail.dart';
import './page/comic-list.dart';

var routerMap = <String, WidgetBuilder>{
  // 好像 / 必须是首页
  '/': (BuildContext context) => new MyHomePage(title: '漫画app',),
  '/ComicList': (BuildContext context) => new ComicList(),
  '/ComicDetail': (BuildContext context) => new ComicDetail(),
};