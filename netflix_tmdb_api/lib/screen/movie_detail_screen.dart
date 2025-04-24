import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_tmdb_api/common/utils.dart';
import 'package:netflix_tmdb_api/model/movie_detail.dart';
import 'package:netflix_tmdb_api/service/api_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ApiServices apiServices = ApiServices();
  late Future<MovieDetail?> movieDetail;
  @override
  void initState() {
    fetchMovieData();
    super.initState();
  }

  fetchMovieData() {
    movieDetail = apiServices.movieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data;
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,

                            image: CachedNetworkImageProvider(
                              "$imageUrl${movie?.posterPath}",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 50,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.cast, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return Text("Something went wrong");
          },
        ),
      ),
    );
  }
}
