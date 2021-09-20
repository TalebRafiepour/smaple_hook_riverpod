import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_hook_riverpod/routes.dart';
import 'package:sample_hook_riverpod/widgets/normal_background.dart';

import 'state_notifier/login/auth_state.dart';
import 'state_notifier/login/auth_state_notifier.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authStateNotifierProvider, (state) {
      state.maybeWhen(
          orElse: () {},
          otpSent: (mobileNumber) {
            AppNavigator.replaceWith<String>(
                NavigationPaths.verifyLogin, mobileNumber);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          },);
    });
    final phoneFieldController = useTextEditingController();

    return NormalBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please Enter Your mobile number'),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: phoneFieldController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              ref.watch(authStateNotifierProvider).maybeMap(
                orElse: () {
                  return ElevatedButton(
                    onPressed: () {
                      ref
                          .read(authStateNotifierProvider.notifier)
                          .sendOtp(phoneFieldController.text);
                    },
                    child: const Text('Login'),
                  );
                },
                loading: (_) {
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
