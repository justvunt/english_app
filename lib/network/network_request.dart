import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:do_it/model/quiz_model.dart';

class NetworkRequest{
  static var url = Uri.https('api.justvu.com', 'api/vocab/quiz');

  static List<Quiz> parseQuiz(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Quiz> quizzes  = [];
    try{
       quizzes = list.map( (model) => Quiz.fromJson(model)).toList();
    } on Exception catch(a){
      print(a);
    }
    
    return quizzes;
  }


  static Future<List<Quiz>> fetchQuiz() async {
    final response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImFkbWluIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzA4NzQxMTQyLCJpc3MiOiJqdXN0dnUiLCJhdWQiOiJhbGwifQ.CqmYlz8iFk6KfwQFln3gzjEeS41HGAc8GJzYbcvDFiw',
    },);
    if(response.statusCode == 200){
      return compute(parseQuiz, response.body);
    }
    else if(response.statusCode == 404){
      throw Exception('Not found');
    }
    else{
      throw Exception('Cannot get the quiz');
    }
  }
}