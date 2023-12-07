import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie/DTO/succ.dart';
import 'package:provider/provider.dart';
import '../Storage/succ_storage.dart';
import '../Storage/url.dart';


class Page extends StatelessWidget {
  Page({super.key});
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    SuccArticle info = Get.arguments;
    var writer = info.user;
    return Scaffold(
      appBar: AppBar(), //이렇게 해야 뒤로가기 버튼 생김
      body: Stack(
        children: [
          CarouselSlider(
            items: info.img_url.isNotEmpty
                ? info.img_url
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
        child: FilledButton(
          child: Text('연락하기!'),
          onPressed: () {
            // 작성자와 채팅하기
            context.read<SuccStorage>().setChatChannelUrl('dakjijisalad@gmail.com', writer.email);
            debugPrint('');
            Get.toNamed('/group_channel/${Provider.of<SuccStorage>(context, listen: false).chatChannelUrl}', arguments: writer.name);
            },
        ),
      )
      );
  }
}
