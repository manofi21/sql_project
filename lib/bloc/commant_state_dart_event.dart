import 'package:equatable/equatable.dart';

import '../commant.dart';

abstract class CommantStateDartEvent extends Equatable {
  CommantStateDartEvent([List props = const []]);
}

class GetAllCommant extends CommantStateDartEvent {
  final int idUser, idPhoto;
  GetAllCommant({this.idUser, this.idPhoto});
  @override
  List<Object> get props => [idUser, idPhoto];
}

class AddACommant extends CommantStateDartEvent {
  final Commant commant;
  // final int idAuthor, idPictures;
  AddACommant(this.commant);
  @override
  List<Object> get props => [commant];
}
