import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 만들기 => int 사용
// 2. 뷰모델 만들기
class HomeViewModel extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 0;
  }

  void onIndexChanged(int newIndex) {
    state = newIndex;
  }
}

// 2. 뷰모델 관리자 만들기
final homeViewModel =
    NotifierProvider.autoDispose<HomeViewModel, int>(() => HomeViewModel());
