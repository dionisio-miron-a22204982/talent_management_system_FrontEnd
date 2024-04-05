import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tfc_versaofinal/features/authentication/screens/Register/signup.dart';
import 'package:tfc_versaofinal/utils/constants/sizes.dart';
import 'package:tfc_versaofinal/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TFCSizes.spaceBtwSections),
        child: Column(
          children: [
            // User
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TFCTexts.username),
            ),
            const SizedBox(height: TFCSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TFCTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: TFCSizes.spaceBtwInputFields),

            // Remember me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TFCTexts.remember),
                  ],
                ),
                // Forget Password
                TextButton(
                  onPressed: (){},
                  child: const Text(TFCTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TFCSizes.spaceBtwSections),

            // Sign In Button
            SizedBox(width: double.infinity ,child: ElevatedButton(onPressed: (){}, child: const Text(TFCTexts.login))),
            const SizedBox(height: TFCSizes.spaceBtwItems),

            // Create a new account
            SizedBox(width: double.infinity ,child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TFCTexts.createAccount))),
            const SizedBox(height: TFCSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}