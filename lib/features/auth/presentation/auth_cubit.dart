import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/auth_session.dart';
import '../domain/user_role.dart';

sealed class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthNeedsTerms extends AuthState { final AuthSession session; AuthNeedsTerms(this.session); }
class AuthAuthenticated extends AuthState { final AuthSession session; AuthAuthenticated(this.session); }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String user, String password) async {
    emit(AuthLoading());
    final session = AuthSession(
      accountUserId: user,
      role: user == 'admin' ? UserRole.admin : UserRole.atleta,
      acceptedTerms: false,
      studentIds: const ['student-1', 'student-2'],
    );
    emit(AuthNeedsTerms(session));
  }

  void acceptTerms(AuthSession session) {
    emit(AuthAuthenticated(AuthSession(
      accountUserId: session.accountUserId,
      role: session.role,
      acceptedTerms: true,
      studentIds: session.studentIds,
    )));
  }
}
