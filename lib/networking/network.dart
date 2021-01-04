import 'dart:convert';
import 'dart:io';

import 'package:flutter_news/model_class/news_list_response.dart';
import 'package:http/http.dart' as http;

Future<NewsListResponse> getCategoryData(http.Client client,
    String category) async {
  final response =
  await client.get(
      'https://newsapi.org/v2/top-headlines?apiKey=c855d1cc16fa4cb28b0fe989a2babcf0&country=us&category=${category}');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return NewsListResponse.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<NewsListResponse> getTopHeadLines(http.Client client) async {
  final response =
  await client.get(
      'https://newsapi.org/v2/top-headlines?apiKey=c855d1cc16fa4cb28b0fe989a2babcf0&country=us');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return NewsListResponse.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<bool> _checkConnectivity() async {
  bool connect;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connect = true;
    }
  } on SocketException catch (_) {
    connect = false;
  }
  return connect;
}


