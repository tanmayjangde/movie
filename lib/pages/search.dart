import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_web/models/movie_model.dart';
import 'package:movie_web/services/movie_services.dart';
import 'package:movie_web/widgets/footer.dart';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    movies = await MovieServices().searchMovies(widget.query);
    print(movies.length);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "${widget.query}"'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: movies.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 6,
                          child: InkWell(
                            onTap: () {
                              context.go('/movie/${movie.id}');
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          movie.overview,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                      'Vote Count: ${movie.voteCount}')
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.trending_up,
                                                    color: Colors.orange,
                                                  ),
                                                  Text(
                                                      'Popularity: ${movie.popularity}')
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                      'Release Date: ${movie.releaseDate}')
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                )),
                          ),
                        );
                      }),
                  Footer()
                ],
              ),
            ),
    );
  }
}
