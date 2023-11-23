import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../storage.dart' as store;
import './detail.dart' as detail;

class Cards extends StatelessWidget {
  const Cards({super.key, this.index, this.info});
  final index;
  final info;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: (){
                context.read<store.ReviewStorage>().setReviewId(info['articleNo']);
                context.read<store.ReviewStorage>().getReviewById();
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=> detail.Page()));
              },
              child: SizedBox(
                width: 350,
                height: 150,
                child: Text(info['contentTitle']?? "(제목이 없는 리뷰글)"),
              )
          ),
      ),
    );
  }
}

class SuccCards extends StatelessWidget {
  const SuccCards({super.key, this.index, this.info});
  final index;
  final info;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: (){
              context.read<store.SuccStorage>().setArticleId(info['articleNo']);
              context.read<store.SuccStorage>().getArticleById();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> detail.Page()));
            },
            child: SizedBox(
              width: 350,
              height: 150,
              child: Text(info['contentTitle']?? "(제목이 없는 리뷰글)"),
            )
        ),
      ),
    );
  }
}
