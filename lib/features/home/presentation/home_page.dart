import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../auth/domain/auth_session.dart';
import '../../auth/domain/user_role.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? activeStudent;

  @override
  Widget build(BuildContext context) {
    final session = Modular.args.data as AuthSession?;
    final role = session?.role ?? UserRole.atleta;
    activeStudent ??= (session != null && session.studentIds.isNotEmpty) ? session.studentIds.first : null;

    return Scaffold(
      appBar: AppBar(title: Text('Home ${role.name.toUpperCase()}')),
      body: Column(
        children: [
          if (role == UserRole.atleta)
            DropdownButton<String>(
              value: activeStudent,
              hint: const Text('Aluno ativo (RN-200)'),
              items: (session?.studentIds ?? const <String>[])
                  .map((id) => DropdownMenuItem(value: id, child: Text(id)))
                  .toList(),
              onChanged: (value) => setState(() => activeStudent = value),
            ),
          const Text('Operação rápida para campo (RN-000).'),
        ],
      ),
    );
  }
}
