import 'package:bloc_test/bloc_test.dart';
import 'package:evolui_mobilidade/core/errors/failure.dart';
import 'package:evolui_mobilidade/features/auth/domain/entities/auth_session.dart';
import 'package:evolui_mobilidade/features/auth/domain/repositories/auth_repository.dart';
import 'package:evolui_mobilidade/features/auth/domain/usecases/login_usecase.dart';
import 'package:evolui_mobilidade/features/auth/domain/user_role.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _AuthRepoMock extends Mock implements AuthRepository {}

void main() {
  late _AuthRepoMock repository;
  late LoginUsecase usecase;

  setUp(() {
    repository = _AuthRepoMock();
    usecase = LoginUsecase(repository);
  });

  test('retorna sessão quando login é sucesso', () async {
    const session = AuthSession(accountUserId: 'a', role: UserRole.atleta, acceptedTerms: false, studentIds: ['s1']);
    when(() => repository.login(username: 'a', password: '123')).thenAnswer((_) async => (null, session));
    final result = await usecase(username: 'a', password: '123');
    expect(result.$2, session);
  });

  test('retorna failure quando login falha', () async {
    when(() => repository.login(username: 'a', password: 'x')).thenAnswer((_) async => (const AuthFailure('erro'), null));
    final result = await usecase(username: 'a', password: 'x');
    expect(result.$1, isA<AuthFailure>());
  });
}
