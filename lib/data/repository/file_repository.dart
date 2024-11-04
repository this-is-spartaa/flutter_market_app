import 'package:dio/dio.dart';
import 'package:flutter_market_app/data/model/file_model.dart';
import 'package:flutter_market_app/data/repository/base_remote_repository.dart';

class FileRepository extends BaseRemoteRepository {
  const FileRepository();
  Future<FileModel?> upload({
    required String filename,
    // 마임타입, 즉 파일의 타입을 반드시 보내주어야함!
    required String mimeType,
    required List<int> bytes,
  }) async {
    // request content-type이 multipart/form-data 일 때
    FormData formData = FormData.fromMap({
      // multipart/form-data에서 파일 보낼때 사용
      "file": MultipartFile.fromBytes(
        bytes,
        filename: filename,
        contentType: DioMediaType.parse(mimeType),
      ),
    });
    final response = await client.post(
      "$host/api/file/upload",
      data: formData,
    );

    if (response.statusCode == 201) {
      return FileModel.fromJson(response.data['content']);
    }
    return null;
  }
}
