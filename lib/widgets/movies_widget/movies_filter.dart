import 'package:flutter/material.dart';
import 'package:movie_web/models/movie_model.dart';

// ignore: must_be_immutable
class MoviesFilter extends StatefulWidget {
  final List<Movie> topRatedMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> currentMovies;
  final Function callback;
  int selectedFilterIndex;
  MoviesFilter(
      {super.key,
      required this.topRatedMovies,
      required this.nowPlayingMovies,
      required this.popularMovies,
      required this.upcomingMovies,
      required this.currentMovies,
      required this.callback,
      this.selectedFilterIndex = 0});
  @override
  State<StatefulWidget> createState() => MoviesFilterState();
}

class MoviesFilterState extends State<MoviesFilter> {
  List<Movie> movies = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.callback(0, widget.popularMovies);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade800),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Popular',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.selectedFilterIndex == 0
                          ? const Color(0xFFE2B616)
                          : Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                widget.callback(1, widget.nowPlayingMovies);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade800),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.selectedFilterIndex == 1
                          ? const Color(0xFFE2B616)
                          : Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                widget.callback(2, widget.upcomingMovies);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade800),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.selectedFilterIndex == 2
                          ? const Color(0xFFE2B616)
                          : Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                widget.callback(0, widget.topRatedMovies);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade800),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Top Rated',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.selectedFilterIndex == 3
                          ? const Color(0xFFE2B616)
                          : Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
