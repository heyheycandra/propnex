import 'package:flutter/material.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/helper/route_generator.dart';
import 'package:technical_take_home/ui/home/home_screen.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Constant(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test app',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      navigatorKey: locator<NavigatorService>().navigatorKey,
      home: const HomeScreen(),
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    );
  }
}
