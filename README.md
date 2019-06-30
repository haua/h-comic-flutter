# h_comic_flutter

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## 开发

开发中，可以选择开启自动生成model，修改了model定义，会自动生成 fromJson 方法
开启命令：


    flutter packages pub run build_runner watch

## 说明

### 不使用 json_serializable

1 因为它生成的代码，大量使用as，如：


    EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) {
      return EpisodeModel(json['sid'] as String, json['title'] as String,
          json['createdAt'] as String);
    }

闲鱼架构师对 `json_serializable` 的看法： [https://www.jianshu.com/p/f96465b598d4](https://www.jianshu.com/p/f96465b598d4)

2 因为它生成的函数中，如果传入的json为null，还是会报错

---
推荐下面这样写，是最简洁的写法了，虽然属性不能用final定义了


    import 'EpisodeModel.dart';
    
    class ChannelModel {
      String sid = '';
      String name = '';
      EpisodeModel episodes = EpisodeModel.fromJson(null);
    
      ChannelModel.fromJson(Map<String, dynamic> json) {
        if(json != null){
          sid = json['sid'] ?? sid;
          name = json['name'] ?? name;
          episodes = EpisodeModel.fromJson(json['episodes']);
        }
      }
    }






