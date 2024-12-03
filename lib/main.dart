import 'package:expenses_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  // ? the below line is used to lock orientation as desired
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((_) => runApp(const MyApp()));
  runApp(const MyApp());
}

var myColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

var myDarkColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      themeMode: ThemeMode.light,
      theme: ThemeData().copyWith(
        colorScheme: myColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myColorScheme.onPrimaryContainer,
            foregroundColor: myColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: myColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(color: myColorScheme.onSecondaryContainer),
            bodyMedium: TextStyle(color: myColorScheme.primary)),
      ),
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: myDarkColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: myDarkColorScheme.onPrimaryContainer,
              foregroundColor: myDarkColorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
            color: myDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: myDarkColorScheme.onPrimaryContainer,
              foregroundColor: myDarkColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge:
                  TextStyle(color: myDarkColorScheme.onSecondaryContainer),
              bodyMedium: TextStyle(color: myDarkColorScheme.primary)),
          bottomSheetTheme: const BottomSheetThemeData().copyWith(
            backgroundColor: myDarkColorScheme.onPrimaryContainer,
          )),
      home: const Expenses(),
    );
  }
}
