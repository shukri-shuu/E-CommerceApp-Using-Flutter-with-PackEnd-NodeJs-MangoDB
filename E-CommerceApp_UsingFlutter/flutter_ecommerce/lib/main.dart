import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/home_page.dart';
import 'package:flutter_ecommerce/views/login.dart';
import 'package:flutter_ecommerce/views/onboarding_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const ProviderScope(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Onboarding(),
    ),
  ));
}
