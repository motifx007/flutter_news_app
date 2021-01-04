import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news/model_class/news_list_response.dart';
import 'package:flutter_news/networking/network.dart';
import 'package:flutter_news/news_details_page.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class NewsList extends StatefulWidget {
  final String newsCategory;

  const NewsList({Key key, this.newsCategory}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  NewsListResponse newsList;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getNews();
    super.initState();
  }

  void getNews() async {
    newsList = await getCategoryData(Client(), widget.newsCategory);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
          onPressed: Navigator.of(context).pop,
        ),
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.newsCategory.replaceRange(0, 1, widget.newsCategory[0].toUpperCase()) + " News",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.separated(
          itemCount: newsList.articles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
                    title: Text(
                      newsList.articles[index].title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    subtitle: Text(convertDate(newsList.articles[index].publishedAt), textAlign: TextAlign.right, style: TextStyle(fontSize: 12.0),),
                    leading: newsList.articles[index].urlToImage != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                              newsList.articles[index].urlToImage,
                              height: MediaQuery.of(context).size.width / 6,
                              width: MediaQuery.of(context).size.width / 3,
                              fit: BoxFit.cover,
                            ),
                        )
                        : Container(child: Image.asset("assets/no-camera.png"), height: MediaQuery.of(context).size.width / 6,
                      width: MediaQuery.of(context).size.width / 3,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => NewsDetails(
                          author: newsList.articles[index].author,
                          title: newsList.articles[index].title,
                          description: newsList.articles[index].description,
                          newsURL: newsList.articles[index].url,
                          imageURL: newsList.articles[index].urlToImage,
                          publishTime: newsList.articles[index].publishedAt,
                          content: newsList.articles[index].content,
                          ),
                      ));
                    },
                  );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}

String convertDate(String newsDate) {
  var dateFormate = DateFormat("dd-MM-yyyy, HH:mm:ss").format(DateTime.parse(newsDate));
  return dateFormate;
}