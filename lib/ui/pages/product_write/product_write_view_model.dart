import 'package:flutter_market_app/data/model/file_model.dart';
import 'package:flutter_market_app/data/model/product.dart';
import 'package:flutter_market_app/data/model/product_category.dart';
import 'package:flutter_market_app/data/repository/file_repository.dart';
import 'package:flutter_market_app/data/repository/product_category_repository.dart';
import 'package:flutter_market_app/data/repository/product_repository.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/home_tap_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 만들기
class ProductWriteState {
  final List<FileModel> imageFiles;
  final List<ProductCategory> categories;
  final ProductCategory? selectedCategory;

  const ProductWriteState({
    required this.imageFiles,
    required this.categories,
    required this.selectedCategory,
  });

  ProductWriteState copyWith({
    List<FileModel>? imageFiles,
    List<ProductCategory>? categories,
    ProductCategory? selectedCategory,
  }) {
    return ProductWriteState(
      imageFiles: imageFiles ?? this.imageFiles,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

// 2. 뷰모델 만들기. 넘어온 Product가 null 이면 생성, 아니면 수정!
class ProductWriteViewModel
    extends AutoDisposeFamilyNotifier<ProductWriteState, Product?> {
  @override
  ProductWriteState build(Product? arg) {
    fetchCategories();
    return ProductWriteState(
      imageFiles: arg?.imageFiles ?? [],
      categories: [],
      selectedCategory: arg?.category,
    );
  }

  final productRepository = ProductRepository();
  final productCategoryRepository = ProductCategoryRepository();
  final fileRepository = FileRepository();

  Future<void> fetchCategories() async {
    final categories = await productCategoryRepository.getCategoryList();
    if (categories != null) {
      state = state.copyWith(categories: categories);
    }
  }

  Future<void> uploadImage({
    required String filename,
    required String mimeType,
    required List<int> bytes,
  }) async {
    final result = await fileRepository.upload(
      filename: filename,
      mimeType: mimeType,
      bytes: bytes,
    );
    if (result != null) {
      state = state.copyWith(
        imageFiles: [...state.imageFiles, result],
      );
    }
  }

  Future<bool?> upload({
    required String title,
    required String content,
    required int price,
  }) async {
    // 유효성 문제있을때 판단할 수 있게 null 리턴
    if (state.imageFiles.isEmpty) {
      return null;
    }
    if (state.selectedCategory == null) {
      return null;
    }

    if (arg == null) {
      final result = await productRepository.create(
        title: title,
        content: content,
        imageFileIdList: state.imageFiles.map((e) => e.id).toList(),
        categoryId: state.selectedCategory!.id,
        price: price,
      );
      if (result != null) {
        ref.read(homeTabViewModel.notifier).fetchProducts();
        return true;
      }
    } else {
      final result = await productRepository.update(
        id: arg!.id,
        title: title,
        content: content,
        imageFileIdList: state.imageFiles.map((e) => e.id).toList(),
        categoryId: state.selectedCategory!.id,
        price: price,
      );
      if (result) {
        return true;
      }
    }

    return false;
  }

  void onCategorySelected(String category) {
    final target = state.categories.where((e) => e.category == category);
    if (target.isNotEmpty) {
      state = state.copyWith(selectedCategory: target.first);
    }
  }
}

// 3. 뷰모델 관리자 만들기
final productWriteViewModel = NotifierProvider.autoDispose
    .family<ProductWriteViewModel, ProductWriteState, Product?>(
  () => ProductWriteViewModel(),
);
