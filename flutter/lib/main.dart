import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'screens/home.dart';
import 'screens/favorites.dart';
import 'package:provider/provider.dart';
import 'models/favorites.dart';
import 'screens/newItem.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const TestingApp());

class TestingApp extends StatelessWidget {
  const TestingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('he', 'IL'), // Hebrew          
        ],
        title: 'Testing Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          FavoritesPage.routeName: (context) => const FavoritesPage(),
          NewItemPage.routeName: (context) => const NewItemPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
