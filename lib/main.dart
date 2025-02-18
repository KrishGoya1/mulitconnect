import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/volunteer_dashboard.dart';
import '/screens/party_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      redirect: (context, state) async {
        final user = ref.watch(authStateProvider).value;
        final isAdmin = await ref.read(authServiceProvider).isAdmin(user?.uid ?? '');
        
        if (user == null) return '/login';
        return isAdmin ? '/admin' : '/volunteer';
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminDashboard(),
          routes: [
            GoRoute(
              path: 'party/:partyCode',
              builder: (context, state) => PartyScreen(
                partyCode: state.pathParameters['partyCode']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/volunteer',
          builder: (context, state) => const VolunteerDashboard(),
          routes: [
            GoRoute(
              path: 'party/:partyCode',
              builder: (context, state) => PartyScreen(
                partyCode: state.pathParameters['partyCode']!,
              ),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(error: state.error),
    );

    return MaterialApp.router(
      title: 'Multiparty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text(error?.toString() ?? 'Page not found'),
      ),
    );
  }
}
