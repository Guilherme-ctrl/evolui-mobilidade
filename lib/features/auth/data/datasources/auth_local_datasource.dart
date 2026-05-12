import '../../domain/entities/auth_session.dart';

class AuthLocalDatasource {
  AuthSession? _session;

  Future<void> saveSession(AuthSession session) async {
    _session = session;
  }

  Future<AuthSession?> getSession() async => _session;
}
