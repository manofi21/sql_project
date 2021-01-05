import 'package:equatable/equatable.dart';

class Commant extends Equatable{
  int id;
  int to_id_user;
  int from_id_user;
  int id_picture;
  String commant;
 
  Commant({this.id ,this.to_id_user, this.from_id_user,this.id_picture, this.commant});
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id' : id,
      'to_id_user' : to_id_user,
      'from_id_user' : from_id_user,
      'id_picture' : id_picture,
      'commant' : commant
    };
    return map;
  }
 
  Commant.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    to_id_user = map['to_id_user'];
    from_id_user = map['from_id_user'];
    id_picture = map['id_picture'];
    commant = map['commant'];
  }

  @override
  List<Object> get props => [id, to_id_user,from_id_user, id_picture, commant];
}
// dbHelper.loadCommant(id_user: user.id_user,id_picture: photo.id)

class ForWidgetCommand extends Equatable {

  String name_user_commant;
  String picture;
  String commant;
 
  ForWidgetCommand({this.name_user_commant,this.picture, this.commant});
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name_user_commant' : name_user_commant,
      'picture' : picture,
      'commant' : commant
    };
    return map;
  }
 
  ForWidgetCommand.fromMap(Map<String, dynamic> map) {
    name_user_commant = map['name_user_commant'];
    picture = map['picture'];
    commant = map['commant'];
  }
  String strings(){
      return "name_user_commant : $name_user_commant, picture : $picture, commant : $commant";
    }

  @override
  List<Object> get props => [name_user_commant, picture, commant];

}