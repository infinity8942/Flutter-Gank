import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerAccount = TextEditingController();
    final controllerPassword = TextEditingController();
    controllerAccount.addListener(() {
      print('input ${controllerAccount.text}');
    });
    controllerPassword.addListener(() {
      print('input ${controllerPassword.text}');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            loginHeader(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                    child: TextField(
                      maxLines: 1,
                      controller: controllerAccount,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_box),
                        hintText: "Enter your phone number",
                        labelText: "Phone Number",
                      ),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      onSubmitted: (text) {
                        //内容提交(按回车)的回调
                        print('submit $text');
                      },
                    ),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                    child: TextField(
                      maxLines: 1,
                      controller: controllerPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter your password",
                        labelText: "Password",
                      ),
                      onChanged: (text) {
                        //内容改变的回调
                        print('change $text');
                      },
                      onSubmitted: (text) {
                        //内容提交(按回车)的回调
                        print('submit $text');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/main');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "SIGN UP FOR AN ACCOUNT",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.lightBlue,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome to Flutter Gank",
            style:
                TextStyle(fontWeight: FontWeight.w700, color: Colors.lightBlue),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
}
