import 'package:flutter/material.dart';

class ProductWritePictureArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imgUrls = [
      'https://picsum.photos/200/300',
      'https://picsum.photos/200/300'
    ];
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...imgUrls.map((e) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    e,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              print('이미지 업로드 하기');
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.grey),
                    Text(
                      '${imgUrls.length}/10',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
