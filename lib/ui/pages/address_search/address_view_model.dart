import 'package:flutter_market_app/data/repository/vworld_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태만들기 => List<String> 사용
// 2. 뷰모델 만들기
class AddressSearchViewModel extends AutoDisposeNotifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  final vWorldRepository = VWorldRepository();

  Future<void> search(String query) async {
    state = await vWorldRepository.findByName(query);
  }

  Future<void> searchByAddress(double lat, double lng) async {
    state = await vWorldRepository.findByLatLng(lat: lat, lng: lng);
  }
}

// 3. 뷰모델 관리자 만들기
final addressSearchViewModel =
    NotifierProvider.autoDispose<AddressSearchViewModel, List<String>>(
        () => AddressSearchViewModel());
