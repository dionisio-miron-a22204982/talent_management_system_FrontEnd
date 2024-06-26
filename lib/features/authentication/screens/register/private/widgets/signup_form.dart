import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../../../../../common/widgets/login/conditions_checkbox.dart';
import '../../../../../../repository/normal_user_repository.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../sucess/sucess_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late NormalUserRepository normalUserRepository;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _jobController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    normalUserRepository = context.read<NormalUserRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // First and Last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: TFCTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor introduza o seu primeiro nome.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: TFCSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: TFCTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor introduza o seu último nome.';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Username
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: TFCTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor introduza o seu nome de usuário.';
              }
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: TFCTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor introduza a sua senha.';
              }
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: TFCTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor introduza o seu email.';
              }
              // Add email validation logic here if needed
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: TFCTexts.mobilePhone,
              prefixIcon: Icon(Iconsax.call),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor introduza o seu número de telefone.';
              }
              // Add phone number validation logic here if needed
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Job
          TextFormField(
            controller: _jobController,
            decoration: const InputDecoration(
              labelText: TFCTexts.job,
              prefixIcon: Icon(Icons.work),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor introduza a sua profissão.';
              }
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Age
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
              labelText:  TFCTexts.age,
              prefixIcon: Icon(Icons.calendar_today),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor introduza a sua idade.';
              }
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwInputFields),

          // Gender
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: TFCTexts.gender,
              prefixIcon: Icon(Icons.person),
            ),
            items: ['Masculino', 'Feminino', 'Outro']
                .map((gender) => DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor selecione o seu gênero.';
              }
              return null;
            },
          ),
          const SizedBox(height: TFCSizes.spaceBtwSections),

          // Terms agree checkbox
          const ConditionsCheckbox(),
          const SizedBox(height: TFCSizes.spaceBtwSections),

          // SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final result = await normalUserRepository.createNewUser(
                      email: _emailController.text,
                      name: '${_firstNameController.text} ${_lastNameController.text}',
                      username: _usernameController.text,
                      gender: _selectedGender!,
                      job: _jobController.text,
                      phoneNumber: _phoneNumberController.text,
                      age: int.parse(_ageController.text),
                      password: _passwordController.text,
                    );

                    Get.to(() => const SucessScreen());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                }
              },
              child: const Text(TFCTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
