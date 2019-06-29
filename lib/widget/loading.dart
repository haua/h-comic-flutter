import 'package:flutter/material.dart';

final loading = Container(
  padding: const EdgeInsets.all(16.0),
  alignment: Alignment.center,
  child: SizedBox(
      width: 24.0,
      height: 24.0,
      child: CircularProgressIndicator(strokeWidth: 2.0)),
);
