import 'dart:convert';
import 'dart:io';
import 'package:do_it/model/vocabset_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VocabSetNetworkRequest{
  static var url = Uri.https('api.justvu.com', 'api/vocabset/get-vocab-sets');

  static List<VocabSet> parseVocabSet(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<VocabSet> quizzes  = [];
    try{
       quizzes = list.map( (model) => VocabSet.fromJson(model)).toList();
    } on Exception catch(a){
      print(a);
    }
    
    return quizzes;
  }


  static Future<List<VocabSet>> fetchVocabSet() async {
    String json  = '{"pageIndex": 0,"pageSize": 10}';
    final response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImFkbWluIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzA4NzQxMTQyLCJpc3MiOiJqdXN0dnUiLCJhdWQiOiJhbGwifQ.CqmYlz8iFk6KfwQFln3gzjEeS41HGAc8GJzYbcvDFiw',
    'Content-type': 'application/json',
    'Accept': 'application/json'
    },
    body: json,
    );
    if(response.statusCode == 200){
      return compute(parseVocabSet, response.body);
    }
    else if(response.statusCode == 404){
      throw Exception('Not found');
    }
    else{
      throw Exception('Cannot get the quiz');
    }
  }

}