import 'package:flutter/material.dart';
import 'package:car_share/config/config.dart';
import 'package:car_share/features/auth/presentacion/providers/login_form_provider.dart';
import 'features/auth/presentacion/states/app_state.dart';
import 'package:provider/provider.dart';

// import 'config/config.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: AppState(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
        )
      ],
      child: MaterialApp.router(
        title: 'Car Share',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
