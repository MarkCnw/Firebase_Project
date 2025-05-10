import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_tmdb_api/common/utils.dart';
import 'package:netflix_tmdb_api/model/search_movie_model.dart';
import 'package:netflix_tmdb_api/model/trending_model.dart';
import 'package:netflix_tmdb_api/screen/movie_detail_screen.dart';

import 'package:netflix_tmdb_api/service/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  late Future<TrendingMovies?> trendingMovie;
  SearchMovie? searchMovie;
  void search(String query) {
    apiServices.searchMovie(query).then((result) {
      setState(() {
        searchMovie = result;
      });
    });
  }

  @override
  void initState() {
    trendingMovie = apiServices.trendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CupertinoSearchTextField(
                controller: searchController,
                padding: EdgeInsets.all(10),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: Icon(Icons.cancel, color: Colors.white),
                style: TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {
                  } else {
                    search(searchController.text);
                  }
                },
              ),
            ),
            SizedBox(height: 15),
            searchController.text.isEmpty
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FutureBuilder(
                    future: trendingMovie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data?.results;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 8),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: movie!.length,
                              itemBuilder: (context, index) {
                                final topMovie = movie[index];
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      MovieDetailScreen(
                                                        movieId:
                                                            topMovie.id,
                                                      ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      5,
                                                    ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$imageUrl${topMovie.backdropPath}",
                                                  fit: BoxFit.cover,
                                                  width: 150,
                                                  height: 80,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Text(
                                                  topMovie.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 40,
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 27,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )
                : searchMovie == null
                ? SizedBox.shrink()
                : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: searchMovie?.results.length,
                  itemBuilder: (context, index) {
                    final search = searchMovie!.results[index];
                    return search.backdropPath == null
                        ? SizedBox()
                        : Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => MovieDetailScreen(
                                            movieId: search.id,
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${search.backdropPath}",
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 80,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Text(
                                          search.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 40,
                              child: Icon(
                                Icons.play_circle_outline,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                          ],
                        );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
