import 'package:archive/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:archive/core/router.dart';
import 'package:archive/core/theme/app_theme.dart';
import 'package:archive/features/auth/data/datasources/auth_data_provider.dart';
import 'package:archive/features/auth/data/repositories/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final myAuthProvider = FirebaseAuthProvider();
  final authRepository = AuthRepository(authProvider: myAuthProvider);

  runApp(
    MultiRepositoryProvider(
      providers: [
        // Make the repository available to the whole app
        RepositoryProvider.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            // Pass the repository into the Cubit here!
            create: (context) =>
                AuthCubit(repository: context.read<AuthRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
