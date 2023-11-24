import 'package:flutter/material.dart';
import '../Components/card.dart' as cards;
import '../Components/form.dart' as form;

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('북마크'),
      ),
      body: ListView(
        children: const [
          cards.SuccCards(),
          cards.SuccCards(),
          cards.SuccCards(),
          cards.SuccCards(),
          cards.SuccCards(),
          cards.SuccCards(),
        ],
      ),
      floatingActionButton: form.FormButton(),
    );
  }
}
