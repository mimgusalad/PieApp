import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import '../Storage/image_storage.dart';
import 'package:intl/intl.dart';

class FormButton extends StatelessWidget {
  const FormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormPage()));
      },
      label: Text('글쓰기'),
      icon: const Icon(Icons.edit_outlined),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _addressController = TextEditingController();
  final _addressDetailController = TextEditingController();
  final _houseTypeController = TextEditingController();
  final _paymentController = TextEditingController();
  final _depositController = TextEditingController();
  final _utilityController = TextEditingController();
  final _livingYearController = TextEditingController();
  final _feeController = TextEditingController();
  final _ratingController = TextEditingController();
  final _picker = ImagePicker();

  final List<XFile?> _pickedImages = [];

  @override
  Widget build(BuildContext context) {
    double imgBoxSize = ((MediaQuery.of(context).size.width - 32) / 5) - 4;
    final images = context.watch<ImageStorage>().pickedImages;
    return Scaffold(
      appBar: AppBar(title: const Text('리뷰글 작성하기')),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ImageUploader(),
              ...images.map((e) => _ImageContainer(e!, imgBoxSize)).toList(),
            ],
          ),
          const Divider(
            height: 30,
          ),

          // 주소
          const Text('주소', style: TextStyle(fontWeight: FontWeight.bold)),
          // 주소 찾기 api
          TextField(
            controller: _addressController,
            readOnly: true,
            onTap: () async {
              Kpostal result = await Navigator.push(
                  context, MaterialPageRoute(builder: (_) => KpostalView()));
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
          Text('자세한 설명',
              style: TextStyle(
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
          Text('주택 유형',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
              width: 300,
              child: TextField(
                  controller: _houseTypeController,
                  decoration: const InputDecoration(
                    hintText: '원룸, 투룸, 아파트, 오피스텔 등',
                    border: OutlineInputBorder(),
                  ))),
          Text('전월세',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
              width: 300,
              child: TextField(
                  controller: _paymentController,
                  decoration: const InputDecoration(
                    hintText: '전세, 월세, 사글세, 연세, 등',
                    border: OutlineInputBorder(),
                  ))),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '보증금',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _depositController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffix: Text('만원'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '월세',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _feeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          suffix: Text('만원'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '관리비',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _utilityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          suffix: Text('만원'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Text('입주년도',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
              width: 300,
              child: TextField(
                  controller: _livingYearController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    hintText: 'YYYY',
                    border: OutlineInputBorder(),
                  ))),
          Text('평점',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Center(
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: FilledButton(
        onPressed: () {
          context.read<ImageStorage>().submitImage();
          //Navigator.pop(context);
        },
        child: const Text('작성 완료'),
      )),
    );
  }

  Widget ImageUploader() {
    return InkWell(
      onTap: () async {
        List<XFile> images = await _picker.pickMultiImage();
        if (!mounted) return;
        if (images != null) {
          context.read<ImageStorage>().addImage(images);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: MediaQuery.of(context).size.width * 0.17,
        height: MediaQuery.of(context).size.width * 0.17,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, color: Colors.grey[400]!),
            const SizedBox(
              height: 5,
            ),
            Text(
              'image',
              style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _ImageContainer(XFile e, double imgBoxSize) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: imgBoxSize,
        height: imgBoxSize,
        child: Stack(children: [
          Center(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.file(File(e.path)).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10)),
            width: imgBoxSize,
            height: imgBoxSize,
          )),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(20, -20),
              child: IconButton(
                onPressed: () {
                  context.read<ImageStorage>().deleteImage(e);
                },
                icon: Container(
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          )
        ]));
  }
}
