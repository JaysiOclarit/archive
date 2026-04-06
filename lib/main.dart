import 'package:archive/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:archive/init_dependencies.dart';
import 'package:archive/core/router/router.dart';
import 'package:archive/core/theme/app_theme.dart';
import 'package:archive/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await initDependencies();

  runApp(
    MultiRepositoryProvider(
      providers: [
        // Make the repository available to the whole app as the domain interface
        RepositoryProvider<AuthRepository>.value(
          value: getIt<AuthRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
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
