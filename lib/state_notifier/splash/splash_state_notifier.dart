import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_hook_riverpod/state_notifier/splash/splash_state.dart';

final splashStateNotifierProvider =
    StateNotifierProvider.autoDispose<SplashStateNotifier, SplashState>(
        (_) => SplashStateNotifier());

class SplashStateNotifier extends StateNotifier<SplashState> {
  SplashStateNotifier() : super(const SplashState.initial());

  Future<void> loadConfig() async {
    state = const SplashState.loading();
    await Future.delayed(const Duration(milliseconds: 800));
    state = const SplashState.appConfigLoaded();
  }
}
