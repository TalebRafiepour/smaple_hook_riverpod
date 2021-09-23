import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_hook_riverpod/home_page.dart';

import 'state_notifier/login/auth_state.dart';
import 'state_notifier/login/auth_state_notifier.dart';

class VerifyOtpPage extends HookConsumerWidget {
  const VerifyOtpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changeListenerCallback = useCallback((AuthState state) {
      state.maybeWhen(
          orElse: () {},
          authenticated: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
          },
          unAuthenticated: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('verificationCodeIsInvalid'),
              ),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          });
    }, const []);

    useMemoized(() => ref.listen<AuthState>(
        authStateNotifierProvider, changeListenerCallback));
    final codeFieldController = useTextEditingController();
    final authProviderNotifier = ref.watch(authStateNotifierProvider.notifier);
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please Enter Your verification code'),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: codeFieldController,
            ),
            authState.maybeMap(
              orElse: () {
                return ElevatedButton(
                  onPressed: () {
                    authProviderNotifier.verifyOtp(
                        '09377729207', codeFieldController.text);
                  },
                  child: const Text('Verify'),
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
