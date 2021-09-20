import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_hook_riverpod/routes.dart';
import 'package:sample_hook_riverpod/widgets/normal_background.dart';

import 'state_notifier/login/auth_state.dart';
import 'state_notifier/login/auth_state_notifier.dart';
import 'widgets/otp_input_field.dart';

class VerifyOtpPage extends HookConsumerWidget {
  const VerifyOtpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authStateNotifierProvider, (state) {
      state.maybeWhen(
          orElse: () {},
          authenticated: () {
            AppNavigator.replaceWith<String>(NavigationPaths.home);
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
    });
    final codeFieldController = useTextEditingController();
    final authProviderNotifier = ref.watch(authStateNotifierProvider.notifier);
    final authState = ref.watch(authStateNotifierProvider);

    final codeComplete = useState(false);
    return NormalBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              OtpInputField(
                inputController: codeFieldController,
                codeComplete: codeComplete,
              ),
              authState.maybeMap(
                orElse: () {
                  return ElevatedButton(
                    onPressed: () {
                      if (codeComplete.value)
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
      ),
    );
  }
}
