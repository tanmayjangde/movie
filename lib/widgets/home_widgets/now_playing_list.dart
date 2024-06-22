import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_web/models/movie_model.dart';

class NowPlayingList extends StatelessWidget {
  final List<Movie> nowPlayingMovies;

  const NowPlayingList({super.key, required this.nowPlayingMovies});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: nowPlayingMovies.length,
        itemBuilder: (context, index) {
          final movie = nowPlayingMovies[index];
          return ListTile(
            onTap: () {
              context.go('/movie/${movie.id}');
            },
            leading: Image.network(
              'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: const TextStyle(color: Color(0xFFE2B626)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              movie.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        });
  }
}
