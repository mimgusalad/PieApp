import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../DTO/review.dart';
import '../DTO/succ.dart';
import '../Storage/url.dart';

class Cards extends StatelessWidget {
  Cards({super.key, this.index, required this.info});

  final index;
  Review info;

  @override
  Widget build(BuildContext context) {
    final review = info.article;
    final _rating = review.rating! / 2;
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Get.toNamed('/review_detail',
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
                              info.img_url.isNotEmpty
                                  ? info.img_url[0]
                                  : DEFAULT_IMAGE_URL,
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
                                          review.contentTitle ??
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
                                          review.address??'',
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 8),
                                        child: Text(
                                          review.addressDetail ?? '',
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
                            review.contentText ?? "(내용이 없는 리뷰글)",
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
  SuccCards({super.key, this.index, required this.info});

  final index;
  SuccArticle info;

  @override
  Widget build(BuildContext context) {
    final review = info.article;
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
                              info.img_url!.isNotEmpty
                                  ? info.img_url[0]
                                  : DEFAULT_IMAGE_URL,
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
                                          review.contentTitle ??
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
                                          review.address??'',
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                        child:Text(
                                          review.addressDetail ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                    )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Text('작성자: ${info.user?.nickname}' ?? ''))
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
                            review.contentText ?? "(내용이 없는 리뷰글)",
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
