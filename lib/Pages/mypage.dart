import 'package:flutter/material.dart';
import './card.dart' as cards;
import 'package:provider/provider.dart';
import '../storage.dart' as store;

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: RefreshIndicator(
          child: ListView(
            children: [
              const ProfileHeader(),
              Text('작성한 리뷰', style: TextStyle(fontSize: 20)),
              ListView.builder(itemBuilder: (context, index){
                return cards.Cards(index: index, info: context.watch<store.ReviewStorage>().myReviews[index]);
              },
                itemCount: context.watch<store.ReviewStorage>().myReviews.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
          onRefresh: () {
            // get any new data when pulled down
            return context.read<store.ReviewStorage>().getMyReviews();
          },)
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

