import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/join/join_page.dart';

class AddressSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // 이 텍스트 필드는 재활용할 필요 없음
          title: TextField(
            onSubmitted: (value) {
              print("onSubmitted");
            },
            decoration: InputDecoration(
              hintText: '동명(읍,면)으로 검색 (ex. 서초동)',
              // 이 텍스트 필드 contentPadding으로 사이즈 조정
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              // ElevatedButton 사이즈 줄이기(얘만)
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: Text('현재 위치로 찾기'),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return JoinPage();
                          },
                        ));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        // 터치영역 설정을 위해 색상 지정
                        color: Colors.transparent,
                        child: Text(
                          '부산광역시 동래구 온천동',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
