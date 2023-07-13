import 'package:get/get.dart';
import 'package:kuunga_app/screens/news/article.dart';
import 'package:kuunga_app/screens/news/news_web.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var articles = <Articles>[].obs;
  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      var articlesTemp = await NewsWebService.fetchNews();
      if (articlesTemp != null) {
        articles(articlesTemp);
      }
    } finally {
      isLoading(false);
    }
  }
}
