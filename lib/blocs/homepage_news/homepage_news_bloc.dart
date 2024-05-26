import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/homepage_news_model.dart';
import '../../network/repository/homepage_news_repo.dart';

part 'homepage_news_event.dart';
part 'homepage_news_state.dart';

class NewsApiBloc extends Bloc<NewsApiEvent, NewsApiState> {
  NewsApiBloc() : super(NewsApiInitial()) {
    NewsAPIRepository _apiRepository = NewsAPIRepository();
    on<NewsApiData>((event, emit) async {
      try {
        emit(NewsApiLoading());
        final newsData = await _apiRepository.fetchnewslist();
        emit(NewsApiLoaded(newsData));
        if (newsData.error != null) {
          print(newsData.error);
          emit(NewsApiError(newsData.error));
        }
      } catch (e) {
        // Handle any potential exceptions that may occur during the API call
        emit(NewsApiError(e.toString()));
      }
// } on NetworkError {
//     emit(MyTeamError("Failed to fetch data. is your device online?"));
//   }
    });
  }
}

