import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersTasks extends StatefulWidget {
  @override
  _UsersTasksState createState() => _UsersTasksState();
}

class _UsersTasksState extends State<UsersTasks> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

          appBar: AppBar(
            title: Text("Your help requests"),
            backgroundColor: Colors.deepPurple,
          ),
          // body: TileItem(num: )
          body: ListView(
            children: new List.generate(
              userTaskList.length,
              (int index) {
                return TileItem(num: index);
              },
            ),
          )),
    );
  }
}

class TileItem extends StatelessWidget {
  final int num;

  const TileItem({Key key, this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "card$num",
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                 AspectRatio(
                   aspectRatio: 485.0 / 384.0,
                   child: Image.network("https://picsum.photos/485/384?image=$num"),
                 ),
                Material(
                  child: ListTile(
                    leading: Icon(Icons.album),
                    title: Text(userTaskList[num].title),
                  subtitle: Text(tagsToString(userTaskList[num])),
                ),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[

                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              bottom: 0.0,
              right: 0.0,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 300));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PageItem(num: num);
                        },
                        fullscreenDialog: false,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final int num;

  const PageItem({Key key, this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    AppBar appBar = new AppBar(
      primary: true,
      leading: IconTheme(
          data: IconThemeData(color: Colors.white), child: CloseButton()),
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: [
      //         Colors.black.withOpacity(0.4),
      //         Colors.black.withOpacity(0.1),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.transparent,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Stack(children: <Widget>[
      Hero(
        tag: "card$num",
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: mediaQuery.padding.top * 2,
              ),
              // AspectRatio(
              //   aspectRatio: 485.0 / 384.0,
              //   child: Image.network("https://picsum.photos/485/384?image=$num"),
              // ),

              InkWell(
                child: Material(
                  child: ListTile(
                    title: Text(userTaskList[num].title),
                    subtitle: Text(userTaskList[num].phoneNumber),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),

              Expanded(
                child: Container(
                  child: Column(children: <Widget>[
                    new Center(child: Text("Description : "+ userTaskList[num].description)),
                    new Expanded(
                        child: new Container(
                      child: new Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              icon: Icon(Icons.delete,color: Colors.red,),
                              label: const Text('Delete Task',style: TextStyle(color: Colors.black),),
                              onPressed: () {
                                deleteTask(userTaskList[num]);
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(width: 180,),
                            FlatButton.icon(
                              label: Text("Back"),
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => {
                                Navigator.of(context).pop()
                              },
                            ),
                          ],

                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 24),
                    ))
                  ]),
                ),
              ),

              //      ButtonTheme.bar( // make buttons use the appropriate styles for cards
              //   child: ButtonBar(
              //     children: <Widget>[
              //       FlatButton(
              //         child: const Text('Pomagam'),
              //         onPressed: () { },
              //       ),

              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Container(
            height: mediaQuery.padding.top,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: appBar.preferredSize.height),
            // child: appBar,
          )
        ],
      ),
    ]);
  }
}
