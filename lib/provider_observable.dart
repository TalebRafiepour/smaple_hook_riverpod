import 'package:hooks_riverpod/hooks_riverpod.dart';

class MProviderObservable extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    print("""
    provider: ${provider.toString()},
    newValue: ${newValue.toString()},
    container: ${container.toString()}
    """);
  }
}
