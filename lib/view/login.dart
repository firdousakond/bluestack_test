import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isUsernameEmpty = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void onUsernameChanged(String value) {
    if (value.length < 3 || value.length > 10)
      isUsernameEmpty = true;
    else
      isUsernameEmpty = false;
  }

  void loginUser(BuildContext context) {
    // User 2: 9876543210 / password123

    if (usernameController.text.toString() == "9898989898" &&
        passwordController.text.toString() == "password123") {
      gotoHomeScreen(context);
    } else if (usernameController.text == "9876543210" &&
        passwordController.text == "password123") {
      gotoHomeScreen(context);
    } else
      Fluttertoast.showToast(
          msg: "Invalid username or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
  }

  void gotoHomeScreen(BuildContext context) {
    saveUserData();
    Navigator.pop(context);
    Navigator.pushNamed(context, "/homePage");
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? "";
    if (username != "") {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/homePage");
    }
  }

  saveUserData() async {
    print("username");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // home: Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("BlueStack App"),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/gamer.png",
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: usernameController,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          onUsernameChanged(value);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your username',
                          errorMaxLines: 1,
                          errorText: isUsernameEmpty == true
                              ? "Username must be between 3 and 10 character"
                              : null),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                      obscureText: _isObscure,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    MaterialButton(
                      height: 45.0,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () => {
                        if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty)
                          {loginUser(context)}
                      },
                      splashColor: Colors.red,
                    )
                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
