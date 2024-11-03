import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/welcome/welcome_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // ProviderScope 로 앱을 감싸서 RiverPod이 ViewModel 관리할 수 있게 선언
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        // 나중에 앱 메인 색상 쓸 때를 대비하여 정의!
        highlightColor: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            // 버튼 내 텍스트나 아이콘 위젯 색상
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            backgroundColor: WidgetStatePropertyAll(Colors.orange),
            // 사이즈 설정. 안하면 ElevatedButton은 자녀 위젯의 크기로 축소됨!
            minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // BorderRadius 설정!
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          // TextField의 내부 여백
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          // TextField의 상태가 변경(포커스 받았을때, 아닐때, 유효성 검사 에러 등) 시 호출
          border: MaterialStateOutlineInputBorder.resolveWith(
            (states) {
              // print(states);
              if (states.contains(WidgetState.focused)) {
                return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                );
              } else if (states.contains(WidgetState.error)) {
                return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.red[100]!,
                    width: 2,
                  ),
                );
              }
              return OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              );
            },
          ),
        ),
      ),
      home: WelcomePage(),
    );
  }
}
