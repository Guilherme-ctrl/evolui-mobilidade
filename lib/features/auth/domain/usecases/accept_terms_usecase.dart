import '../../../../core/errors/failure.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class AcceptTermsUsecase {
  final AuthRepository repository;
  const AcceptTermsUsecase(this.repository);

  Future<(Failure?, AuthSession?)> call(AuthSession session) {
    return repository.acceptTerms(session);
  }
}
