import 'package:flutter/material.dart';
import './card.dart' as cards;

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: ListView(
        children: const [
          ProfileHeader(),
          Text('작성한 리뷰', style: TextStyle(fontSize: 20)),
          cards.Cards(),
          cards.Cards(),
          cards.Cards(),
          cards.Cards(),
          cards.Cards(),
        ],
      )
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 15,),
          const CircleAvatar(
            // backgroundImage: , 프로필 이미지
            backgroundColor: Colors.green,
            radius: 70,
          ),
          const SizedBox(height: 10,),
          const Text('사용자 이름', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 5,),
          ElevatedButton(onPressed: (){
            // 정보 수정
          }, child: const Text('정보 수정하기')),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}

