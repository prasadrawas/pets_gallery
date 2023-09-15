import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/common/utils/validator.dart';
import 'package:pets_app/constants/asset_constants.dart';
import 'package:pets_app/constants/color_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/screens/auth/signup/signup_screen.dart';
import 'package:pets_app/presentation/widgets/buttons/primary_button.dart';
import 'package:pets_app/presentation/widgets/form_field/primary_form_field.dart';
import 'package:pets_app/styles/text_styles.dart';

import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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

  Widget _buildFormWidget(LoginController _, bool isSmallScreen) {
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
                      AssetConstants.imgLogin,
                      height: isSmallScreen ? 200 : 300,
                    ),
                  ),
                  Text(
                    StringConstants.welcomeBack,
                    style: AppTextStyles.bold(fontSize: 36),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      StringConstants.pleaseSignInToContinue,
                      style: AppTextStyles.medium(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 30),
                  PrimaryFormField(
                    controller: _.emailController,
                    hint: StringConstants.emailAddress,
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 16,
                    ),
                    validatorFunction: Validator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  PrimaryFormField(
                    controller: _.passwordController,
                    hint: StringConstants.password,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 16,
                    ),
                    validatorFunction: Validator.validateNormalPassword,
                    isPassword: true,
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    onPressed: () => _onSubmit(_),
                    text: StringConstants.login,
                    borderRadius: 40,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // isLoading: _.isLoading,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: StringConstants.dontHaveAnAcc,
                        style: AppTextStyles.regular(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: StringConstants.register,
                            style: AppTextStyles.regular(
                                color: ColorConstants.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onRegisterPress,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(LoginController _) {
    Utils.hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      _.login();
    }
  }

  void _onRegisterPress() {
    Utils.hideKeyboard(context);
    Get.offAll(
      () => const SignupScreen(),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 350),
    );
  }
}
