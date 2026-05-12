import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../domain/entities/auth_session.dart';
import '../domain/usecases/accept_terms_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/auth_session.dart';
import '../domain/user_role.dart';

sealed class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthError extends AuthState { final Failure failure; AuthError(this.failure); }
class AuthNeedsTerms extends AuthState { final AuthSession session; AuthNeedsTerms(this.session); }
class AuthAuthenticated extends AuthState { final AuthSession session; AuthAuthenticated(this.session); }

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final AcceptTermsUsecase acceptTermsUsecase;

  AuthCubit({required this.loginUsecase, required this.acceptTermsUsecase}) : super(AuthInitial());

  Future<void> login(String user, String password) async {
    emit(AuthLoading());
    final result = await loginUsecase(username: user, password: password);
    final failure = result.$1;
    final session = result.$2;
    if (failure != null) return emit(AuthError(failure));
    if (session == null) return emit(AuthError(const AuthFailure('Sessão inválida')));
    if (!session.acceptedTerms) {
      return emit(AuthNeedsTerms(session));
    }
    emit(AuthAuthenticated(session));
  }

  Future<void> acceptTerms(AuthSession session) async {
    final result = await acceptTermsUsecase(session);
    final failure = result.$1;
    final updated = result.$2;
    if (failure != null) return emit(AuthError(failure));
    if (updated == null) return emit(AuthError(const AuthFailure('Falha ao aceitar termos')));
    emit(AuthAuthenticated(updated));
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
