import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_web/models/movie_model.dart';
import 'package:movie_web/responsive.dart';

class MoviesGridView extends StatefulWidget {
  final List<Movie> movies;
  const MoviesGridView({super.key, required this.movies});

  @override
  State<MoviesGridView> createState() => _MoviesGridViewState();
}

class _MoviesGridViewState extends State<MoviesGridView> {
  int? _hoverIndex;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: const Responsive().isMobile(context)
                ? 2
                : const Responsive().isTablet(context)
                    ? 3
                    : 5,
            childAspectRatio: const Responsive().isMobile(context) ? 0.5 : 0.8),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return MouseRegion(
            onEnter: (_) {
              setState(() {
                _hoverIndex = index;
              });
            },
            onExit: (_) {
              setState(() {
                _hoverIndex = null;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: _hoverIndex == index
                  ? (Matrix4.identity()
                    ..scale(1.05, 1.05)
                    ..translate(0, -10))
                  : Matrix4.identity(),
              child: GestureDetector(
                onTap: () {
                  context.go('/movie/${movie.id}');
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: _hoverIndex == index ? 20 : 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        )),
                        Expanded(
                            child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFE2B216),
                                ),
                                Text(movie.voteAverage.toString())
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text('Language: ${movie.originalLanguage}'),
                            const SizedBox(
                              height: 4,
                            ),
                            Text('Adult: ${movie.adult ? 'Yes' : 'No'}')
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
