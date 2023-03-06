import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio();

  Future<Response> addProduct(String nom, double prix, double code, double stock,
     double criteredemesure) async {
    try {
      return dio.post(
        'http://localhost:8000/addproduct',
        data: {
          "nom": nom,
          "prix": prix,
          "code": code,
          "stock": stock,
          "criteredemesure": criteredemesure,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      throw e;
    }
  }
}
