import 'package:flutter/material.dart';
import 'package:sql_images/commant.dart';
import 'package:sql_images/utility.dart';

class BuildCommant extends StatefulWidget {
  final ForWidgetCommand index;
  BuildCommant(this.index);
  @override
  _BuildCommantState createState() => _BuildCommantState(this.index);
}

class _BuildCommantState extends State<BuildCommant> {
  final ForWidgetCommand index;
  _BuildCommantState(this.index);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(index.strings());
    // print("tolol");
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
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
          child: CircleAvatar(
            child: ClipOval(
              child: Image(
                height: 50.0,
                width: 50.0,
                // image: AssetImage(index.picture),
                image: (index.picture != null)
                    ? Utility.imageFromBase64String(index.picture).image
                    : AssetImage("assets/imgprofile.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          index.name_user_commant,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(index.commant),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite_border,
          ),
          color: Colors.grey,
          onPressed: () => print('Like comment'),
        ),
      ),
    );
  }
}

class ListCommants extends StatelessWidget {
  final List<ForWidgetCommand> allCommants;
  const ListCommants({Key key, this.allCommants}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: allCommants.map((e) => BuildCommant(e)).toList(),
      ),
    );
  }
}