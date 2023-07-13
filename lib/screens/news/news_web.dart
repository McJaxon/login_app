import 'package:http/http.dart ' as http;
import 'package:kuunga_app/screens/news/article.dart';

class NewsWebService {
  static var client = http.Client();
  static Future<List<Articles>> fetchNews() async {
    const apiKey = '19cff019148147adb11f03f19993e3ad';
    const apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    var response = await client.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // final jsonBody = json.decode(response.body);
      // final articles = jsonBody['articles'];
      return articlesFromJson(response.body);
    } else {
      throw Exception('No results');
    }
  }
}
