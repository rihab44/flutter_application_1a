import 'dart:convert';
import 'package:dio/dio.dart';


class AuthService {
  Dio dio = Dio();

  Future<Response> login(String email, String password) async {
    try {
      return await dio.post(
        'http://localhost:3000/authenticate',
        data: {
          "Email": email,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      throw e;
    }
  }
}
