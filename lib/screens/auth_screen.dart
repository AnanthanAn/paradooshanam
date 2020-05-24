import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradooshanam/screens/chat_screen.dart';

class AuthScreen extends StatefulWidget {
  final _auth = FirebaseAuth.instance;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _key = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  var _isLogin = true;
  var isLoading = false;

  void _trySubmit() async {
    bool isValid = _key.currentState.validate();
    if (isValid) {
      isLoading = true;
      AuthResult _authResult;
      _key.currentState.save();
      if (_isLogin) {
        print('Attempting login');
        _authResult = await widget._auth
            .signInWithEmailAndPassword(email: _email, password: _password);
      } else {
        print('Attempting signup');
        _authResult = await widget._auth
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Firestore.instance
            .collection('user')
            .document(_authResult.user.uid)
            .setData({'username': _username, 'email': _email});
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _email = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  enabled: !_isLogin,
                  decoration: InputDecoration(labelText: 'Username'),
                  onSaved: (val) {
                    _username = val;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _password = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                isLoading ? CircularProgressIndicator() :RaisedButton(
                  child:_isLogin ? Text('Login') : Text('Signup'),
                  onPressed: (){
                    setState(() {
                      isLoading = true;
                    });
                    _trySubmit();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: _isLogin ? Text('New Here? SignUp') : Text('Already have an account? Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
