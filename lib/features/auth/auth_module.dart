import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/auth_page.dart';
import 'presentation/auth_cubit.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AuthCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const AuthPage());
  }
}
