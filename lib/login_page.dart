import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_hook_riverpod/verify_otp_page.dart';

import 'state_notifier/login/auth_state.dart';
import 'state_notifier/login/auth_state_notifier.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changeListerCallback = useCallback((AuthState state) {
      state.maybeWhen(
        orElse: () {},
        otpSent: (mobileNumber) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => VerifyOtpPage()));
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        },
      );
    }, const []);

    useMemoized(() =>ref.listen<AuthState>(authStateNotifierProvider, changeListerCallback));
    final phoneFieldController = useTextEditingController();

    return Scaffold(
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
              style: Theme.of(context).textTheme.caption,
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
    );
  }
}
