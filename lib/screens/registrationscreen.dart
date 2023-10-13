import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:lockenedemo/screens/homescreen.dart';
import 'package:lockenedemo/screens/loginscreen.dart';
import 'package:provider/provider.dart';

import '../controllers/otpprovider.dart';
import '../controllers/registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController name = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();
  



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {

    var otpprovider = Provider.of<AccountIdHandler>(context);





    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Register', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Text('Enter your personal details to continue', style: TextStyle(fontSize: 20, ),),
                const SizedBox(height: 40,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: TextFormField(
                    controller: name,
                    autofocus: false,
                    keyboardType: TextInputType.name,
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
                      labelText: 'Name',
                      contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                    ),
                    validator: (var value) {
                      if(value!.isEmpty)
                      {
                        return "Please enter Name";
                      }
                      return null;
                    },
                    onSaved: (var name) {

                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: TextFormField(
                    controller: businessName,
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
                      labelText: 'Business Name',
                      contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                    ),
                    validator: (var value) {
                      if(value!.isEmpty)
                      {
                        return "Please enter Business Name";
                      }
                      return null;
                    },
                    onSaved: (var name) {

                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: TextFormField(
                    controller: password,
                    autofocus: false,
                    keyboardType: TextInputType.name,
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
                    validator: (var value){
                      if(value!.isEmpty)
                      {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: TextFormField(
                    controller: email,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: TextButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate())
                            {
                              print(name.text);
                              print(businessName.text);
                              print(email.text);
                              print(password.text);
                              getOtp(name.text, businessName.text, email.text, password.text).then((value) {
                                setState(() {
                                  context
                                      .read<AccountIdHandler>()
                                      .setAccountId(
                                      value['otp']);
                                });
                                print('response===='+value['otp'].toString());
                                print(value);



                                  

                              });
                              //Get.to(OtpPage());
                              print("Successful");
                            }else
                            {
                              print("Unsuccessful");
                            }
                          },
                          child: Text('Send Otp')
                      ),
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
                    onSaved: (var email) {

                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: TextFormField(
                    controller: otp,
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
                      labelText: 'Otp',
                      contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                    ),
                    // validator: (var value) {
                    //   if(value!.isEmpty)
                    //   {
                    //     return "Please enter Otp";
                    //   }
                    //   return null;
                    // },
                    onSaved: (var name) {

                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 45,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          if(_formKey.currentState!.validate())
                          {
                            print(otpprovider.otpDummy);
                            registerAndVerifyOTP(name.text, businessName.text, email.text, password.text).then((value) {
                              Get.to(HomePage());
                            });


                            //registerAndVerifyOTP(name.text,businessName.text,email.text,password.text);
                            //Get.to(OtpPage());
                            print("Successful");
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  'Invalid Otp',
                                )));
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black38,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      child: const Text('Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),

                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?"),
                    InkWell(
                      child: Text('Login here',
                          style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue.shade700)),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<dynamic> getOtp(String _name, String _businessName, String _email, String _password) async {

    final uri = Uri.parse(
        "https://fsm.mistrichacha.com/Fsm/SendOtpToServicePartner");
    final encoding = Encoding.getByName('utf-8');

    var response = await post(
      uri,
      body: jsonEncode({
        'language': 'en',
        'name': _name,
        'business_name': _businessName,
        'email': _email,
        'password': _password,
      }),
      headers: {
        'Client-Service': 'frontend-client',
        'Auth-Key': 'ExVfMAc9A8vQcE3zY0',
        'Content-Type': 'application/json',
      },
      encoding: encoding,
    );
    var data = json.decode(response.body);
    print(_name);
    print(_businessName);
    print(_email);
    print(_password);
    print(data);

    return data;
  }

  Future<dynamic> registerAndVerifyOTP(String _name, String _businessName, String _email, String _password) async {

    final uri = Uri.parse(
        "https://fsm.mistrichacha.com/Fsm/registerFsm");
    final encoding = Encoding.getByName('utf-8');

    var response = await post(
      uri,
      body: jsonEncode({
        'language': 'en',
        'name': _name,
        'business_name': _businessName,
        'email': _email,
        'password': _password,
      }),
      headers: {
        'Client-Service': 'frontend-client',
        'Auth-Key': 'ExVfMAc9A8vQcE3zY0',
        'Content-Type': 'application/json',
      },
      encoding: encoding,
    );
    if (response.statusCode == 200) {
      // Registration and OTP verification successful, handle the response
      final responseJson = json.decode(response.body);
      Get.to(HomePage());
    } else {
      // Handle API error
      print("Unsuccessful");
    }
    //var data = json.decode(response.body);
    // print(_name);
    // print(_businessName);
    // print(_email);
    // print(_password);
    // print(data);
    //
    // return data;
  }
}


