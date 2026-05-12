import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';

class LoginUsecase {
  final AuthRepository repository;
  const LoginUsecase(this.repository);

  Future<(Failure?, AuthSession?)> call({required String username, required String password}) {
    return repository.login(username: username, password: password);
  }
}
