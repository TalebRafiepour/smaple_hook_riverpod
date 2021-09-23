import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.initial() = Initial;

  const factory SplashState.loading() = Loading;

  const factory SplashState.appConfigLoaded() = AppConfigLoaded;

  const factory SplashState.error() = Error;
}
