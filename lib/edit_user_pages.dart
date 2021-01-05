import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sql_images/Users.dart';
import 'package:sql_images/commant.dart';
import 'package:sql_images/dbHelper.dart';
import 'package:sql_images/photo.dart';
import 'package:sql_images/state_container.dart';
import 'package:sql_images/utility.dart';

import 'photo_grid.dart';
// import 'package:sql_images/photo.dart';

class EditUsers extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  DBHelper dbHelper = DBHelper();
  final formKey = new GlobalKey<FormState>();
  String imgString;
  final Users users;
  EditUsers(this.users);
  @override
  Widget build(BuildContext context) {
    validateAndSave(Users users) {
      final container = StateContainer.of(context);
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        container.updateUser(new_users: users);
      } else {
        print("Validation Error");
      }
    }

    pickImageFromGallery() {
      final _picker = ImagePicker();
      _picker.getImage(source: ImageSource.gallery).then((imgFile) async {
        imgString = Utility.base64String(await imgFile.readAsBytes());
      });
    }

    return MaterialApp(
      title: 'Flut',
      home: Scaffold(
        //isi scaffold
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("login Page"),
        ),
        body: Container(
          //isi body: Container
          child: Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 35, 40, 50),
              child: Column(
                //isi child: Column
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 120,
                          height: 100,
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/imgprofile.jpg'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 60,
                          height: 25,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text(
                              'Add Image',
                              style: TextStyle(fontSize: 9),
                            ),
                            onPressed: pickImageFromGallery,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
                    child: Column(
                      children: <Widget>[
                        Text("Email"),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 8),
                            child: TextFormField(
                              controller: username,
                              initialValue: users.username,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.message)),
                            )),
                        Text("Password"),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 8),
                            child: TextFormField(
                              initialValue: users.password,
                              controller: password,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock)),
                            )),
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('Edit'),
                            onPressed: () async {
                              Users newuser = Users(
                                  id: users.id,
                                  img: imgString,
                                  username: username.text,
                                  password: password.text);
                              var kontak = await dbHelper.updateuser(newuser);
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditStateUsers extends StatefulWidget {
  final Users users;
  EditStateUsers(this.users);
  @override
  _EditStateUsersState createState() => _EditStateUsersState(this.users);
}

class _EditStateUsersState extends State<EditStateUsers> {
  final Users users;
  _EditStateUsersState(this.users);
  DBHelper dbHelper = DBHelper();
  final formKey = new GlobalKey<FormState>();
  String imgString;
  String username, password;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validateAndSave(Users users) {
      final container = StateContainer.of(context);
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        container.updateUser(new_users: users);
      } else {
        print("Validation Error");
      }
    }

    pickImageFromGallery() {
      final _picker = ImagePicker();
      _picker.getImage(source: ImageSource.gallery).then((imgFile) async {
        imgString = Utility.base64String(await imgFile.readAsBytes());
      });
    }

    return Scaffold(
        //isi scaffold
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("login Page"),
        ),
        body: StreamBuilder<Users>(
            stream: dbHelper.loadUser(users.id).asStream(),
            builder: (context, values) {
              if (values.data != null) {
                return Container(
                  //isi body: Container
                  child: Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 35, 40, 50),
                      child: Column(
                        //isi child: Column
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: 'LexendDeca',
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: 120,
                                  height: 100,
                                  margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: (values.data.img != null)
                                              ? Utility.imageFromBase64String(
                                                      values.data.img)
                                                  .image
                                              : AssetImage(
                                                  "assets/imgprofile.jpg"),
                                          fit: BoxFit.fill),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 25,
                                  child: FlatButton(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Text(
                                      'Add Image',
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    onPressed: pickImageFromGallery,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
                            child: Column(
                              children: <Widget>[
                                Text("Email"),
                                Container(
                                    margin: EdgeInsets.only(top: 10, bottom: 8),
                                    child: TextFormField(
                                      validator: (status2) {
                                        if (status2.isEmpty) {
                                          return 'Jangan kosong';
                                        }
                                      },
                                      onSaved: (newusername) {
                                        username = newusername;
                                      },
                                      initialValue: values.data.username,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          prefixIcon: Icon(Icons.message)),
                                    )),
                                Text("Password"),
                                Container(
                                    margin: EdgeInsets.only(top: 10, bottom: 8),
                                    child: TextFormField(
                                      initialValue: values.data.password,
                                      onSaved: (newpassword) {
                                        password = newpassword;
                                      },
                                      validator: (status2) {
                                        if (status2.isEmpty) {
                                          return 'Jangan kosong';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock)),
                                    )),
                                FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Text('Edit'),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        Users newuser = Users(
                                            id: users.id,
                                            img: imgString,
                                            username: username,
                                            password: password);
                                        var kontak = await dbHelper
                                            .updateuser(newuser)
                                            .then((value) => print(value.img));
                                        Navigator.of(context).pop();
                                      }
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            }));
  }
}
