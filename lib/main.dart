import 'dart:math';

import 'package:aula_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aula sobre bloc'),
      ),
      body: SizedBox.expand(
        child: BlocProvider(
          create: (context) => UserBloc(),
          child: BlocBuilder<UserBloc, UserState>(
            builder: ((context, state) {
              if (state is UserInitial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Usuário não logado'),
                    SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () => context
                            .read<UserBloc>()
                            .add(UserLogin('1', 'Daves')),
                        child: Text('Fazer login'))
                  ],
                );
              }

              if (state is UserLoogedIn) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'User ID: ${state.userId}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('User name: ${state.userName}',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: (){
                            var rng = Random();
                            context.read<UserBloc>().add(
                              UserLogin(rng.nextInt(100).toString(), 'Natanael')
                            );
                          },
                          child: Text(
                            'Alterar usuário',
                          ))
                    ]);
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }
}
