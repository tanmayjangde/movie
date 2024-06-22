import 'package:flutter/material.dart';
import 'package:movie_web/models/movie_model.dart';
import 'package:movie_web/services/movie_services.dart';
import 'package:movie_web/widgets/drawer.dart';
import 'package:movie_web/widgets/footer.dart';
import 'package:movie_web/widgets/home_widgets/popular_movies_view.dart';
import 'package:movie_web/widgets/movies_widget/movies_filter.dart';
import 'package:movie_web/widgets/navbar.dart';
import 'package:movie_web/widgets/skeletons/popular_movies_skeleton.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  List<Movie> _topRatedMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _currentMovies = [];
  int _selectedFilterIndex = 0;
  bool _isLoading = true;

  void callback(int index, List<Movie> movies) {
    setState(() {
      _selectedFilterIndex = index;
      _currentMovies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    MovieServices movieServices = MovieServices();
    _topRatedMovies = await movieServices.fetchTopRatedMovies();
    _nowPlayingMovies = await movieServices.fetchNowPlayingMovies();
    _popularMovies = await movieServices.fetchPopularMovies();
    _upcomingMovies = await movieServices.fetchUpcomingMovies();
    _currentMovies = _popularMovies;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: const CustomNavbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Explore Movies',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                MoviesFilter(
                  topRatedMovies: _topRatedMovies,
                  nowPlayingMovies: _nowPlayingMovies,
                  popularMovies: _popularMovies,
                  upcomingMovies: _upcomingMovies,
                  currentMovies: _currentMovies,
                  callback: callback,
                  selectedFilterIndex: _selectedFilterIndex,
                ),
                LayoutBuilder(builder: (context, contraints) {
                  return _isLoading
                      ? const PopularMoviesSkeleton()
                      : MoviesGridView(movies: _currentMovies);
                }),
                Footer()
              ],
            ),
          ),
        ));
  }
}
