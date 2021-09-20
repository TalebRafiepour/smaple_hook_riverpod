import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;

  const factory AuthState.loading() = Loading;

  const factory AuthState.otpSent({required String mobileNumber}) = OtpSent;

  const factory AuthState.authenticated() = Authenticated;

  const factory AuthState.unAuthenticated() = UnAuthenticated;

  const factory AuthState.error({required String errorMessage}) = Error;
}
