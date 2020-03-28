import 'package:brewcrew/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text filed state
  String email = '';
  String password = '';
  String error ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
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
                'Sign In',
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
                validator: (val)=>val.isEmpty ? 'Enter an email' :null,
                onChanged: (val){
                  setState(() => email=val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
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
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = _authService.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error ='Please supply a valid email';
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
