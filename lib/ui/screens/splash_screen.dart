import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:own_app/data/models/auth_utility.dart';
import 'package:own_app/ui/screens/auth/login_screen.dart';
import 'package:own_app/ui/screens/bottom_nav_base_screen.dart';
import 'package:own_app/ui/utils/assets_utils.dart';
import 'package:own_app/ui/widgets/screen_background.dart';
import 'package:own_app/ui/screens/email_verification_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {
     await Future.delayed(Duration(seconds: 4));
     Navigator.pushAndRemoveUntil(
       context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
         (route) => false,
    );
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>
          isLoggedIn
              ? const BottomNavBaseScreen()
              : const LoginScreen()),
              (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            AssetsUtils.logoSVG,
            width: 100,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}