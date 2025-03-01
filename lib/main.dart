import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_pulse/constants/constants.dart';
import 'package:price_pulse/constants/theme.dart';
import 'package:price_pulse/login/login_page.dart';
import 'package:price_pulse/pages/product_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart'; // new
import 'app_state.dart'; // new

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      color: Colors.white,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

final _router = GoRouter(routes: [
  GoRoute(
      path: RoutePathGo.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: RoutePathGo.product,
          builder: (context, state) =>
              ProductPage(query: state.pathParameters['query']!),
        ),
      ]),
  GoRoute(
    path: RoutePathGo.login,
    builder: (context, state) => const LoginPage(),
  ),
]);


// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomePage(),
//       routes: [
//         GoRoute(
//           path: 'sign-in',
//           builder: (context, state) {
//             return SignInScreen(
//               actions: [
//                 ForgotPasswordAction(((context, email) {
//                   final uri = Uri(
//                     path: '/sign-in/forgot-password',
//                     queryParameters: <String, String?>{
//                       'email': email,
//                     },
//                   );
//                   context.push(uri.toString());
//                 })),
//                 AuthStateChangeAction(((context, state) {
//                   final user = switch (state) {
//                     SignedIn state => state.user,
//                     UserCreated state => state.credential.user,
//                     _ => null
//                   };
//                   if (user == null) {
//                     return;
//                   }
//                   if (state is UserCreated) {
//                     user.updateDisplayName(user.email!.split('@')[0]);
//                   }
//                   if (!user.emailVerified) {
//                     user.sendEmailVerification();
//                     const snackBar = SnackBar(
//                         content: Text(
//                             'Please check your email to verify your email address'));
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   }
//                   context.pushReplacement('/');
//                 })),
//               ],
//             );
//           },
//           routes: [
//             GoRoute(
//               path: 'forgot-password',
//               builder: (context, state) {
//                 final arguments = state.uri.queryParameters;
//                 return ForgotPasswordScreen(
//                   email: arguments['email'],
//                   headerMaxExtent: 200,
//                 );
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: 'profile',
//           builder: (context, state) {
//             return ProfileScreen(
//               providers: const [],
//               actions: [
//                 SignedOutAction((context) {
//                   context.pushReplacement('/');
//                 }),
//               ],
//             );
//           },
//         ),
//       ],
//     ),
//   ],
// );
