import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {

  final Function? toggleView;
  Register({this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth =  AuthService();

  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';

  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign up to Brew crew' , style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown[400],
        actions: [
          TextButton.icon(
            onPressed: () {
               widget.toggleView!();
            },
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Sign In', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter a 6+ chars password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  setState(() {loading = true;});
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      error = 'please enter a valid email';
                      loading = false;
                    });
                  }
                }
                },
                child: Text('Register' , style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.pink[300])),
              ),
              SizedBox(height: 12),
              Text(error, style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}
