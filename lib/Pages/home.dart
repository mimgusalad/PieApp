import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../storage.dart' as store;
import './form.dart' as form;
import './card.dart' as cards;

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('리뷰')
        ),
        body: RefreshIndicator( // pull to refresh
          onRefresh: () {
            return context.read<store.ReviewStorage>().getReviews(); // get any new data when pulled down
          },
          child: ListView.builder( // review data
          itemCount: context.watch<store.ReviewStorage>().reviews.length,
          itemBuilder:(context, index) {
            return cards.Cards(index: index, info: context.watch<store.ReviewStorage>().reviews[index]);
          })),
        floatingActionButton: form.FormButton()
    );
  }
}


