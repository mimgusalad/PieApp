import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../storage.dart' as store;
import '../Components/form.dart' as form;
import '../Components/card.dart' as cards;

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('승계 글 목록')
      ),
      body: RefreshIndicator( // pull to refresh
        onRefresh: () {
          return context.read<store.SuccStorage>().getArticles(); // get any new data when pulled down
        },
        child: ListView.builder( // review data
        itemCount: context.watch<store.SuccStorage>().articles.length,
        itemBuilder:(context, index) {
          return cards.SuccCards(index: index, info: context.watch<store.SuccStorage>().articles[index]);
        })),
      floatingActionButton: form.FormButton()
    );
  }
}
