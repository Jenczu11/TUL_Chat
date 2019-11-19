import 'package:flutter/material.dart';

import 'const.dart';
class StickerContainer extends StatelessWidget {
  final Function func;
  const StickerContainer(
      {Key key, this.func})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => func('mimi1', 2),
                child: new Image.asset(
                  'images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => func('mimi2', 2),
                child: new Image.asset(
                  'images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => func('mimi3', 2),
                child: new Image.asset(
                  'images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => func('mimi4', 2),
                child: new Image.asset(
                  'images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => func('mimi5', 2),
                child: new Image.asset(
                  'images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => func('mimi6', 2),
                child: new Image.asset(
                  'images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
//          Row(
//            children: <Widget>[
//              FlatButton(
//                onPressed: () => func('mimi7', 2),
//                child: new Image.asset(
//                  'images/mimi7.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => func('mimi8', 2),
//                child: new Image.asset(
//                  'images/mimi8.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//              FlatButton(
//                onPressed: () => func('mimi9', 2),
//                child: new Image.asset(
//                  'images/mimi9.gif',
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                ),
//              ),
//
//            ],
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              onPressed: () => func('tenor', 2),
              child: new Image.asset(
                'images/tenor.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => func('tenor', 2),
              child: new Image.asset(
                'images/tenor.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => func('tenor', 2),
              child: new Image.asset(
                'images/tenor.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            )
          ],)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }
  }


