import 'package:go_router/go_router.dart';
import 'package:car_share/features/auth/presentacion/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: '/login',
    name: LoginScreen.name,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    path: '/home',
    name: HomeMapScreen.name,
    builder: (context, state) => HomeMapScreen(),
  ),
]);
