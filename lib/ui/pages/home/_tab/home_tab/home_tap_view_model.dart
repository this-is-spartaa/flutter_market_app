import 'package:flutter_market_app/data/model/address.dart';
import 'package:flutter_market_app/data/model/product_summary.dart';
import 'package:flutter_market_app/data/repository/address_repository.dart';
import 'package:flutter_market_app/data/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 클래스 만들기
class HomeTabState {
  final List<Address> addresses;
  final List<ProductSummary> products;

  const HomeTabState({
    required this.addresses,
    required this.products,
  });

  HomeTabState copyWith({
    List<Address>? addresses,
    List<ProductSummary>? products,
  }) {
    return HomeTabState(
      addresses: addresses ?? this.addresses,
      products: products ?? this.products,
    );
  }
}


// 2. 뷰모델 만들기
class HomeTabViewModel extends AutoDisposeNotifier<HomeTabState> {
  @override
  HomeTabState build() {
    fetchAddress().then(
      (value) {
        fetchProducts();
      },
    );
    return const HomeTabState(
      addresses: [],
      products: [],
    );
  }

  final addressRepository = AddressRepository();
  final productRepository = ProductRepository();

  Future<void> fetchAddress() async {
    final addresses = await addressRepository.getMyAddresseList();
    state = state.copyWith(
      addresses: addresses,
    );
  }

  Future<void> fetchProducts() async {
    if (state.addresses.isEmpty) {
      print("defaultAddress 없음");
      return;
    }
    final defaultAddress = state.addresses.where((e) => e.defaultYn ?? false);
    final products =
        await productRepository.getProductSummaryList(defaultAddress.first.id);
    state = state.copyWith(
      products: products,
    );
  }
}

// 3. 뷰모델 관리자 만들기
final homeTabViewModel =
    NotifierProvider.autoDispose<HomeTabViewModel, HomeTabState>(
        () => HomeTabViewModel());
