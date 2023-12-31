import 'package:ecommerce_int2/screens/auth/forgot_password_page.dart';
import 'package:ecommerce_int2/screens/auth/login_controller.dart';
import 'package:get/get.dart';
import 'register_page.dart';
import 'package:flutter/material.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    Widget company_logo = Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Adjust padding as needed
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: ClipOval(
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding outside the image
              child: Image.asset('assets/transithomes-1.png'),
            ),
          ),
        ),
      ),
    );

    Widget welcomeBack = Text(
      'Welcome Back User',
      style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Login to your account using\nyour credentials',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 0,
      child: InkWell(
        onTap: () async {
          //Navigator.of(context)
          //  .push(MaterialPageRoute(builder: (_) => IntroPage()));
          if (_formKey.currentState!.validate()) {
            try {
              await LoginController.instance.login();
              controller.email.clear();
              controller.password.clear();
              print('user logged in');
            } catch (e) {
              // Handle login failure, display an error message, etc.
              print('Login failed');
            }
          }

          //print("The email is ${controller.email}");
          // print("The password is ${controller.password}");
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Log In",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(177, 7, 160, 1),
                    Color.fromRGBO(159, 48, 92, 1),
                    Color.fromRGBO(217, 5, 107, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(
      height: 240,
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 32.0, right: 12.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller: controller.email,
                      style: TextStyle(fontSize: 16.0),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          //labelText: 'Email',
                          hintText: 'Email'),
                      validator: (value) {
                        RegExp regExp = new RegExp(emailPattern);
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // Add more validation if needed
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller: controller.password,
                      style: TextStyle(fontSize: 16.0),
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          hintText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be more than 6 characters';
                        }
                        // Add more validation if needed
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            loginButton,
          ],
        ),
      ),
    );

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ForgotPasswordPage())),
            child: Text(
              'Forgot your password? ',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(248, 230, 237, 0.486),
                fontSize: 12.0,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => RegisterPage())),
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg-login.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                company_logo,
                Spacer(flex: 1),
                welcomeBack,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                loginForm,
                Spacer(flex: 2),
                forgotPassword
              ],
            ),
          )
        ],
      ),
    );
  }
}
