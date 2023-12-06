import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/card.dart' as cards;
import '../Components/form.dart' as form;
import '../Storage/favorite_storage.dart';

class Page extends StatefulWidget {
  const Page({super.key});
  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavoriteStorage>().getMyFavorite();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('북마크'),
      ),
      body: RefreshIndicator( // pull to refresh
        onRefresh: () {
          return context.read<FavoriteStorage>().getMyFavorite(); // get any new data when pulled down
        },
        child: ListView.separated( // review data
          itemCount: context.watch<FavoriteStorage>().myFav.length,
          itemBuilder:(context, index) {
            return cards.Cards(index: index, info: context.watch<FavoriteStorage>().myFav[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
      floatingActionButton: form.FormButton(),
    );
  }
}
