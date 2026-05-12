export 'entities/auth_session.dart';
import 'user_role.dart';

class AuthSession {
  final String accountUserId;
  final UserRole role;
  final bool acceptedTerms;
  final List<String> studentIds;

  const AuthSession({
    required this.accountUserId,
    required this.role,
    required this.acceptedTerms,
    required this.studentIds,
  });
}
