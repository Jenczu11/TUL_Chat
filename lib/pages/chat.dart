import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tul_mobileapp/constants.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:tul_mobileapp/objects/task.dart';
import 'package:url_launcher/url_launcher.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Pending help requests"),
            backgroundColor: Colors.deepPurple,
          ),
          // body: TileItem(num: )
          body: ListView(
            children: new List.generate(
              taskList.length,
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
                  child:
                      Image.network("https://picsum.photos/485/384?image=$num"),
                ),
                Material(
                  child: ListTile(
                    leading: Icon(Icons.album),
                    title: Text(taskList[num].title),
                    subtitle: Text("Tags : " + tagsToString(taskList[num])),
                  ),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Click for more details'),
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
                    title: Text("Title : "+taskList[num].title),
                    subtitle: Text("Phone number : "+taskList[num].phoneNumber),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),

              Expanded(
                child: Container(
                  child: Column(children: <Widget>[
                    new Center(
                        child:
                            Text("Description :" + taskList[num].description)),
                    Text("Date added :" + taskList[num].dateAdded.toString()),
                    Image.network(
                      "https://picsum.photos/485/384?image=$num",
                      height: 300,
                    ),
                    Visibility(
                      visible:taskList[num].isAssigned,
                      child: Column(children: <Widget>[
                        Text("User assigned :" + taskList[num].userAssigned),
                        Text("Date assigned :" + taskList[num].dateAssigned)
                      ],),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible:
                              phoneNumberVisibility(taskList[num].phoneNumber),
                          child: FlatButton.icon(
                            label: Text("Call me"),
                            icon: Icon(
                              Icons.phone_in_talk,
                              color: Colors.green,
                            ),
                            onPressed: (() async {
                              await launch("tel:${taskList[num].phoneNumber}");
                            }),
                          ),
                        ),
                        FlatButton.icon(
                          label: Text("Mail me"),
                          icon: Icon(
                            Icons.mail,
                            color: Colors.redAccent,
                          ),
                          onPressed: (() async {
                            await launch("mailto:${taskList[num].email}");
                          }),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: acceptButtonVisibility(taskList[num]),
                            child: FlatButton.icon(
                              label: Text("Accept"),
                              icon: Icon(
                                Icons.check,
                                color: Colors.greenAccent,
                              ),
                              onPressed: (() async {
                                await assignUserToTask(
                                    taskList[num].id, currentlyLoggedUser.id);
                                Navigator.of(context).pop();
                              }),
                            ),
                          ),
                        ]),
                    new Expanded(
                        child: new Container(
                      child: new Align(
                        alignment: Alignment.bottomRight,
                        child: new FlatButton.icon(
                          icon: Icon(Icons.arrow_back),
                          label: Text(''),
                          onPressed: () => {Navigator.of(context).pop()},
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 24),
                    ))
                  ]),
                ),
              ),
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

  bool phoneNumberVisibility(String phoneNumber) {
    if (phoneNumber == "") {
      return false;
    } else
      return true;
  }

  acceptButtonVisibility(Task task) {
    if(task.isAssigned == false){
      return true;
    }
    else return false;
  }


}
