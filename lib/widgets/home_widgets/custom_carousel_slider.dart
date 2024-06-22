import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_web/models/movie_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<Movie> topRatedMovies;
  const CustomCarouselSlider({super.key, required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: topRatedMovies.map((movie) {
          return Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                context.go('/movie/${movie.id}');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            );
          });
        }).toList(),
        options: CarouselOptions(
            height: 500,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            enableInfiniteScroll: true,
            pageSnapping: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0));
  }
}
