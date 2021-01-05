import 'package:equatable/equatable.dart';

class Photo extends Equatable{
  int id;
  int id_author;
  String photo_name;
  String description;
 
  Photo({this.id, this.id_author,this.photo_name, this.description});
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'id_author' : id_author,
      'photo_name': photo_name,
      'description': description
    };
    return map;
  }
 
  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    id_author = map['id_author'];
    photo_name = map['photo_name'];
    description = map['description'];
  }

  @override
  List<Object> get props => [id , id_author, photo_name, description];
}
