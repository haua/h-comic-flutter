import 'package:flutter/material.dart';

class ComicDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("漫画详情"),
      ),
      body: Center(
        child: Text("海贼王"),
      ),
    );
  }
}