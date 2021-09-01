import 'package:bloc_pattern/bloc/register_bloc.dart';
import 'package:bloc_pattern/screens/homepage.dart';
import 'package:bloc_pattern/theme/textstyling.dart';
import 'package:bloc_pattern/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Container(
            margin: EdgeInsets.only(
                left: 35,
                right: 35,
                top: MediaQuery.of(context).size.height / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                headText('Register'),
                SizedBox(height: 18),

                //Name
                StreamBuilder(
                  stream: bloc.registerName,
                  builder: (context, AsyncSnapshot<String> snapshot) =>
                      TextField(
                    cursorColor: Colors.red,
                    onChanged: bloc.changeRegisterName,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 0, 21, 0.9))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Name',
                        labelStyle: BTextStyling.textField,
                        hintText: 'Enter Name',
                        errorText:
                            snapshot.hasError ? '${snapshot.error}' : null),
                  ),
                ),
                SizedBox(height: 10),

                //Email
                StreamBuilder(
                  stream: bloc.registerEmail,
                  builder: (context, AsyncSnapshot<String> snapshot) =>
                      TextField(
                    cursorColor: Colors.red,
                    onChanged: bloc.changeRegisterEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 0, 21, 0.9))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Email',
                        labelStyle: BTextStyling.textField,
                        hintText: 'Enter Email',
                        errorText:
                            snapshot.hasError ? '${snapshot.error}' : null),
                  ),
                ),
                SizedBox(height: 10),

                //Password
                StreamBuilder(
                  stream: bloc.registerPassword,
                  builder: (context, AsyncSnapshot<String> snapshot) =>
                      TextField(
                    cursorColor: Colors.red,
                    onChanged: bloc.changeRegisterPassword,
                    obscureText: _isVisible ? false : true,
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
                      errorText: snapshot.hasError ? '${snapshot.error}' : null,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //Confirm Password
                StreamBuilder(
                  stream: bloc.registerConfirmPassword,
                  builder: (context, AsyncSnapshot<String> snapshot) =>
                      TextField(
                    cursorColor: Colors.red,
                    onChanged: bloc.changeConfirmPassword,
                    obscureText: _isVisible ? false : true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                              _isVisible
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                              color: _isVisible ? Color.fromRGBO(255, 0, 21, 0.9) : Colors.grey),
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 0, 21, 0.9))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Confirm Password',
                        labelStyle: BTextStyling.textField,
                        hintText: 'Confirm Password',
                        errorText:
                            snapshot.hasError ? '${snapshot.error}' : null),
                  ),
                ),
                SizedBox(height: 28),
                _buildButton(context),
                SizedBox(height: 18),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Have an Account?',
                      style: TextStyle(color: Colors.black)),
                  WidgetSpan(child: SizedBox(width: 8)),
                  TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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

Widget _buildButton(BuildContext context) {
  final bloc = Provider.of<RegisterBloc>(context, listen: false);

  return StreamBuilder<Object>(
      stream: bloc.isValid,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.hasError || !snapshot.hasData
              ? null
              : () {
                  bloc.submit();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
          child: Container(
            height: 40,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: snapshot.hasError || !snapshot.hasData
                  ? Colors.grey
                  : Color.fromRGBO(255, 0, 21, 0.9),
            ),
            child: Text("Register", style: BTextStyling.buttonText),
          ),
        );
      });
}
