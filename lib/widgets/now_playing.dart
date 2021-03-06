import 'package:flutter/material.dart';
import 'package:geemovie/bloc/get_now_playing_bloc.dart';
import 'package:geemovie/model/movie.dart';
import 'package:geemovie/model/movie_response.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:geemovie/style/theme.dart' as Style;


class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getMovies();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildNowPlayingWidget(snapshot.data);
        } else if (snapshot.hasError){
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      });
  }
  Widget _buildLoadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }
  Widget _buildErrorWidget(String error){
    return Center(
      child: Column(
        children: <Widget>[
          Text("Error occured: $error")
        ],
      ),
    );
  }
  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if(movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("No Movies")
          ],
        ),
      );
    } else{
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          padding: EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.mainColor,
          length: movies.take(5).length,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(5).length,
              itemBuilder: (context, index){
                return Stack(
                  children: <Widget> [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movies[index].backPoster),
                          fit: BoxFit.cover)
                      ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Style.Colors.mainColor.withOpacity(1.0),
                            Style.Colors.mainColor.withOpacity(0.0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.0,
                            0.9
                          ]
                        )
                      ),
                    )
                  ],
                );
              }),
        ),
      );
    }
  }
}
