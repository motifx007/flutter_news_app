import 'package:flutter/material.dart';

import 'news_list.dart';

class CategoryView extends StatelessWidget {
  final String image, categoryType;

  const CategoryView({Key key, this.image, this.categoryType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: Colors.orange,
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => NewsList(
                  newsCategory: categoryType.toLowerCase(),
                )
            ));
          },
          child: Column(
            children: [
              Image.network(
                image,
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  categoryType,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}