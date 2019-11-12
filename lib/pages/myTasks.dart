import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("My help requests"),
            backgroundColor: Colors.deepPurple,
          ),
          // body: TileItem(num: )
          body: ListView(
            children: new List.generate(
              myTasks.length,
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
                Material(
                  child: ListTile(
                    leading: Icon(Icons.album),
                    title: Text(myTasks[num].title),
                  subtitle: Text(tagsToString(myTasks[num])),
                ),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Click for details'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return new PageItem();
                              },
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
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
                    title: Text("Title : "+myTasks[num].title),
                    subtitle: Text("Phone number : "+myTasks[num].phoneNumber),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),

              Expanded(
                child: Container(
                  child: Column(children: <Widget>[
                    new Center(child: Text("Description "+myTasks[num].description)),
                    new Center(child: Text("Assined user's email : "+ myTasks[num].userAssigned)),
                    new Center(child: Text("Added : "+myTasks[num].dateAdded.toString())),

                    new Expanded(
                        child: new Container(
                      child: new Align(
                        alignment: Alignment.bottomRight,
                        child: new FlatButton.icon(
                          icon: Icon(Icons.delete,color: Colors.redAccent,),
                          label: Text('Delete'),
                          onPressed: () => {
                            deleteTask(myTasks[num].id),
                            fetchDataFromDB(),
                            Navigator.of(context).pop()
                          },
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
