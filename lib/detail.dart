import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './storage.dart' as store;

class Page extends StatefulWidget {
  Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  var likeIcon = [const Icon(Icons.favorite_outline), const Icon(Icons.favorite_outlined)];
  var liked = 0;

  setLike(){
    setState(() {
      liked = ++liked % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('여기에 주소 넣으면 짤릴듯'),),
      body: Text(
        context.watch<store.ArticleStorage>().reviewById.toString()
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('즐겨찾기'),
            IconButton(onPressed: (){
              setLike();
            }, icon: likeIcon[liked]),
          ],
        ),
      ),
    );
  }
}
