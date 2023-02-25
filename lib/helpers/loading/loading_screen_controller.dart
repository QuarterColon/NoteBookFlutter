import 'package:flutter/cupertino.dart';

typedef CloseLoadingScreen = bool Function();
typedef UploadLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController{
  final CloseLoadingScreen close;
  final UploadLoadingScreen update;

  const LoadingScreenController({required this.close, required this.update});
}