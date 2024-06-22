import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_web/pages/home.dart';
import 'package:movie_web/pages/movie_details.dart';
import 'package:movie_web/pages/movies.dart';
import 'package:movie_web/pages/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/movies', builder: (context, state) => const MoviesPage()),
    GoRoute(
        path: '/search/:query',
        builder: (context, state) {
          final String query = state.pathParameters['query']!;
          return SearchPage(
            query: query,
          );
        }),
    GoRoute(
        path: '/movie/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return MovieDetails(movieId: id);
        }),
  ]);
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TMDB Movie App',
      theme: ThemeData.dark(),
      routerConfig: _router,
    );
  }
}
