import 'package:flutter/material.dart';
import 'package:movie_web/models/movie_model.dart';
import 'package:movie_web/services/movie_services.dart';
import 'package:movie_web/widgets/drawer.dart';
import 'package:movie_web/widgets/footer.dart';
import 'package:movie_web/widgets/home_widgets/popular_movies_view.dart';
import 'package:movie_web/widgets/navbar.dart';
import 'package:movie_web/widgets/skeletons/popular_movies_skeleton.dart';

class MovieDetails extends StatefulWidget {
  final String movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  State<StatefulWidget> createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  List<Movie> _similarMovies = [];
  late Movie movieDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    _similarMovies = await MovieServices().fetchSimilarMovies(widget.movieId);
    movieDetail = await MovieServices().fetchMovieById(widget.movieId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didUpdateWidget(covariant MovieDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movieId != widget.movieId) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomNavbar(),
        drawer: CustomDrawer(),
        body: _isLoading
            ? const CircularProgressIndicator()
            : (movieDetail != null)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2000,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 400,
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://image.tmdb.org/t/p/original${movieDetail.backdropPath}',
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                Colors.transparent,
                                                Colors.black
                                              ])),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                  top: 300,
                                  left: 20,
                                  right: 20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w500${movieDetail.posterPath}',
                                              width: 150,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  movieDetail.originalTitle,
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  movieDetail.releaseDate,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  'Popularity: ${movieDetail.popularity.toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  movieDetail.overview,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    'Original Language: ${movieDetail.originalLanguage}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 25),
                                        child: Text(
                                          'Similar Movies',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: LayoutBuilder(
                                            builder: (context, contraints) {
                                          return _isLoading
                                              ? const PopularMoviesSkeleton()
                                              : MoviesGridView(
                                                  movies: _similarMovies);
                                        }),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Footer()
                      ],
                    ),
                  )
                : const Center(
                    child: Text('Failed to load data'),
                  ));
  }
}
