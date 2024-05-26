import '../../model/homepage_news_model.dart';
import '../api/homepage_news_api.dart';

class NewsAPIRepository {
  final _provider = NewsAPIProvider();
  Future<NewsModel> fetchnewslist() {
    return _provider.fetchmynewslist();
  }
}

class NetworkError extends Error {}