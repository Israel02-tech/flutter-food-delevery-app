import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/admin/admin_login.dart';
import 'package:food_delivery_app/admin/home_admin.dart';
import 'package:food_delivery_app/firebase_options.dart';
import 'package:food_delivery_app/pages/bottom_nav.dart';
import 'package:food_delivery_app/pages/forgetpassword.dart';
import 'package:food_delivery_app/pages/home.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/pages/onboarding.dart';
import 'package:food_delivery_app/pages/signUp.dart';
import 'package:food_delivery_app/pages/wallet.dart';
import 'widget/app_constraint.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNav(),
    );
  }
}
