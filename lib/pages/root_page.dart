import 'package:flutter/material.dart';
import 'package:tul_mobileapp/logic/rest_api.dart';
import 'package:tul_mobileapp/constants.dart';
import '../logic/authentication.dart';
import 'home.dart';
import 'login_singup_page.dart';
import 'package:tul_mobileapp/objects/user.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String userId;
  String userEmail;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          userId = user?.uid;
          userEmail = user?.email;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        userId = user.uid.toString();
        userEmail = user.email.toString();
        print("userId: "+userId);
        print("userEmail: "+userEmail);
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      userId = "";
      userEmail = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
      {
        print("Not Determined");
        return buildWaitingScreen();
        
      }break;
      case AuthStatus.NOT_LOGGED_IN:
      {
      print("Not Logged");
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        
      }
      break;
      case AuthStatus.LOGGED_IN:
      if(userId != null){
        if (userId.length > 0) {
          print("----------------------------------");
          print("LOGGED IN");
          print("userId :"+userId);
          print("userEmail :"+userEmail);
          print("currentlyLoggedUser: ");
          print(currentlyLoggedUser);
          print("----------------------------------");
          if(currentlyLoggedUser == null)
          {
            print("Brak current tworze");
          currentlyLoggedUser = new User(id: userId, email: userEmail.toString(), name:  "", phoneNumber: "");
          // fetchDataFromDB();
          }
          print("Current jest wiec lece daleeej");
          // fetchDataFromDB();
          return new Home(
            userId: userId,
            userEmail: userEmail,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        }
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
