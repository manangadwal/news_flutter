// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/helper/data.dart';
import 'package:news_flutter/helper/news_Articles.dart';
import 'package:news_flutter/models/article_model.dart';
import 'package:news_flutter/models/category_model.dart';
import 'package:news_flutter/views/article_view.dart';
import 'package:news_flutter/views/category_news.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///
  ///
  ///
  ///
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool loading = true;

  ///
  ///
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(categories);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            ///
            ///Categories
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Container(
                height: 60,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (Context, idx) {
                      return CategoryTile(
                        CategoryName: categories[idx].categoryName,
                        imageUrl: categories[idx].imageUrl,
                      );
                    }),
              ),
            ),

            ///
            ///
            ///
            ///Body
            ///
            Container(
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
                      itemCount: articles.length,
                      itemBuilder: (context, idx) {
                        return BlogTiles(
                          desc: articles[idx].desc,
                          imgUrl: articles[idx].urltoImg,
                          title: articles[idx].title,
                          url: articles[idx].url,
                        );
                      }),
            )
          ],
        )),
      ),
    );
  }
}

///
///
///
///Creating Category tiles
///
///
///
class CategoryTile extends StatelessWidget {
  String imageUrl, CategoryName;

  CategoryTile({required this.CategoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: CategoryName.toString().toLowerCase(),
                      title: CategoryName,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5, left: 5),
        width: 120,
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl.toString(),
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(6)),
                height: 60,
                width: 120,
                child: Text(
                  CategoryName.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///
///
///
///BLOG TILES
///
///
///
class BlogTiles extends StatelessWidget {
  String imgUrl, title, desc, url;
  BlogTiles(
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
///
///
///
///
///
///
///
///
// ///onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ArticleView(imgUrl: url)));
//       },