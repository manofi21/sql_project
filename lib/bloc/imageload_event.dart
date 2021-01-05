import 'package:equatable/equatable.dart';
import 'package:sql_images/photo.dart';

abstract class ImageloadEvent extends Equatable {
  ImageloadEvent([List props = const []]);
}

class GetAllPhoto extends ImageloadEvent {
  @override
  List<Object> get props => [];
}

class AddAPhoto extends ImageloadEvent {
  final int photoid;
  AddAPhoto(this.photoid);
  @override
  List<Object> get props => [photoid]; 
}