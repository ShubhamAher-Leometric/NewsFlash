import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../blocs/homepage_news/homepage_news_bloc.dart';
import '../constatnts/appbar.dart';
import '../constatnts/constants.dart';
import '../screens/helper/theme_provider.dart';
import 'news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsApiBloc newsApiBloc = NewsApiBloc();

  @override
  void initState() {
    newsApiBloc.add(NewsApiData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: customAppBar(themeProvider),
      body: Container(
        child: BlocProvider(
          create: (context) => newsApiBloc,
          child: BlocBuilder<NewsApiBloc, NewsApiState>(
            builder: (context, state) {
              if (state is NewsApiLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffef5252),
                  ),
                );
              }
              if (state is NewsApiLoaded) {
                print('--------------------');
                print("I am in Loaded state");
                print('--------------------');
                return ListView.builder(
                    itemCount: state.newsModel.articles?.length,
                    itemBuilder: (context, index) {
                      final articles = state.newsModel.articles;
                      if (articles != null && articles.length > index) {
                        final article = articles[index];
                        final urlToImage = article.urlToImage ?? '';
                        final title = article.title ?? '';
                        final description = article.description ?? '';
                        final publishedAt = article.publishedAt ?? '';
                        final name = article.source?.name ?? '';
                        final content = article.content ?? '';
                        final url = article.url ?? '';
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetailsScreen(
                                      img: urlToImage,
                                      description: description,
                                      title: title,
                                      publishedAt: publishedAt,
                                      name: name,
                                      content: content,
                                      url: url
                                  )
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode ? DarkSecondaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FadeInImage(
                                  placeholder: AssetImage('assets/image_loder.gif',),
                                  image: NetworkImage(
                                    urlToImage.isNotEmpty ? urlToImage : Appimages.defaultImageUrl,
                                  ),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset(Appimages.defaultImageUrl); // Fallback image on error
                                  },
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    // color: themeProvider.isDarkMode ? Colors.amber[800] : Colors.blue,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    // color: themeProvider.isDarkMode ? Colors.amber[800] : Colors.blue,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.red,
                        );
                      }
                    }
                );
              }

              if(state is NewsApiError){
                return Center(
                  child: Text("Network Error"),
                );
              }
              return Center(
                // child: CircularProgressIndicator(
                //   color: Color(0xffef5252),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}
