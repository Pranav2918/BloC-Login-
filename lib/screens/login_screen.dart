import 'package:bloc_pattern/bloc/login_bloc.dart';
import 'package:bloc_pattern/screens/homepage.dart';
import 'package:bloc_pattern/screens/register_screen.dart';
import 'package:bloc_pattern/theme/textstyling.dart';
import 'package:bloc_pattern/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Container(
            margin: EdgeInsets.only(
                left: 35,
                right: 35,
                top: MediaQuery.of(context).size.height / 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                headText('Login'),
                SizedBox(height: 18),

                //Email
                StreamBuilder(
                  stream: bloc.loginEmail,
                  builder: (context, snapshot) => TextField(
                    cursorColor: Colors.red,
                    onChanged: bloc.changeLoginEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 0, 21, 0.9))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        labelStyle: BTextStyling.textField,
                        errorText:
                            snapshot.hasError ? '${snapshot.error}' : null),
                  ),
                ),
                SizedBox(height: 30),

                //Password
                StreamBuilder(
                  stream: bloc.loginPassword,
                  builder: (context, AsyncSnapshot<String> snapshot) =>
                      TextField(
                    cursorColor: Colors.red,
                    onChanged: bloc.changeLoginPassword,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 0, 21, 0.9))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Password',
                        labelStyle: BTextStyling.textField,
                        hintText: 'Enter Password',
                        errorText:
                            snapshot.hasError ? '${snapshot.error}' : null),
                  ),
                ),

                //Button
                SizedBox(height: 28),
                _buildButton(context),
                SizedBox(height: 18),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Need an Account?',
                      style: TextStyle(color: Colors.black)),
                  WidgetSpan(child: SizedBox(width: 8)),
                  TextSpan(
                      text: 'Register',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ));
                        })
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildButton(context) {
  final bloc = Provider.of<LoginBloc>(context, listen: false);
  return StreamBuilder<Object>(
    stream: bloc.isValid,
    builder: (context, snapshot) => GestureDetector(
      onTap: snapshot.hasError || !snapshot.hasData
          ? null
          : () {
              bloc.submit();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: snapshot.hasError || !snapshot.hasData
              ? Colors.grey
              : Color.fromRGBO(255, 0, 21, 0.9),
        ),
        child: Center(child: Text('Login', style: BTextStyling.buttonText)),
      ),
    ),
  );
}
