import 'package:flutter/material.dart';
import 'package:sql_images/Users.dart';
import 'package:sql_images/photo.dart';
import 'commant.dart';
 
class StateContainer extends StatefulWidget {
  // meminta widget dan Model yang dibutuhkan
  final Widget child;
  final Commant commant;
  // fi
 
  StateContainer({@required this.child, this.commant});
 
  static StateContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedStateContainer>()).data;
  }
 
  @override
  StateContainerState createState() => new StateContainerState();
}
 
class StateContainerState extends State<StateContainer> {
 Commant commant;
 Users users;
 Photo photo;
   void updateUser({Commant new_commant, Users new_users, new_photo}) {
    if (commant == null) {
      commant = new_commant;
      users = new_users;
      photo = new_photo;
      setState(() {
        commant = new_commant;
        users = new_users;
        photo = new_photo;
      });
    } else {
      setState(() {
        commant = new_commant ?? commant;
        users = new_users ?? users;
        photo = new_photo ?? photo;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
 
class InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;
  InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class UpdateState {
  final BuildContext context;
  final Users user;
  final Commant commant;
  final Photo photo;
  UpdateState(this.context,{this.user, this.commant,this.photo});

  void setUpdate() {
      final container = StateContainer.of(context);
    container.updateUser(new_commant: this.commant, new_photo: this.photo, new_users: this.user);
  }
}

class GetUpdate {
  Users returnUsers(BuildContext context){
    final container = StateContainer.of(context);
    Users users = container.users;
    return users;
  }

  Commant returnCommant(BuildContext context){
    final container = StateContainer.of(context);
    Commant commant = container.commant;
    return commant;
  }

  Photo returnPhoto(BuildContext context){
    final container = StateContainer.of(context);
    Photo photo = container.photo;
    return photo;
  }
}