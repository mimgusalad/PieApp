import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie/DTO/review.dart';
import 'package:provider/provider.dart';
import '../Storage/review_storage.dart' as store;
import '../Storage/favorite_storage.dart';
import '../Storage/url.dart';

class Page extends StatefulWidget {
  Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  var likeIcon = [
    const Icon(Icons.favorite_outline),
    const Icon(Icons.favorite_outlined)
  ];
  var liked;
  final Review review = Get.arguments;

  initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    bool isFavorite = await context
        .read<FavoriteStorage>()
        .checkIfFavorite(review.article.articleNo);
    setState(() {
      liked = isFavorite ? 1 : 0;
    });
  }

  setLike() {
    setState(() {
      liked = ++liked % 2;
    });
  }

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            items: review.img_url.isNotEmpty
                ? review.img_url
                .map(
                  (item) => Center(
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            )
                .toList()
                : [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(DEFAULT_IMAGE_URL),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 400,
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 1,
            ),
            carouselController: _controller,
          ),
          Positioned(
            top: 25,
            left: 5,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 30, ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('즐겨찾기'),
            IconButton(
                onPressed: () {
                  setLike();
                  context
                      .read<FavoriteStorage>()
                      .setFavorite(review.article.articleNo);
                },
                icon: liked != null ? likeIcon[liked] : likeIcon[0]),
          ],
        ),
      ),
    );
  }
}
