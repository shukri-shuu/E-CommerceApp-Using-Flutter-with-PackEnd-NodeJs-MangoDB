import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/api.dart';
import 'package:flutter_ecommerce/constants/themes.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:flutter_ecommerce/views/Signup.dart';
import 'package:flutter_ecommerce/views/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http; //alias name
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController txtemail = TextEditingController();

  TextEditingController txtpassword = TextEditingController();
  late String currentUser;
  bool isloading = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      // Create a Map containing the login data
      Map<String, dynamic> loginData = {
        'email': txtemail.text,
        'password': txtpassword.text,
      };
      // Convert the login data to JSON
      String jsonData = jsonEncode(loginData);
      // Set the request headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      setState(() {
        isloading = true;
      });
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse("$kEndPointUrl/login"),
        headers: headers,
        body: jsonData,
      );
      print(jsonData);
      // Check the response status code
      if (response.statusCode == 200) {
        // currentUser = txtemail.text;
        //  print("current user:"+currentUser);
        // Request was successful, handle the response data
        var responseData = jsonDecode(response.body);
        print(responseData.toString());
        Get.snackbar("Successfully", "$responseData",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
        setState(() {
          isloading = false;
        });
        // Process the response data
      } else {
        setState(() {
          isloading = false;
        });
        // Request failed, handle the error
        print('Login request failed with status: ${response.statusCode}');
        Get.snackbar(
            "Login request failed with status:", "${response.statusCode}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }

    return Scaffold(
      backgroundColor: kWhiteColor.withOpacity(0.95),
      body: SafeArea(
          child: ModalProgressHUD(
        color: kPrimaryColor,
        inAsyncCall: isloading,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                const Gap(100),
                Container(
                  height: 100,
                  width: double.infinity,
                  // child: Icon(CupertinoIcons.lock,),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/general/store_brand_white.svg',
                      color: kPrimaryColor,
                      // width: 180,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   "Login",
                      //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      // ),
                      const Gap(30),
                      TextFormField(
                        controller: txtemail,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          prefixIconColor: kPrimaryColor,
                          filled: true,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: "Gmail",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              isloading = false;
                            });
                            return "E-mail is required";
                          }
                          if (!value.isEmail) {
                            return "Invalid E-mail, please enter correct E-mail";
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: txtpassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            prefixIconColor: kPrimaryColor,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = false;
                                  });
                                  if (hidePassword == true) {
                                    Icons.visibility;
                                  } else {
                                    Icons.visibility_off;
                                  }
                                },
                                icon: const Icon(Icons.visibility_off)),
                            suffixIconColor: kPrimaryColor,
                            filled: true,
                            fillColor: kWhiteColor,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            hintText: "Password"),
                        obscureText: hidePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            if (value!.length < 6) {
                              return 'Invalid Password Length';
                            }
                            setState(() {
                              isloading = false;
                            });
                            return "Password is required";
                          }

                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            minimumSize: const Size(double.infinity, 50)),
                        onPressed: () {
                          if (_formKey.currentState!.validate() == false) ;
                          login();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(25),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 18, color: kPrimaryColor),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
