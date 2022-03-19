// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  // const ArticleView({Key? key}) : super(key: key);
  String imgUrl;
  ArticleView({required this.imgUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

Completer<WebViewController> _completer = Completer();

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(icon: Icon(Icons.arrow_back_ios_new) , onPressed: (){

          // },),
          actions: [
            Container(
              width: 80,
              child: Icon(
                Icons.abc,
                color: Colors.transparent,
              ),
            )
          ],
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "The",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "Leak",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            ],
          )),
      body: Container(
        child: WebView(
          initialUrl: widget.imgUrl,
          onWebViewCreated: ((WebViewController temp) {
            _completer.complete(temp);
          }),
        ),
      ),
    );
  }
}
