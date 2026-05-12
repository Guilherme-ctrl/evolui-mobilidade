import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/cubits/active_student_cubit.dart';
import 'presentation/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(ActiveStudentCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
  }
}
