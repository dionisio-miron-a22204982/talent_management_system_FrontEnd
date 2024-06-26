import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tfc_versaofinal/utils/theme/theme.dart';

import 'features/authentication/screens/OnBoarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // home: NormalUserInfoTest(),
      home: const OnBoardingScreen(),
    );
  }
}
