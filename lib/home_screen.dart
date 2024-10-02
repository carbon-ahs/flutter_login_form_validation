import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_from_validation/bloc/auth_bloc.dart';
import 'package:login_from_validation/login_screen.dart';
import 'package:login_from_validation/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (_) => false,
            );
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading || state is AuthInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              children: [
                Text((state as AuthSuccess).uid),
                const SizedBox(height: 16),
                GradientButton(
                    btnText: 'Log out',
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
