import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class DeepSeekApi {
  static const String baseUrl = "http://192.168.31.216:5001";
  final Dio _dio;

  DeepSeekApi()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          responseType: ResponseType.stream,
        ));

  Future<Stream<dynamic>> streamChat(String text) async {
    try {
      final response = await _dio.post(
        '/stream',
        data: {'text': text},
        options: Options(
          responseType: ResponseType.stream,
          headers: {'content-type': 'application/json'},
        ),
      );

      final Stream<Uint8List> responseStream = response.data.stream;
      return responseStream
          .transform(StreamTransformer<Uint8List, String>.fromHandlers(
            handleData: (Uint8List data, sink) {
              String decoded = utf8.decode(data);
              sink.add(decoded);
            },
          ))
          .transform(const LineSplitter())
          .map((data) {
            if (data.isEmpty) return '';

            if (data.startsWith('data: ')) {
              data = data.substring(6);
            }

            if (data == '[DONE]') {
              return '';
            }

            try {
              final json = jsonDecode(data);
              if (json['choices'][0]['finish_reason'] == 'stop') {
                return '';
              }

              final delta = json['choices'][0]['delta'];
              if (delta.containsKey('role')) {
                return '';
              }
              return delta['content'] ?? '';
            } catch (e) {
              print(data);
              print('Error parsing JSON: $e');
              return '';
            }
          })
          .where((content) => content.isNotEmpty);
    } catch (e) {
      print('Request error: $e');
      rethrow;
    }
  }
}
