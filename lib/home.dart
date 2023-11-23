import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './storage.dart' as store;
import './form.dart' as form;
import './card.dart' as cards;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<store.ArticleStorage>().getReviews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰')
      ),
      body: ListView.builder(
        itemCount: context.watch<store.ArticleStorage>().reviews.length,
        itemBuilder:(context, index) {
          return cards.Cards(index: index, info: context.watch<store.ArticleStorage>().reviews[index]);
        },
      ),
      floatingActionButton: form.FormButton()
    );
  }
}

