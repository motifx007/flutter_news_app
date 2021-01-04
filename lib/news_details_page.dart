import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  final String author;
  final String title;
  final String description;
  final String newsURL;
  final String imageURL;
  final String publishTime;
  final String content;

  const NewsDetails({Key key, this.author, this.title, this.description, this.newsURL, this.imageURL, this.publishTime, this.content}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
          onPressed: Navigator.of(context).pop,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:  widget.newsURL,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
