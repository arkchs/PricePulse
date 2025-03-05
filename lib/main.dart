import 'package:flutter/material.dart';
import 'package:price_pulse/constants/constants.dart';
import 'package:price_pulse/constants/theme.dart';
import 'package:price_pulse/pages/favorites_page.dart';
import 'package:price_pulse/pages/login_page.dart';
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
      name: RoutesData.home.routeName,
      path: RoutesData.home.routePath,
      builder: (context, state) => const HomePage(),
      routes: []),
  GoRoute(
    name: RoutesData.product.routeName,
    path: RoutesData.product.routePath,
    builder: (context, state) =>
        ProductPage(query: state.pathParameters['query']!),
  ),
  GoRoute(
    name: RoutesData.login.routeName,
    path: RoutesData.login.routePath,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    name: RoutesData.favorites.routeName,
    path: RoutesData.favorites.routePath,
    builder: (context, state) {
      //TODO: Make an api call to get the user id and the list of favorites of this user.
      return FavoritesPage(
          userId: state.pathParameters['userId']!,
          userFavoritesList: const [
            'abc123',
            'def456',
            'ghi789',
            'jkl012',
            'mno345',
            'pqr678',
            'stu901',
            'vwx234',
            'yza567',
            'bcd890',
          ]);
      // if ((state.pathParameters['token'] != null) &&
      //     state.pathParameters['token'] == 'yayboi') {
      //   //TODO: Make an api call to get the user id and the list of favorites of this user.
      //   String userId = 'Akshat123';
      //   return FavoritesPage(
      //     userId: userId,
      //     userFavoritesList: const [],
      //   );
      // } else {
      //   return const LoginPage();
      // }
    },
    // routes: [
    //   GoRoute(
    //     name: RoutesData.product.routeName,
    //     path: RoutesData.product.routePath,
    //     builder: (context, state) =>
    //         ProductPage(query: state.pathParameters['query']!),
    //   ),
    // ],
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
