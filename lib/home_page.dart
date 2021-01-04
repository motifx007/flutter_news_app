import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/presets/category.dart';

import 'category_model.dart';
import 'category_view.dart';
import 'model_class/news_list_response.dart';
import 'networking/network.dart';
import 'news_details_page.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = List<CategoryModel>();
  NewsListResponse newsList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    newsList = await getTopHeadLines(Client());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text(
                "News Today",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 6.5,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryView(
                      image: categories[index].image,
                      categoryType: categories[index].categoryType,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10.0,
                    );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Top HeadLines",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.symmetric(vertical: 30.0),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: newsList.articles.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  newsList.articles[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetails(
                                          author:
                                              newsList.articles[index].author,
                                          title: newsList.articles[index].title,
                                          description: newsList
                                              .articles[index].description,
                                          newsURL: newsList.articles[index].url,
                                          imageURL: newsList
                                              .articles[index].urlToImage,
                                          publishTime: newsList
                                              .articles[index].publishedAt,
                                          content:
                                              newsList.articles[index].content,
                                        ),
                                      ));
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10.0,
                                child: Divider(
                                  thickness: 2.0,
                                ),
                              );
                            },
                          )),
              ),
            ],
          ),
        ));
  }
}
