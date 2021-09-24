import 'package:api_fetch_flutter/album.dart';
import 'package:api_fetch_flutter/api.dart';
import 'package:bloc/bloc.dart';

class AlbumState {
  bool loading = false;
  String error = '';
  Album? data;

  get hasError => error != '';

  AlbumState({ this.loading = false, this.error = '', Album? album}) : data = album;
}

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumState());

  Future<Album?> getAlbum(String id) async {
    emit(AlbumState(loading: true));
    try {
      Album? album = await Api.getAlbum(id);
      emit(AlbumState(album: album));
    } catch (e) {
      emit(AlbumState(error: e.toString()));
    }
  }
}