import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_state.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.initial());

  Future<void> sendOtp(String mobileNumber) async {
    try {
      state = const AuthState.loading();
      await Future.delayed(Duration(milliseconds: 800));
      state = AuthState.otpSent(mobileNumber: mobileNumber);
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  Future<void> verifyOtp(String mobileNumber, String code) async {
    try {
      state = const AuthState.loading();
      await Future.delayed(Duration(milliseconds: 800));
      state = const AuthState.authenticated();
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  void _handleError(Object e, StackTrace s) {
    print('error : $e stack: $s');
    state = AuthState.error(errorMessage: e.toString());
  }
}
