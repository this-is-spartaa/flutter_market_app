import 'package:flutter_market_app/data/model/file_model.dart';
import 'package:flutter_market_app/data/repository/file_repository.dart';
import 'package:flutter_market_app/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 만들기. JoinPage에서 텍스트의 상태는 TextFormField가 관리해주므로
//    이미지만 관리해주면 됨 => 파일업로드 후 이미지 업로드 해줘야하니 null이될 수 있는 FileModel
// 2. 뷰모델 만들기
class JoinViewModel extends AutoDisposeNotifier<FileModel?> {
  @override
  FileModel? build() {
    return null;
  }

  final fileRepository = FileRepository();
  final userRepository = UserRepository();

  Future<void> uploadImage({
    required String filename,
    required String mimeType,
    required List<int> bytes,
  }) async {
    state = await fileRepository.upload(
      filename: filename,
      mimeType: mimeType,
      bytes: bytes,
    );
  }

  Future<bool> join({
    required String username,
    required String password,
    required String nickname,
    required String addressFullName,
  }) async {
    if (state == null) {
      return false;
    }
    return await userRepository.join(
      username: username,
      nickname: nickname,
      password: password,
      addressFullName: addressFullName,
      profileImageId: state!.id,
    );
  }
}

final joinViewModel = NotifierProvider.autoDispose<JoinViewModel, FileModel?>(
    () => JoinViewModel());
