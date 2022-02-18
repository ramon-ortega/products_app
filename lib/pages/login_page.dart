import 'package:flutter/material.dart';
import 'package:products_app/pages/pages.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  static String routerName = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 230),

              CardContainer(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('Login', style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 20),

                      ChangeNotifierProvider(
                        create: ( _ ) => LoginFormProvider(),
                        child: const _LoginForm(),
                      )

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text('Crear una nueva cuenta', style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 30),
            ],
          ),
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: loginFormProvider.formKey,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'john.mae@gmail.com', 
              labelText: 'Correo electrónico',
              icon: Icons.alternate_email_outlined
            ),
            onChanged: (value) => loginFormProvider.mail = value,
            validator: (value){

              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '') 
                ? null
                : 'Ingrese un correo valido';
            },
          ),

          const SizedBox(height: 30),

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
              hintText: '******', 
              labelText: 'Contraseña',
              icon: Icons.lock_outline
            ),
            onChanged: (value) => loginFormProvider.password = value,
            validator: (value) {
              return value != null && value.length >= 6
                ? null
                : 'La contraseña no tiene mas de 6 caracteres';
            },
          ),

          const SizedBox(height: 30),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            elevation: 0,
            child: Text(
              loginFormProvider.isLoading 
              ? 'Espere'
              : 'Ingresar',
              style: const TextStyle(color: Colors.white)
            ),
            disabledColor: Colors.grey,
            color: Colors.deepPurple,
            onPressed: loginFormProvider.isLoading 
              ? null : () async {

              FocusScope.of(context).unfocus();

              loginFormProvider.isLoading = true;

              await Future.delayed(const Duration(seconds: 2));

              loginFormProvider.isLoading = false;

              loginFormProvider.isValidForm()
                ? Navigator.pushReplacementNamed(context, HomePage.routerName)
                : null;
            }
          )
        ],
      )
    );
  }
}