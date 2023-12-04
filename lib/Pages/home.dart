import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../DTO/review.dart';
import '../Storage/review_storage.dart';
import '../Components/form.dart' as form;
import '../Components/card.dart' as cards;

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
            return context.read<ReviewStorage>().getReviews(); // get any new data when pulled down
          },
          child: ListView.separated( // review data
          itemCount: context.watch<ReviewStorage>().reviews.length,
          itemBuilder:(context, index) {
            Review review = context.watch<ReviewStorage>().reviews[index];
            return cards.Cards(index: index, info: review);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          ),
        ),
        floatingActionButton: form.FormButton()
    );
  }
}


