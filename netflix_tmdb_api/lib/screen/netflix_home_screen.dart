import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_tmdb_api/common/utils.dart';
import 'package:netflix_tmdb_api/model/movie_model.dart';
import 'package:netflix_tmdb_api/model/poppular_tv_series.dart';
import 'package:netflix_tmdb_api/model/top_rated_movies.dart';
import 'package:netflix_tmdb_api/model/trending_model.dart';
import 'package:netflix_tmdb_api/model/upcoming_movie.dart';
import 'package:netflix_tmdb_api/screen/movie_detail_screen.dart';
import 'package:netflix_tmdb_api/screen/search_screen.dart';
import 'package:netflix_tmdb_api/service/api_service.dart';

class NetflixHomeScreen extends StatefulWidget {
  const NetflixHomeScreen({super.key});

  @override
  State<NetflixHomeScreen> createState() => _NetflixHomeScreenState();
}

class _NetflixHomeScreenState extends State<NetflixHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiServices apiServices = ApiServices();
  late Future<Movie?> movieData;
  late Future<UpcomingMovies?> upcomingMovieData;
  late Future<TopRatedMovies?> topRatedMovieData;
  late Future<TrendingMovies?> trendingMovieData;
  late Future<PoppularTVseries?> poppularTVseriesData;

  
  @override
  void initState() {
    movieData = apiServices.fetchMovies();
    upcomingMovieData = apiServices.upcomingMovies();
    topRatedMovieData = apiServices.topRateMovies();
    trendingMovieData = apiServices.trendingMovies();
    poppularTVseriesData = apiServices.popularTvSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset("assets/Netflix-Brand-Logo.png", height: 50),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.download_sharp,
                    size: 27,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.cast, size: 27, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      _scrollController.animateTo(
                        700,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text(
                      "TV Shows",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {
                       _scrollController.animateTo(
                        300,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "categories",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 530,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: FutureBuilder(
                      future: movieData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error:${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          final movies = snapshot.data!.results;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              itemCount: movies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => MovieDetailScreen(
                                              movieId: movie.id,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 530,
                                    width: 388,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          "$imageUrl${movie.posterPath}",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                  ),
                  Positioned(
                    bottom: -40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  "My List",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            moviesTypes(
              future: trendingMovieData,
              movieType: "Trending Movies on Netflix",
            ),
            moviesTypes(
              future: upcomingMovieData,
              movieType: "Upcoming Movies",
              isReverse: true,
            ),
            moviesTypes(
              future: poppularTVseriesData,
              movieType: "Popular TV Series - Most-Watch For U",
            ),
            moviesTypes(
              future: topRatedMovieData,
              movieType: "Top Rated Movies",
            ),
          ],
        ),
      ),
    );
  }

  Padding moviesTypes({
    required Future future,
    required String movieType,
    bool isReverse = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieType,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: FutureBuilder(
              future: future, //303
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error:${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!.results;
                  return ListView.builder(
                    reverse: isReverse,
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                movieId: movie.id,
                              ),
                            ),
                          );
                          },
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  "$imageUrl${movie.posterPath}",
                                ),
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }
}
