import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/api.dart';
import 'package:flutter_ecommerce/constants/themes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtphone = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  late bool isloading = false;
  @override
  Widget build(BuildContext context) {
    Future<void> register() async {
      // Create a Map containing the login data
      Map<String, dynamic> registerData = {
        'email': txtemail.text,
        'password': txtpassword.text,
        'name': txtname.text,
        'phone': txtphone.text,
      };

      // Convert the login data to JSON
      String jsonData = jsonEncode(registerData);
      // Set the request headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      setState(() {
        isloading = true;
      });
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse("$kEndPointUrl/register"),
        headers: headers,
        body: jsonData,
      );
      print(jsonData);
      // Check the response status code
      if (response.statusCode == 200) {
        // Request was successful, handle the response data
        var responseData = jsonDecode(response.body);
        print(responseData.toString());
        setState(() {
          isloading = false;
        });
        Get.snackbar("Successfully", "User Registered✅",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        // ignore: use_build_context_synchronously
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => HomePage()),
        //     (route) => false);
        // setState(() {
        //   isloading = false;
        // });
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
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    )),
                const Gap(50),
                Center(
                  child: SvgPicture.asset(
                    'assets/general/store_brand_white.svg',
                    color: kPrimaryColor,
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(30),
                      TextFormField(
                        controller: txtname,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          prefixIconColor: kPrimaryColor,
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: "Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
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
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            prefixIconColor: kPrimaryColor,
                            filled: true,
                            fillColor: kWhiteColor,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            hintText: "Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      const Gap(30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            minimumSize: const Size(double.infinity, 50)),
                        onPressed: () {
                          if (_formKey.currentState!.validate() == false) ;
                          register();
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already, You have an account please?",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18, color: kPrimaryColor),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
                  ),
                ),
          )),
    );
  }
}
