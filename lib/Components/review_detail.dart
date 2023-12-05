import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie/DTO/review.dart';
import 'package:provider/provider.dart';
import '../Storage/review_storage.dart' as store;
import '../Storage/favorite_storage.dart';


class Page extends StatefulWidget {
  Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  var likeIcon = [const Icon(Icons.favorite_outline), const Icon(Icons.favorite_outlined)];
  var liked;
  final Review review = Get.arguments;

  initState(){
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    bool isFavorite = await context.read<FavoriteStorage>().checkIfFavorite(review.article.articleNo);
    setState(() {
      liked = isFavorite ? 1 : 0;
    });
  }

  setLike(){
    setState(() {
      liked = ++liked % 2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(review.article.contentTitle??'제목없음'),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('즐겨찾기'),
            IconButton(onPressed: (){
              setLike();
              context.read<FavoriteStorage>().setFavorite(review.article.articleNo);
            }, icon: liked != null ? likeIcon[liked] : likeIcon[0]),
          ],
        ),
      ),
    );
  }
}
