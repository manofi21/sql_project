// import 'package:flutter/material.dart';
// import 'package:sql_images/bloc/bloc.dart';
// import 'package:sql_images/photo.dart';
// import 'package:sql_images/utility.dart';

// class HomeDart extends StatefulWidget {
//   @override
//   _HomeDartState createState() => _HomeDartState();
// }

// class _HomeDartState extends State<HomeDart> {
//   @override
//   void initState() {
//     // bloc.fetchAllTodo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("widget.title"),
//         ),
//         body: StreamBuilder(
//             stream: bloc.allTodo,
//             builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
//               if (snapshot.hasData) {
//                 return gridView(snapshot);
//               } else if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               }
//               return Center(child: CircularProgressIndicator());
//             }));
//   }
// }

// gridView(AsyncSnapshot<List<Photo>> snapshot) {
//   return Padding(
//     padding: EdgeInsets.all(5.0),
//     child: GridView.count(
//       crossAxisCount: 2,
//       childAspectRatio: 1.0,
//       mainAxisSpacing: 4.0,
//       crossAxisSpacing: 4.0,
//       children: snapshot.data.map((photo) {
//         return InkWell(
//             child: Hero(
//           tag: "${photo.photo_name + photo.id.toString()}",
//           child: Container(
//               margin: EdgeInsets.all(10.0),
//               width: double.infinity,
//               height: 400.0,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black45,
//                       offset: Offset(0, 5),
//                       blurRadius: 8.0,
//                     ),
//                   ],
//                   image: DecorationImage(
//                       fit: BoxFit.fill,
//                       image: Utility.imageFromBase64String(photo.photo_name)
//                           .image))),
//         ));
//       }).toList(),
//     ),
//   );
// }
