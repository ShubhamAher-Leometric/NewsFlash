part of 'homepage_news_bloc.dart';


abstract class NewsApiState extends Equatable {
  const NewsApiState();
}

class NewsApiInitial extends NewsApiState {
  List<Object> get props => [];
}

class NewsApiLoading extends NewsApiState {
  List<Object> get props => [];
}

class  NewsApiLoaded extends NewsApiState {
  List<Object> get props => [];

  final NewsModel newsModel;
  const  NewsApiLoaded(this.newsModel);
}

class  NewsApiError extends NewsApiState {
  late final String? message;
  NewsApiError(this.message);

  List<Object> get props => [];
}
