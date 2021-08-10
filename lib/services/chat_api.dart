import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ChatApi{

  // constructor
  ChatApi();

  Future<dynamic> getReponse(String text) async {
    var data = {
      'text': text,
    };
    return await http.post("https://flapbotuy1.herokuapp.com/api/botqr",
        headers: {'Content-Type': "application/json"}, body: jsonEncode(data));
  }

  //Associate etablish to user
  Future<dynamic> getReponses(String text) async {
    FormData formData = new FormData.fromMap({
      'text': text,
    });
    var dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    return await dio.post('https://flapbotapi.herokuapp.com/api/conversation', data:formData,options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        }
    ));
  }
}