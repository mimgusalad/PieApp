import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../Storage/review_storage.dart';
import '../Storage/succ_storage.dart';
import 'review_detail.dart' as reviewDetail;
import 'succ_detail.dart' as succDetail;

const DEFAULt_IMAGE_URL =
    'https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg';

class Cards extends StatelessWidget {
  const Cards({super.key, this.index, this.info});

  final index;
  final info;

  @override
  Widget build(BuildContext context) {
    final review = info['review_article'];
    final _rating = review['rating'] / 2;
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Get.toNamed(
                  '/review_detail/${context.read<ReviewStorage>().reviewId}',
                  arguments: info);
            },
            child: SizedBox(
                width: 365,
                height: 200,
                child: Stack(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              info['img_url'].isNotEmpty
                                  ? info['img_url'][0]
                                  : DEFAULt_IMAGE_URL,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 1, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          review['contentTitle'] ??
                                              "(제목이 없는 리뷰글)",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          review['address'],
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 8),
                                        child: Text(
                                          review['addressDetail'] ?? '',
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                        )),
                                    RatingBar.builder(
                                        itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber),
                                        initialRating: _rating,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        ignoreGestures: true,
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        })
                                  ],
                                )),
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            review['contentText'] ?? "(내용이 없는 리뷰글)",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ]),
                  const Positioned(
                      bottom: 4,
                      right: 13,
                      child:
                          Icon(Icons.more_horiz_outlined, color: Colors.grey))
                ]))),
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
    final review = info['succession_article'];
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Get.toNamed('/succ_detail', arguments: info);
            },
            child: SizedBox(
                width: 365,
                height: 200,
                child: Stack(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              info['img_url'] != null
                                  ? info['img_url'][0]
                                  : DEFAULt_IMAGE_URL,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 1, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          review['contentTitle'] ??
                                              "(제목이 없는 리뷰글)",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Text(
                                          review['address'],
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                        child:Text(
                                          review['addressDetail'] ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                    )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Text('작성자: ' + info['userInfo']['nickname'] ?? ''))
                                  ],
                                )),
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            review['contentText'] ?? "(내용이 없는 리뷰글)",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ]),
                  const Positioned(
                      bottom: 4,
                      right: 13,
                      child:
                          Icon(Icons.more_horiz_outlined, color: Colors.grey))
                ]))),
      ),
    );
  }
}
