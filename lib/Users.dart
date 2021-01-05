import 'package:equatable/equatable.dart';

class Users extends Equatable{
  int id;
  String img;
  String username;
  String password;
 
  Users({this.id ,this.img,this.username, this.password});
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id' : id,
      'img_profile' : img,
      'username': username,
      'password' : password
    };
    return map;
  }
 
  Users.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    img = map['img_profile'];
    username = map['username'];
    password = map['password'];
  }

  @override
  List<Object> get props => [id, username, password];
}
