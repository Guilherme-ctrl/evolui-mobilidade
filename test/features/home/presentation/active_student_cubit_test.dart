import 'package:bloc_test/bloc_test.dart';
import 'package:evolui_mobilidade/features/home/presentation/cubits/active_student_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<ActiveStudentCubit, String?>(
    'inicia com primeiro aluno e permite troca',
    build: ActiveStudentCubit.new,
    act: (cubit) {
      cubit.init(['s1', 's2']);
      cubit.switchStudent('s2');
    },
    expect: () => ['s1', 's2'],
  );

  test('init vazio mantém null', () {
    final cubit = ActiveStudentCubit();
    cubit.init([]);
    expect(cubit.state, isNull);
  });
}
