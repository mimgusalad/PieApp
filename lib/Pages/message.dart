import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

const APP_ID = '4E4C060D-17A6-4CC6-84EA-47D1C87A1F43';

void main() {
  runZonedGuarded(() async {
    // USER_ID should be a unique string to your Sendbird application.
    final user = await SendbirdChat.connect('test_id1');
    // The user is connected to the Sendbird server.
  }, (e, s) {
    // Handle error.
  });
}

class Chat extends StatelessWidget {
  Chat({super.key}){
    SendbirdChat.init(appId: APP_ID);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
