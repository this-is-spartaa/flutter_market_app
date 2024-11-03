import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/address_search/address_search_page.dart';
import 'package:flutter_market_app/ui/pages/login/login_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar를 사용하지 않기 때문에 SafeArea 사용!!!
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          // Column의 기본 너비는 chlidred 중 가장 넓은 위젯의 너비. 글자 가로 중앙정렬을 위해 너비 디바이스 너비로!
          child: SizedBox.expand(
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  "assets/welcome.png",
                  height: 250,
                ),
                Text(
                  "당신 근처의 마켓",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "동네라서 가능한 모든것\n지금 내 동네를 선택하고 시작해보세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AddressSearchPage();
                      },
                    ));
                  },
                  child: Text("시작하기"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '이미 계정이 있나요? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '로그인',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
