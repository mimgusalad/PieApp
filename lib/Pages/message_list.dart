import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

const DEFAULT_PROFILE_URL = 'https://i.namu.wiki/i/c721JBCTktfPQORgQl2yMtmhJEQ-CLrydaN6qeO0BtISaAr6sVJ3a1b6PJb2ymRrmOPBFVniqgcUm5tHG2Te4Ijsdd0GonglRJI7HYFdqwy8vzrsuNQKX_3XPsKxg8u9K2qcVSgsx-WIqQaI60dVfA.webp';

class ChannelList extends StatefulWidget {
  const ChannelList({super.key});

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  late GroupChannelCollection collection;
  bool hasMore = false;
  String title = 'groupChannels';
  List<GroupChannel> channelList = [];

  @override
  initState() {
    // TODO: implement initStat
    super.initState();
    collection = GroupChannelCollection(
      query: GroupChannelListQuery()
        ..order = GroupChannelListQueryOrder.latestLastMessage
        ..myMemberStateFilter = MyMemberStateFilter.joined
        ..includeEmpty = true,
      handler: MyGroupChannelCollectionHandler(this),
    )
      ..loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메세지'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _list(),
          ),
        ],
      ),
    );
  }


  Widget _list() {
    return ListView.builder(
        itemCount: channelList.length,
        itemBuilder: (context, index) {
          debugPrint('channel members: ${channelList[index].members.first.userId}, ${channelList[index].members.last.userId}');
          final groupChannel = channelList[index];
          return GestureDetector(
              child: Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Get.toNamed('/group_channel/${groupChannel.channelUrl}', arguments:
                          groupChannel.members?.first.nickname != SendbirdChat.currentUser?.nickname
                              ? groupChannel.members?.first.nickname ?? ''
                              : groupChannel.members?.last.nickname ?? '')
                              ?.then((_) => _refresh());
                        },
                        subtitle: Row(
                            children: [
                              // 상대발 프로필
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    groupChannel.members.first.userId != SendbirdChat.currentUser?.userId
                                        ? groupChannel.members.first.profileUrl.isNotEmpty
                                        ? groupChannel.members.first.profileUrl : DEFAULT_PROFILE_URL
                                        : groupChannel.members.last.profileUrl.isNotEmpty
                                        ? groupChannel.members.last.profileUrl : DEFAULT_PROFILE_URL
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        // 상대방 닉네임
                                        groupChannel.members?.first.nickname != SendbirdChat.currentUser?.nickname
                                        ? groupChannel.members?.first.nickname ?? ''
                                            : groupChannel.members?.last.nickname ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(width: 10),
                                      Text('${DateTime.fromMillisecondsSinceEpoch(groupChannel.lastMessage!.createdAt).
                                      toString().substring(11, 16)}'),
                                      // 안 읽은 톡 몇갠지
                                      groupChannel.unreadMessageCount > 0
                                      ? const Icon(Icons.notifications,
                                          color: Colors.red, size: 15)
                                          : const SizedBox(),
                                      Text(groupChannel.unreadMessageCount > 0
                                          ? groupChannel.unreadMessageCount.toString()
                                          : '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      width: 260,
                                      child:  Text(groupChannel.lastMessage?.message ?? '',
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ),
                                ],
                              ),
                            ]
                        )),
                    const Divider(
                      height: 10,
                    ),
                  ]
              ));
        }
    );
  }


  void _refresh() {
    setState(() {
      channelList = collection.channelList;
      title = channelList.isEmpty
          ? 'GroupChannels'
          : 'GroupChannels (${channelList.length})';
      hasMore = collection.hasMore;
    });
  }
}

class MyGroupChannelCollectionHandler extends GroupChannelCollectionHandler {
  final _ChannelListState state;

  MyGroupChannelCollectionHandler(this.state);

  @override
  void onChannelsAdded(GroupChannelContext context,
      List<GroupChannel> channels) {
    state._refresh();
  }

  @override
  void onChannelsUpdated(GroupChannelContext context,
      List<GroupChannel> channels) {
    state._refresh();
  }

  @override
  void onChannelsDeleted(GroupChannelContext context,
      List<String> deletedChannelUrls) {
    state._refresh();
  }
}