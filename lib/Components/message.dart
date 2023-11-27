import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../Pages/message_list.dart' as message;

const DEFAULT_PROFILE_URL = 'https://i.namu.wiki/i/c721JBCTktfPQORgQl2yMtmhJEQ-CLrydaN6qeO0BtISaAr6sVJ3a1b6PJb2ymRrmOPBFVniqgcUm5tHG2Te4Ijsdd0GonglRJI7HYFdqwy8vzrsuNQKX_3XPsKxg8u9K2qcVSgsx-WIqQaI60dVfA.webp';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final channelUrl = Get.parameters['channel_url'];
  final itemScrollController = ItemScrollController();
  final textEditingController = TextEditingController();
  final currentUser = SendbirdChat.currentUser;
  MessageCollection? collection;

  String title = '';
  bool hasPrevious = false;
  bool hasNext = false;
  List<BaseMessage> messageList = [];
  List<String> memberIdList = [];

  final _nickname = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeMessageCollection();
  }

  void _initializeMessageCollection() {
    GroupChannel.getChannel(channelUrl!).then((channel) {
      collection = MessageCollection(
        channel: channel,
        params: MessageListParams(),
        handler: MyMessageCollectionHandler(this),
      )..initialize();

      setState(() {
        title = '${channel.name} (${messageList.length})';
        memberIdList = channel.members.map((member) => member.userId).toList();
        memberIdList.sort((a, b) => a.compareTo(b));
      });
    });
  }

  void _disposeMessageCollection() {
    collection?.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disposeMessageCollection();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_nickname),
        actions: [
          // 채팅방 나가기 버튼
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await collection?.channel.leave();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          hasPrevious ? _previousButton() : Container(),
          Expanded(
            child: (collection != null && collection!.messageList.isNotEmpty)
                ? _list()
                : Container(),
          ),
          hasNext ? _nextButton() : Container(),
          _messageSender(),
        ],
      ),
    );
  }


  Widget _previousButton() {
    return Container(
      width: double.maxFinite,
      height: 32.0,
      color: Colors.purple[200],
      child: IconButton(
        icon: const Icon(Icons.expand_less, size: 16.0),
        color: Colors.white,
        onPressed: () async {
          if (collection != null) {
            if (collection!.params.reverse) {
              if (collection!.hasNext && !collection!.isLoading) {
                await collection!.loadNext();
              }
            } else {
              if (collection!.hasPrevious && !collection!.isLoading) {
                await collection!.loadPrevious();
              }
            }
          }

          setState(() {
            if (collection != null) {
              hasPrevious = collection!.hasPrevious;
              hasNext = collection!.hasNext;
            }
          });
        },
      ),
    );
  }

  Widget _list() {
    return ScrollablePositionedList.builder(
      physics: const ClampingScrollPhysics(),
      initialScrollIndex: (collection != null && collection!.params.reverse)
          ? 0
          : messageList.length - 1,
      itemScrollController: itemScrollController,
      itemCount: messageList.length,
      itemBuilder: (BuildContext context, int index) {
        BaseMessage message = messageList[index];
        final unreadMembers = (collection != null)
            ? collection!.channel.getUnreadMembers(message)
            : [];

        return GestureDetector(
          onDoubleTap: () async {
            if (message is UserMessage) {
              final groupChannel = await GroupChannel.getChannel(channelUrl!);
              Get.toNamed(
                  '/message/update/${groupChannel.channelType.toString()}/${groupChannel.channelUrl}/${message.messageId}')
                  ?.then((message) async {
                if (message != null) {
                  for (int index = 0; index < messageList.length; index++) {
                    if (messageList[index].messageId == message.messageId) {
                      setState(() => messageList[index] = message);
                      break;
                    }
                  }
                }
              });
            }
          },
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child:
                          // 보낸 사람이 현재 사용자면 오른쪽에 보여주고 아니면 왼쪽에 보여주는거
                          message.sender!.isCurrentUser ? Container(
                            //내가 보낸거
                            alignment: Alignment.bottomRight,
                            child: _myMessage(message.message, message.createdAt, unreadMembers.isNotEmpty ? '1' : ''),
                          ) : Container(
                            // 상대방이 보낸거
                            alignment: Alignment.centerLeft,
                            child: _hisMessage(
                                message.message,
                                message.sender!.profileUrl.isNotEmpty
                                    ? message.sender?.profileUrl
                                    : DEFAULT_PROFILE_URL
                                , message.createdAt),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _hisMessage(
      String? message,
      String? profileUrl,
      int createdAt,
      ){
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상대방 프로필 사진만 보여주는거
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                profileUrl ?? ''),
          ),
          const SizedBox(width: 10),
          // 톡 내용 보여주는거
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 톡 내용 보여주는거
              _bubble(message, Colors.grey, Colors.black),
              // 톡 보낸 날짜 오른쪽 아래에 보여주는거
              Container(
                margin: const EdgeInsets.only(left: 16),
                alignment: Alignment.centerRight,
                child: Text(
                  DateTime.fromMillisecondsSinceEpoch(createdAt)
                      .toString().substring(11, 16),
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _myMessage(
      String? message,
      int createdAt,
      String unreadMessageCount,
      ){
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 톡 안 읽은 사람 수 보여주는거
          Container(
            alignment: Alignment.centerRight,
            child: Text(unreadMessageCount,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(width: 5),
          // 톡 보낸 날짜 왼쪽 아래에 보여주는거
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Text(
              DateTime.fromMillisecondsSinceEpoch(createdAt)
                  .toString().substring(11, 16),
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
          // 톡 내용 보여주는거
          _bubble(message, Colors.black, Colors.white),
        ],
      )
    );
  }

  Widget _bubble(
      String? text, Color backgroundColor, Color textColor
      ){
    return Container(
      constraints: BoxConstraints(
        maxWidth: 250,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text!,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }

  Widget _nextButton() {
    return Container(
      width: double.maxFinite,
      height: 32.0,
      color: Colors.purple[200],
      child: IconButton(
        icon: const Icon(Icons.expand_more, size: 16.0),
        color: Colors.white,
        onPressed: () async {
          if (collection != null) {
            if (collection!.params.reverse) {
              if (collection!.hasPrevious && !collection!.isLoading) {
                await collection!.loadPrevious();
              }
            } else {
              if (collection!.hasNext && !collection!.isLoading) {
                await collection!.loadNext();
              }
            }
          }

          setState(() {
            if (collection != null) {
              hasPrevious = collection!.hasPrevious;
              hasNext = collection!.hasNext;
            }
          });
        },
      ),
    );
  }

  // 내가 메세지 입력하는 창, bottombar에 위치
  Widget _messageSender() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
            // message text controller
            child: TextField(controller: textEditingController),
          ),
          const SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              if (textEditingController.value.text.isEmpty) {
                return;
              }
              collection?.channel.sendUserMessage(
                UserMessageCreateParams(
                  message: textEditingController.value.text,
                ),
                handler: (UserMessage message, SendbirdException? e) async {
                  if (e != null) {
                    await _showDialogToResendUserMessage(message);
                  }
                },
              );

              textEditingController.clear();
            },
            child: const Text('전송'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogToResendUserMessage(UserMessage message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text('Resend: ${message.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  collection?.channel.resendUserMessage(
                    message,
                    handler: (message, e) async {
                      if (e != null) {
                        await _showDialogToResendUserMessage(message);
                      }
                    },
                  );

                  Get.back();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  void _refresh({bool markAsRead = false}) {
    if (markAsRead) {
      SendbirdChat.markAsRead(channelUrls: [channelUrl??'']);
    }

    setState(() {
      if (collection != null) {
        messageList = collection!.messageList;
        title = '${collection!.channel.name} (${messageList.length})';
        hasPrevious = collection!.params.reverse
            ? collection!.hasNext
            : collection!.hasPrevious;
        hasNext = collection!.params.reverse
            ? collection!.hasPrevious
            : collection!.hasNext;
        memberIdList =
            collection!.channel.members.map((member) => member.userId).toList();
        memberIdList.sort((a, b) => a.compareTo(b));
      }
    });
  }

  void _scrollToAddedMessages(CollectionEventSource eventSource) async {
    if (collection == null || collection!.messageList.length <= 1) return;

    final reverse = collection!.params.reverse;
    final previous = eventSource == CollectionEventSource.messageLoadPrevious;

    final int index;
    if ((reverse && previous) || (!reverse && !previous)) {
      index = collection!.messageList.length - 1;
    } else {
      index = 0;
    }

    while (!itemScrollController.isAttached) {
      await Future.delayed(const Duration(milliseconds: 1));
    }

    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class MyMessageCollectionHandler extends MessageCollectionHandler {
  final _MessageState _state;

  MyMessageCollectionHandler(this._state);

  @override
  void onMessagesAdded(MessageContext context, GroupChannel channel,
      List<BaseMessage> messages) async {
    _state._refresh(markAsRead: true);

    if (context.collectionEventSource !=
        CollectionEventSource.messageInitialize) {
      Future.delayed(
        const Duration(milliseconds: 100),
            () => _state._scrollToAddedMessages(context.collectionEventSource),
      );
    }
  }

  @override
  void onMessagesUpdated(MessageContext context, GroupChannel channel,
      List<BaseMessage> messages) {
    _state._refresh();
  }

  @override
  void onMessagesDeleted(MessageContext context, GroupChannel channel,
      List<BaseMessage> messages) {
    _state._refresh();
  }

  @override
  void onChannelUpdated(GroupChannelContext context, GroupChannel channel) {
    _state._refresh();
  }

  @override
  void onChannelDeleted(GroupChannelContext context, String deletedChannelUrl) {
    Get.offAll(() => const message.ChannelList());
  }

  @override
  void onHugeGapDetected() {
    _state._disposeMessageCollection();
    _state._initializeMessageCollection();
  }
}