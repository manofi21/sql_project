import 'dart:async';
import '../dbHelper.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sql_images/Users.dart';
import 'package:sql_images/photo.dart';
import 'package:sql_images/utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageloadBloc extends Bloc<ImageloadEvent, ImageloadState> {
  @override
  ImageloadState get initialState => ImageloadInitial();

  @override
  Stream<ImageloadState> mapEventToState(
    ImageloadEvent event,
  ) async* {
    final _repos = DBHelper();

    if (event is GetAllPhoto) {
      final photo = await _repos.getPhotos();
      yield ImageloadLoading(photo);
    } else if (event is AddAPhoto) {
      Photo photo = await saveImagePicker(event.photoid);
      final addphoto = await _repos.save(photo);
      final allphoto = await _repos.getPhotos();
      yield ImageloadLoading(allphoto);
    }
  }

  Future<Photo> saveImagePicker(int usersid) async{
    Photo photo;
    final _picker = ImagePicker();
    final imgFile =  await _picker.getImage(source: ImageSource.gallery);
    String imgString = Utility.base64String(await imgFile.readAsBytes());
    int idAuther = usersid;
      photo = Photo(
          photo_name: imgString,
          id_author: idAuther,
          description: "ini deskripsi");
      return photo;
  }
}
