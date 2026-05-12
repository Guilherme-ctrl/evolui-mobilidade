import '../../../../core/errors/failure.dart';
import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<(Failure?, AuthSession?)> login({required String username, required String password});
  Future<(Failure?, AuthSession?)> acceptTerms(AuthSession session);
}
