import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/common/utils/validator.dart';
import 'package:pets_app/constants/asset_constants.dart';
import 'package:pets_app/constants/color_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/screens/auth/login/login_screen.dart';
import 'package:pets_app/presentation/widgets/buttons/primary_button.dart';
import 'package:pets_app/presentation/widgets/form_field/primary_form_field.dart';
import 'package:pets_app/styles/text_styles.dart';

import 'signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => Utils.onBackPressed(),
          child: Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isSmallScreen = constraints.maxWidth < 600;
                  return _buildFormWidget(_, isSmallScreen);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormWidget(SignupController _, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isSmallScreen ? double.infinity : 450,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      AssetConstants.imgSignup,
                      height: isSmallScreen ? 200 : 300,
                    ),
                  ),
                  Text(
                    StringConstants.createNewAcc,
                    style: AppTextStyles.bold(fontSize: 36),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      StringConstants.pleaseFillDetails,
                      style: AppTextStyles.medium(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 30),
                  PrimaryFormField(
                    hint: StringConstants.fullName,
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 16,
                    ),
                    validatorFunction: Validator.validateFullName,
                    controller: _.nameController,
                  ),
                  PrimaryFormField(
                    hint: StringConstants.emailAddress,
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 16,
                    ),
                    validatorFunction: Validator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    controller: _.emailController,
                  ),
                  PrimaryFormField(
                    hint: StringConstants.phoneNumber,
                    prefixIcon: const Icon(
                      Icons.phone,
                      size: 16,
                    ),
                    validatorFunction: Validator.validatePhone,
                    keyboardType: TextInputType.phone,
                    controller: _.phoneController,
                    maxLength: 10,
                  ),
                  PrimaryFormField(
                    hint: StringConstants.password,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 16,
                    ),
                    validatorFunction: Validator.validateStrongPassword,
                    isPassword: true,
                    controller: _.passwordController,
                  ),
                  PrimaryFormField(
                    hint: StringConstants.confirmPassword,
                    controller: _.confirmPasswordController,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 16,
                    ),
                    validatorFunction: (value) {
                      if (value != _.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    onPressed: () => onSubmit(_),
                    text: StringConstants.createAccount,
                    borderRadius: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // isLoading: _.isLoading,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: StringConstants.haveAnAccount,
                        style: AppTextStyles.regular(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: StringConstants.login,
                            style: AppTextStyles.regular(
                                color: ColorConstants.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onLoginPress,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(SignupController _) {
    Utils.hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      _.signUp();
    }
  }

  void _onLoginPress() {
    Utils.hideKeyboard(context);
    Get.offAll(
      () => const LoginScreen(),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 350),
    );
  }
}
