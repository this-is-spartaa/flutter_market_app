import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class PickImageResult {
  final String filename;
  final String mimeType;
  // 8비트(1바이트, 0~255) 의 List
  final Uint8List bytes;

  PickImageResult({
    required this.filename,
    required this.mimeType,
    required this.bytes,
  });
}

class ImagePickerHelper {
  static final _picker = ImagePicker();

  // 돌려줘야 될 것 : 파일이름, 마임타입, 파일 바이트 데이터
  static Future<PickImageResult?> pickImage() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      final bytes = await xFile.readAsBytes();

      // 항상 null이기 때문에 mime package 사용해서 mimeType 읽어오기
      // mime => 파일 바이트 내에서 mime type 파싱하는 패키지
      // print(xFile?.mimeType) // null
      final mimeType = lookupMimeType(xFile.path, headerBytes: bytes);

      // mimeType이 파일 바이트 코드 내에 mime type 을 구분할 수 있는 바이트 코드가 없다면 사용할 수 없는 파일(이미지)!
      if (mimeType == null) {
        return null;
      }
      final filename = xFile.name;

      return PickImageResult(
        filename: filename,
        mimeType: mimeType,
        bytes: bytes,
      );
    }
    return null;
  }
}
