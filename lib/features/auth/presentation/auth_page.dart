import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth_cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Modular.to.navigate('/home/', arguments: state.session);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: Center(
              child: state is AuthNeedsTerms
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Aceite os termos para continuar (RN-201).'),
                        ElevatedButton(
                          onPressed: () => context.read<AuthCubit>().acceptTerms(state.session),
                          child: const Text('Aceitar termos'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () => context.read<AuthCubit>().login('atleta', '123'),
                      child: const Text('Entrar'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
