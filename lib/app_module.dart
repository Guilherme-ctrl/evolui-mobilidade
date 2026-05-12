import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/network/http_client.dart';
import 'features/auth/auth_module.dart';
import 'features/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(HttpClient.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.child('/', child: (_) => const RedirectToAuth());
  }
}

class RedirectToAuth extends StatelessWidget {
  const RedirectToAuth({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => Modular.to.navigate('/auth/'));
    return const SizedBox.shrink();
  }
}
