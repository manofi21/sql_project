import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_images/commant.dart';
import 'package:sql_images/dbHelper.dart';
import 'package:sql_images/photo.dart';
import 'package:sql_images/state_container.dart';
import 'package:sql_images/utility.dart';
import 'package:sql_images/widget/widget.dart';

import 'bloc/commant_bloc.dart';
import 'bloc/commant_state_dart_bloc.dart';

// import 'command_widgets.dart';

// import 'Utility.dart';

// class PostSite extends StatelessWidget {
class PostSite extends StatefulWidget {
  final Photo photo;
  PostSite(this.photo);
  @override
  _PostSiteState createState() => _PostSiteState(this.photo);
}

class _PostSiteState extends State<PostSite> {
  final Photo photo;
  _PostSiteState(this.photo);
  DBHelper dbHelper = DBHelper();
  List<String> messages;
  double height, width;
  TextEditingController textController = TextEditingController();
  ScrollController scrollController;
  final blocCommants = CommantStateDartBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    Commant commant = container.commant;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              // Container(
              //     padding: EdgeInsets.only(top: 40.0),
              //     width: double.infinity,
              //     height: 600.0,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(25.0),
              //     ),
              //     child:
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    // child:Material(
                    Material(
                        child: Hero(
                            tag: "${photo.photo_name + photo.id.toString()}",
                            child: Container(
                                margin: EdgeInsets.all(10.0),
                                width: double.infinity,
                                height: 400.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(0, 5),
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: Utility.imageFromBase64String(
                                                photo.photo_name)
                                            .image))))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    iconSize: 30.0,
                                    onPressed: () => print('Like post'),
                                  ),
                                  Text(
                                    '1000',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.0),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.chat),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print('Chat');
                                    },
                                  ),
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark_border),
                            iconSize: 30.0,
                            onPressed: () => print('Save post'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ),
              // StreamBuilder(
              //     stream: dbHelper
              //         .loadCommant(
              //             id_user: photo.id_author, id_picture: photo.id)
              //         .asStream(),
              //     builder: (context, AsyncSnapshot<List<ForWidgetCommand>> snapshot) {
              //       if (snapshot.data != null) {
              //         // return Container();
              //         return Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: snapshot.data.map((e) {
              //               if(e == null){
              //                 return Container();
              //               }else {
              //                 return BuildCommant(e);
              //               }
              //             }).toList());
              //       }
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [Text('lol'), Text('0')],
              //       );
              //     })
              BlocBuilder(
                  bloc: blocCommants,
                  builder: (context, CommantStateDartState state) {
                    if (state is CommantStateDartInitial) {
                      blocCommants.add(GetAllCommant(
                          idUser: photo.id_author, idPhoto: photo.id));
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadCommants) {
                      return ListCommants(allCommants: state.allCommants);
                    }
                  })
            ],
          )),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.all(20.0),
                hintText: '${commant.to_id_user} ${commant.from_id_user}',
                prefixIcon: Container(
                  margin: EdgeInsets.all(4.0),
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 4.0),
                  width: 70.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(0xFF23B66F),
                    onPressed: () {
                      // await dbHelper
                      // .addcommant(Commant(
                      //     to_id_user: commant.to_id_user,
                      //     from_id_user: commant.from_id_user,
                      //     id_picture: photo.id,
                      //     commant: textController.text))
                      //     .then(
                      //         (value) => print("values" + value.id.toString()));
                      // textController.clear();
                      Commant commants = Commant(
                          to_id_user: commant.to_id_user,
                          from_id_user: commant.from_id_user,
                          id_picture: photo.id,
                          commant: textController.text);
                      blocCommants.add(AddACommant(commants));
                    },
                    child: Icon(
                      Icons.send,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
