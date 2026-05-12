import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/auth_local_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/accept_terms_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/auth_cubit.dart';
import 'presentation/auth_page.dart';
import 'presentation/auth_page.dart';
import 'presentation/auth_cubit.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(AuthLocalDatasource.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton(LoginUsecase.new);
    i.addLazySingleton(AcceptTermsUsecase.new);
    i.addLazySingleton(AuthCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const AuthPage());
  }
}
