import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/themes.dart';
import 'package:flutter_ecommerce/views/login.dart';
import 'package:gap/gap.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/onboard.jpeg"), fit: BoxFit.cover),),
                child: Container(decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:  [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.80),
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    const Text("", style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 20),
                       child: ElevatedButton(onPressed:  (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => LoginScreen())), (route) => false);
                       },
                                         style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: Colors.white,
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(double.infinity, 40)
                                         ), child: const Text("Getting started", ),
                       ),
                     ),
                    const Gap(20),
                  ]),
                ),
                ),
      ),
    );
  }
}