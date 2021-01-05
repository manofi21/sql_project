import 'dart:async';
import 'package:sql_images/commant.dart';

import '../dbHelper.dart';
import 'commant_bloc.dart';
import 'package:bloc/bloc.dart';

class CommantStateDartBloc
    extends Bloc<CommantStateDartEvent, CommantStateDartState> {
  @override
  CommantStateDartState get initialState => CommantStateDartInitial();

  @override
  Stream<CommantStateDartState> mapEventToState(
    CommantStateDartEvent event,
  ) async* {
    DBHelper dbHelper = DBHelper();
    if (event is GetAllCommant) {
      List<ForWidgetCommand> allCommants = await dbHelper.loadCommant(
          id_user: event.idUser, id_picture: event.idPhoto);
      yield LoadCommants(allCommants);
    } else if (event is AddACommant) {
      final newcommant = await dbHelper.addcommant(event.commant);
      List<ForWidgetCommand> allCommants = await dbHelper.loadCommant(
          id_user: event.commant.to_id_user,
          id_picture: event.commant.id_picture);
      yield LoadCommants(allCommants);
    }
  }
}
