import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../models/user_model.dart';
import 'loading_page.dart';
import 'error_page.dart';
import 'success_page.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoadingPage()),
          );
        } else if (state is UserSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SuccessPage()),
          );
        } else if (state is UserFailure) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ErrorPage(message: state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Registro de Usuario")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(controller: _nombreController, decoration: const InputDecoration(labelText: "Nombre")),
                TextFormField(controller: _apellidoController, decoration: const InputDecoration(labelText: "Apellido")),
                TextFormField(controller: _correoController, decoration: const InputDecoration(labelText: "Correo")),
                TextFormField(controller: _passwordController, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final user = UserModel(
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      correo: _correoController.text,
                      password: _passwordController.text,
                    );
                    context.read<UserBloc>().add(SubmitUser(user));
                  },
                  child: const Text("Enviar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
