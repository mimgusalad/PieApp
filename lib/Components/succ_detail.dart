import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Storage/succ_storage.dart';

const DEFAULT_IMAGE = 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    var info = context.watch<SuccStorage>().articleById['succession_article'];
    var writer = context.watch<SuccStorage>().articleById['userInfo'];
    debugPrint('info: $info');
    debugPrint('writer: $writer');
    return Scaffold(
      appBar: AppBar(), //이렇게 해야 뒤로가기 버튼 생김
      body: Column(
          children: [
            Image.network(DEFAULT_IMAGE),
            Text(info.toString()),
            Text(writer.toString()),
          ]
      ),
      bottomNavigationBar: BottomAppBar(
        child: FilledButton(
          child: Text('연락하기!'),
          onPressed: () {
            // 작성자와 채팅하기
            // 일대일 대화방 만들어야함
            context.read<SuccStorage>().setChatChannelUrl(writer['email']);
            Get.toNamed('/group_channel/${Provider.of<SuccStorage>(context, listen: false).chatChannelUrl}', arguments: writer['nickname']);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context)=> const succDetail.Page()));
          },
        ),
      )
      );
  }
}
