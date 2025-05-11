import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix_tmdb_api/common/utils.dart';
import 'package:netflix_tmdb_api/model/tmdb_trending.dart';
import 'package:netflix_tmdb_api/screen/movie_detail_screen.dart';
import 'package:netflix_tmdb_api/service/api_service.dart';

class HotNews extends StatefulWidget {
  const HotNews({super.key});

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  final ApiServices apiServices = ApiServices();
  late Future<TmdbTrending?> tmdbTrendingAPI;
  @override
  void initState() {
    tmdbTrendingAPI = apiServices.tmdbTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getShortname(String name) {
      return name.length > 3 ? name.substring(0, 3) : name;
    }

    String formatDate(String apiDate) {
      DateTime parseData = DateTime.parse(apiDate);
      return DateFormat('MMM').format(parseData);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Hot News", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: tmdbTrendingAPI,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error:${snapshot.error}"));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!.results;
            return ListView.builder(
              itemCount: movies.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final movie = movies[index];
                String firstAirDate =
                    movie.firstAirDate?.day.toString() ?? "";
                String releaseDay =
                    movie.releaseDate?.day.toString() ?? "";
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  MovieDetailScreen(movieId: movie.id),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                movie.releaseDate == null
                                    ? firstAirDate
                                    : releaseDay,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                movie.releaseDate == null
                                    ? getShortname(
                                      formatDate(
                                        movie.firstAirDate?.toString() ??
                                            "",
                                      ),
                                    )
                                    : getShortname(
                                      formatDate(
                                        movie.releaseDate?.toString() ??
                                            "",
                                      ),
                                    ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      "$imageUrl${movie.backdropPath}",
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Coming on",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    movie.releaseDate == null
                                        ? firstAirDate
                                        : releaseDay,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    movie.releaseDate == null
                                        ? getShortname(
                                          formatDate(
                                            movie.firstAirDate
                                                    ?.toString() ??
                                                "",
                                          ),
                                        )
                                        : getShortname(
                                          formatDate(
                                            movie.releaseDate
                                                    ?.toString() ??
                                                "",
                                          ),
                                        ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                movie.overview ?? "no data",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text(
              "No data available",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
