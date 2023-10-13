import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lockenedemo/screens/registrationscreen.dart';

import 'homescreen.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future login(String username,String password)async{
    var url = "https://fsm.mistrichacha.com/Fsm/FsmLogin";

    var response = await http.post(Uri.parse(url),body: {
      "email" : _email.text,
      "password" : _password.text,
      "user_type": 'Admin',
    },
    headers: {
    'Client-Service': 'frontend-client',
    'Auth-Key': 'ExVfMAc9A8vQcE3zY0',

    }
    );



    var data = json.decode(response.body);
    if (data['response']['status'] =="success") {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(
        msg: data['response']['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height,
              child: Stack(
                children: [


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 180
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)),
                        SizedBox(height: 50,),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                          child: TextFormField(
                            validator: (var value){
                              if(value!.isEmpty)
                              {
                                return "Please enter email";
                              }
                              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                              {
                                return "Please enter valid email";
                              }
                              return  null;
                            },
                            controller: _email,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1,color: Colors.grey.shade100,style: BorderStyle.solid)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1,color: Colors.black54,style: BorderStyle.solid)
                              ),
                              isCollapsed: true,

                              labelText: 'Email',
                              contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                              floatingLabelStyle: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                          child: TextFormField(
                            controller: _password,
                            autofocus: false,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1,color: Colors.grey.shade100,style: BorderStyle.solid)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1,color: Colors.black54,style: BorderStyle.solid)
                              ),
                              isCollapsed: true,
                              labelText: 'Password',
                              contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                              floatingLabelStyle: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),

                        Center(
                          child: SizedBox(
                            height: 45,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: (){
                                login(_email.text, _password.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black38,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                              ),
                              child: const Text('Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account ?"),
                            InkWell(
                              child: Text('Create new account.',
                                  style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue.shade700)),
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationPage()));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('By continuing you agree to our '),
                        Text('Terms of Services and Conditions.',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.deepPurple)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


