import 'package:flutter_news/model_class/news_list_response.dart';
import 'package:flutter_news/networking/network.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main() {
  group('getTopHeadLines', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get('https://newsapi.org/v2/top-headlines?apiKey=c855d1cc16fa4cb28b0fe989a2babcf0&country=us'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      expect(await getTopHeadLines(client), isA<NewsListResponse>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get('https://newsapi.org/v2/top-headlines?apiKey=c855d1cc16fa4cb28b0fe989a2babcf0&country=us'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(getTopHeadLines(client), throwsException);
    });
  });
}