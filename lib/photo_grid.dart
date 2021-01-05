import 'package:flutter/material.dart';
import 'package:sql_images/Users.dart';
import 'package:sql_images/commant.dart';
import 'package:sql_images/navigator.dart';
import 'package:sql_images/photo.dart';
import 'package:sql_images/state_container.dart';
import 'package:sql_images/widget/small_widget.dart';
import 'edit_user_pages.dart';
import 'hero_page.dart';
import 'bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveImageDemoSQLite extends StatefulWidget {
  SaveImageDemoSQLite() : super();

  final String title = "Flutter Save Image";

  @override
  _SaveImageDemoSQLiteState createState() => _SaveImageDemoSQLiteState();
}

class _SaveImageDemoSQLiteState extends State<SaveImageDemoSQLite> {
  final bloc = ImageloadBloc();
  GetUpdate getValuesSever = GetUpdate();
  ProjectNavigator navigators = ProjectNavigator();
  @override
  void initState() {
    super.initState();
  }

  pickImageFromGallery() {
    Users users = getValuesSever.returnUsers(context);
    bloc.add(AddAPhoto(users.id));
  }

  validateAndSave(Commant commant, Users user) {
    UpdateState update = UpdateState(context, commant: commant, user: user);
    update.setUpdate();
  }

  gridView(List<Photo> snapshot) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: snapshot
            .map((photo) => InkWell(
                onTap: () {
                  Users user = getValuesSever.returnUsers(context);
                  Commant commant = Commant(
                      to_id_user: photo.id_author, from_id_user: user.id);
                  validateAndSave(commant, user);
                  navigators.withAnimation(context, PostSite(photo));
                },
                child: ImageBanner(photo: photo)))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: pickImageFromGallery),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Users users = getValuesSever.returnUsers(context);
                EditStateUsers editState = EditStateUsers(users);
                navigators.withOutAnimation(context,
                    editState); // Navigator.of(context).push(route) //EditStateUsers
              },
            )
          ],
        ),
        body: BlocBuilder(
            bloc: bloc,
            builder: (context, ImageloadState state) {
              if (state is ImageloadInitial) {
                bloc.add(GetAllPhoto());
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ImageloadLoading) {
                return gridView(state.allPhoto);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
