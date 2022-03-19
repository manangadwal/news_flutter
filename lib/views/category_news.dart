// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/models/article_model.dart';
import 'package:news_flutter/helper/news_Articles.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  String category, title;
  CategoryNews({required this.category, required this.title});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> article = [];
  bool loading = true;
  String? title;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    article = newsClass.categoryNews;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              Text(widget.title, style: TextStyle(color: Colors.black)),
              Text("Leaks", style: TextStyle(color: Colors.blue))
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 12, right: 12, top: 25, bottom: 25),
          child: loading
              ? Center(
                  child: Container(
                      child: CircularProgressIndicator(
                  color: Colors.blue,
                )))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: article.length,
                  itemBuilder: (context, idx) {
                    return CategoryTile(
                      desc: article[idx].desc,
                      imgUrl: article[idx].urltoImg,
                      title: article[idx].title,
                      url: article[idx].url,
                    );
                  }),
        ));
  }
}

///
///
///Body
///
///
class CategoryTile extends StatelessWidget {
  String imgUrl, title, desc, url;
  CategoryTile(
      {required this.desc,
      required this.imgUrl,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    // print(imgUrl);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(imgUrl: url),
            ));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ))),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
