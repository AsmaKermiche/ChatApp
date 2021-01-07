import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'chatroomscreen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  AuthService _authService = new AuthService ();
  DatabaseMethodes _databaseMethodes = new DatabaseMethodes();
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  SignMeUp() {
    if (formkey.currentState.validate()) {
      Map<String,String> userInfoMap = {
        "name" : usernameEditingController.text,
        "email" : emailEditingController.text,
      };
      setState(() {

        isLoading = true;
      });
     _authService.signUpWithEmailAndPassword(emailEditingController.text, passwordEditingController.text).then((val){
       print("$val");

       _databaseMethodes.uploadUserInfo(userInfoMap);


       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(child:Center(child:CircularProgressIndicator())) :
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Form(
                key: formkey,
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 50.0,
                    child: TextFormField(
                      validator: (val) {
                        return val.isEmpty || val.length < 2
                            ? "Please provide a valid username"
                            : null;
                      },
                      controller: usernameEditingController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(0xff1F1F1F)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person, color: Colors.teal),
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Enter your username here',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 50.0,
                    child: TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Enter correct email";
                      },
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(0xff1F1F1F)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail, color: Colors.teal),
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Enter your e-mail here',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 50.0,
                    child: TextFormField(
                      validator: (val) {
                        return val.length < 6
                            ? "Enter Password 6+ characters"
                            : null;
                      },
                      controller: passwordEditingController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: TextStyle(color: Color(0xff1F1F1F)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.visibility_off),
                        prefixIcon: Icon(Icons.lock, color: Colors.teal),
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Enter your password here',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  SignMeUp();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.tealAccent,
                        ],
                      )),
                  width: 240,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  //TODO
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  width: 240,
                  child: Text(
                    "Sign Up with Google",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));},
                    child:
                  Text(
                    "Sign in now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
