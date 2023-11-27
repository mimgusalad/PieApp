import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Storage/succ_storage.dart';
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
          return context.read<SuccStorage>().getArticles(); // get any new data when pulled down
        },
        child: ListView.separated( // review data
        itemCount: context.watch<SuccStorage>().articles.length,
        itemBuilder:(context, index) {
          return cards.SuccCards(index: index, info: context.watch<SuccStorage>().articles[index]);
        }, separatorBuilder: (BuildContext context, int index) {return const SizedBox(height: 8);  },)),
      floatingActionButton: form.FormButton()
    );
  }
}
