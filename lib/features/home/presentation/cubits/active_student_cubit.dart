import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveStudentCubit extends Cubit<String?> {
  ActiveStudentCubit() : super(null);

  void init(List<String> studentIds) {
    if (state != null) return;
    emit(studentIds.isNotEmpty ? studentIds.first : null);
  }

  void switchStudent(String? studentId) => emit(studentId);
}
