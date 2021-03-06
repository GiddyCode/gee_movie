import 'package:flutter/cupertino.dart';
import 'package:geemovie/model/movie_response.dart';
import 'package:geemovie/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGenreBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getMoviesListByGenre(int id) async {
    MovieResponse response = await _repository.getMoviesGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {_subject.value = null;}
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
//  dispose(){
//    _subject.close();
//  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesListByGenreBloc = MoviesListByGenreBloc();