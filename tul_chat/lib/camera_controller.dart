//import 'dart:convert';
//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:camera/camera.dart';
//import 'package:flutter/services.dart';
//import 'package:path/path.dart' show join;
//import 'package:path_provider/path_provider.dart';
//
//import '../Colors.dart';
//import './object_managment.dart';
//
//class TakePictureScreen extends StatefulWidget {
//  final CameraDescription camera;
//  final int taskId;
//
//  const TakePictureScreen({Key key, @required this.camera, this.taskId})
//      : super(key: key);
//
//  @override
//  TakePictureScreenState createState() => TakePictureScreenState();
//}
//
//class TakePictureScreenState extends State<TakePictureScreen> {
//  // Add two variables to the state class to store the CameraController and
//  // the Future.
//  CameraController _controller;
//  Future<void> _initializeControllerFuture;
//
//  @override
//  void initState() {
//    super.initState();
//    // To display the current output from the camera,
//    // create a CameraController.
//    _controller = CameraController(
//      // Get a specific camera from the list of available cameras.
//      widget.camera,
//      // Define the resolution to use.
//      ResolutionPreset.medium,
//    );
//
//    // Next, initialize the controller. This returns a Future.
//    _initializeControllerFuture = _controller.initialize();
//  }
//
//  @override
//  void dispose() {
//    // Dispose of the controller when the widget is disposed.
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//    ]);
//    return Scaffold(
//      appBar: AppBar(backgroundColor: darkGrey, title: Text('Take a picture')),
//      // Wait until the controller is initialized before displaying the
//      // camera preview. Use a FutureBuilder to display a loading spinner
//      // until the controller has finished initializing.
//      body: FutureBuilder<void>(
//        future: _initializeControllerFuture,
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.done) {
//            // If the Future is complete, display the preview.
//            return CameraPreview(_controller);
//          } else {
//            // Otherwise, display a loading indicator.
//            return Center(child: CircularProgressIndicator());
//          }
//        },
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.camera_alt),
//        backgroundColor: Colors.redAccent,
//        // Provide an onPressed callback.
//        onPressed: () async {
//          // Take the Picture in a try / catch block. If anything goes wrong,
//          // catch the error.
//          try {
//            // Ensure that the camera is initialized.
//            await _initializeControllerFuture;
//
//            // Construct the path where the image should be saved using the
//            // pattern package.
//            final path = join(
//              // Store the picture in the temp directory.
//              // Find the temp directory using the `path_provider` plugin.
//              (await getTemporaryDirectory()).path,
//              '${DateTime.now()}.png',
//            );
//
//            // Attempt to take a picture and log where it's been saved.
//            await _controller.takePicture(path);
//            // If the picture was taken, display it on a new screen.
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => DisplayPictureScreen(
//                    imagePath: path,
//                    taskId: widget.taskId,
//                  ),
//                ));
//          } catch (e) {
//            // If an error occurs, log the error to the console.
//            print(e);
//          }
//        },
//      ),
//    );
//  }
//}
//
//class DisplayPictureScreen extends StatelessWidget {
//  final String imagePath;
//  final int taskId;
//
//  const DisplayPictureScreen({Key key, this.imagePath, this.taskId})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//          backgroundColor: darkGrey,
//          title: Text('Send the picture to the operator')),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Column(
//                children: <Widget>[
//                  Image.file(
//                    File(imagePath),
//                    width: MediaQuery.of(context).size.width,
//                    height: MediaQuery.of(context).size.height * 0.8,
//                  ),
//                  Row(
//                    children: <Widget>[
//                      FlatButton.icon(
//                          icon: Icon(Icons.send),
//                          shape: StadiumBorder(),
//                          color: darkGrey,
//                          textColor: lightGrey,
//                          label: Text('Send'),
//                          onPressed: () => showDialog<void>(
//                            context: context,
//                            builder: (BuildContext context) {
//                              return AlertDialog(
//                                title: const Text(
//                                  'Are you sure?',
//                                  textAlign: TextAlign.center,
//                                ),
//                                content: const Text(
//                                    "Do you wish to send this photo to the operator ?"),
//                                actions: <Widget>[
//                                  FlatButton(
//                                      onPressed: (() async {
//                                        showProcessingDialog(
//                                            context, "Processing...");
//                                        await sendImage(imagePath, taskId);
//                                        Navigator.pop(context);
//                                        Navigator.pop(context);
//                                      }),
//                                      child: Icon(
//                                        Icons.check_circle,
//                                        color: Colors.greenAccent,
//                                      )),
//                                  FlatButton(
//                                      onPressed: (() {
//                                        Navigator.of(context).pop(false);
//                                      }),
//                                      child: Icon(
//                                        Icons.cancel,
//                                        color: Colors.redAccent,
//                                      ))
//                                ],
//                              );
//                            },
//                          )),
//                      Padding(
//                        padding: EdgeInsets.all(2.0),
//                      ),
//                      FlatButton.icon(
//                          icon: Icon(Icons.camera),
//                          shape: StadiumBorder(),
//                          label: Text('Retake a picture'),
//                          onPressed: () => Navigator.of(context).pop())
//                    ],
//                  )
//                ],
//              )
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<Null> sendImage(String imagePath, int taskId) async {
//    var bytes = await new File(imagePath).readAsBytes();
//    var imgurUrl = 'https://api.imgur.com/3/image';
//    var imgurKeyHeaders = {
//      'Authorization': 'Client-ID fed08718101493f',
//      'Content-Type': 'application/x-www-form-urlencoded'
//    };
//    var imgurBody = {
//      'image': base64Encode(bytes),
//    };
//
//    var jsonRe = await post(imgurUrl, imgurKeyHeaders, imgurBody);
//
//    var linkResponse = json.decode(jsonRe)['data']['link'];
//    var jsonRes = await post(
//        'http://192.168.154.60:8080/Thingworx/Things/SEC.TaskManager/Services/ReceiveTaskImage',
//        userKeyHeaders,
//        json.encode({'taskId': taskId, 'bytes': linkResponse}));
//    print(jsonRes);
//  }
//}
