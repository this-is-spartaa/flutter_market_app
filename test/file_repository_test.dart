import 'dart:io';

import 'package:flutter_market_app/data/repository/file_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fileRepository = FileRepository();
  test(
    'FileRepository : upload test',
    () async {
      // 테스트 할 때의 실행은 현재 PC에서됨
      // 파일을 bytes데이터를 불러오기 위해 현재 PC의 프로젝트 기준 파일경로!
      final file = File('assets/welcome.png');
      final bytes = await file.readAsBytes();
      final result = await fileRepository.upload(
        filename: 'welcome.png',
        mimeType: 'image/png',
        bytes: bytes,
      );
      expect(result != null, true);
      expect(result?.originName, 'welcome.png');
      print(result?.toJson());
    },
  );
}
