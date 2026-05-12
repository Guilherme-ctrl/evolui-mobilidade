import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/user_role.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource datasource;

  const AuthRepositoryImpl(this.datasource);

  @override
  Future<(Failure?, AuthSession?)> login({required String username, required String password}) async {
    if (password.isEmpty) {
      return (const AuthFailure('Credenciais inválidas'), null);
    }
    final session = AuthSession(
      accountUserId: username,
      role: username == 'admin' ? UserRole.admin : (username == 'treinador' ? UserRole.treinador : UserRole.atleta),
      acceptedTerms: false,
      studentIds: username == 'atleta' ? const ['student-1', 'student-2'] : const [],
    );
    await datasource.saveSession(session);
    return (null, session);
  }

  @override
  Future<(Failure?, AuthSession?)> acceptTerms(AuthSession session) async {
    final updated = session.copyWith(acceptedTerms: true);
    await datasource.saveSession(updated);
    return (null, updated);
  }
}
