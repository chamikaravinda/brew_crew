import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading =false;


  //text filed state
  String email = '';
  String password = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(
                Icons.person,
                color:Colors.white
              ),
              label:Text(
                  'Register',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                validator: (val)=>val.isEmpty ? 'Enter an email' :null,
                onChanged: (val){
                  setState(() => email=val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=>val.length<6 ? 'Enter a password longer than 6 characters' :null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password=val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() =>loading=true);
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error ='Wrong email or password';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
