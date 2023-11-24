import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';

class FormButton extends StatelessWidget {
  FormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> FormPage()));
      },
      label: Text('글쓰기'),
      icon: const Icon(Icons.edit_outlined),
    );
  }
}


class FormPage extends StatelessWidget {
  FormPage({super.key});
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _addressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('리뷰글 작성하기')),
      body: ListView(
        children: [
          // 사진 업로드
          const UploadImage(),
          const Divider(),
          // 주소
          const Text('주소', style: TextStyle(fontWeight: FontWeight.bold)),
          // 주소 찾기 api
          TextField(
            controller: _addressController,
            readOnly: true,
            onTap: () async {
              Kpostal result = await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => KpostalView()));
              _addressController.text = result.jibunAddress;
            },
            decoration: const InputDecoration(
              hintText: '주소를 입력해주세요',
            ),
          ),
          // 제목
          const Text('제목', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 300,
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: '제목',
                  border: OutlineInputBorder(),
          ))),
          const SizedBox(
            height: 20,
          ),
          // 내용
          Text('자세한 설명', style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          SizedBox(
            width: 300,
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: '게시글 내용을 작성해 주세요',
                  border: OutlineInputBorder(),
            ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
          )),
          Container(
            color: Colors.cyan,
            height: 100,
          ),
          Container(
            color: Colors.green,
            height: 100,
          ),
          Container(
            color: Colors.pink,
            height: 100,
          )

        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: (){

            }, child: const Text('작성 완료'),
          )),
    );
  }
}

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
        child: ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        SizedBox(
          width: 100,
          child: ElevatedButton(onPressed: () async {
            var picker = ImagePicker();
            var images = await picker.pickMultiImage();

          }, style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
          ), child: const Icon(Icons.photo_camera, size: 25),),
        ),
        Container(
          width: 100,
          color: Colors.grey,
          padding: const EdgeInsets.all(20),
        ),
        Container(
          width: 100,
          color: Colors.blue,
          padding: const EdgeInsets.all(20),
        ),
        Container(
          width: 100,
          color: Colors.red,
          padding: const EdgeInsets.all(20),
        ),
        Container(
          color: Colors.orange,
          padding: const EdgeInsets.all(20),
        ),
        Container(
          color: Colors.yellow,
          padding: const EdgeInsets.all(20),
        ),
        Container(
          color: Colors.green,
          padding: const EdgeInsets.all(20),
        ),
        Container(
          color: Colors.purple,
          padding: const EdgeInsets.all(20),
        ),
      ],
    ),
    );
  }
}
