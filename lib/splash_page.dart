import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_hook_riverpod/login_page.dart';
import 'package:sample_hook_riverpod/state_notifier/splash/splash_state.dart';
import 'package:sample_hook_riverpod/state_notifier/splash/splash_state_notifier.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listenerCallback = useCallback((SplashState state) {
      state.maybeWhen(
          orElse: () {},
          appConfigLoaded: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginPage()));
          });
    }, const []);
    useMemoized(
        () => ref.listen(splashStateNotifierProvider, listenerCallback));

    useEffect(() {
      Future.microtask(() => ref.watch(splashStateNotifierProvider.notifier).loadConfig());
    }, const []);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Splash Page',
              style: TextStyle(fontSize: 30),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
