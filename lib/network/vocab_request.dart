import 'dart:convert';
import 'dart:io';
import 'package:do_it/model/vocab_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VocabRequest {
  String vocabSetID;

  VocabRequest(this.vocabSetID);

  static List<Vocab> parseVocab(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Vocab> vocabs = [];
    try {
      vocabs = list.map((model) => Vocab.fromJson(model)).toList();
    } on Exception catch (a) {
      print(a);
    }

    return vocabs;
  }

  Future<List<Vocab>> fetchVocab() async {
    var url = Uri.https('api.justvu.com', 'api/vocab/get-by-cate/$vocabSetID');
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImFkbWluIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzA4NzQxMTQyLCJpc3MiOiJqdXN0dnUiLCJhdWQiOiJhbGwifQ.CqmYlz8iFk6KfwQFln3gzjEeS41HGAc8GJzYbcvDFiw',
      },
    );
    if (response.statusCode == 200) {
      return compute(parseVocab, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Cannot get the quiz');
    }
  }

  Future<List<Vocab>> fetchReviseVocab() async {
    var url = Uri.https('api.justvu.com', 'api/vocab/get-vocab-by-remind-time');
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImFkbWluIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzA4NzQxMTQyLCJpc3MiOiJqdXN0dnUiLCJhdWQiOiJhbGwifQ.CqmYlz8iFk6KfwQFln3gzjEeS41HGAc8GJzYbcvDFiw'
      },
    );
    if (response.statusCode == 200) {
      return compute(parseVocab, response.body);
    } else if (response.statusCode == 403) {
      throw Exception("Not found");
    } else {
      throw Exception('Cannot get the quiz');
    }
  }

  Future<bool> updateLevel(String vocabId, int level,
      {DateTime? remindTime}) async {
    var url = Uri.https('api.justvu.com', 'api/vocab/${vocabId}');
    // var url = Uri.http('localhost:5000', 'api/vocab/${vocabId}');

    var content = {};
    if (remindTime != null) {
      content = {"remindTime": remindTime.toString(),
      "level": "${level}"
      };
    } else {
      content = {"level": "${level}"};
    }
    String item = json.encode(content);

    final response = await http.put(url,
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImFkbWluIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzA4NzQxMTQyLCJpc3MiOiJqdXN0dnUiLCJhdWQiOiJhbGwifQ.CqmYlz8iFk6KfwQFln3gzjEeS41HGAc8GJzYbcvDFiw',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: item);
    if (response.statusCode == 200) return true;
    return false;
  }
}
