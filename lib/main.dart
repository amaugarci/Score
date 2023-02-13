import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:test/provider/setting_provider.dart';
import 'package:test/routes.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [ChangeNotifierProvider<SettingProvider>.value(value: SettingProvider()),],child: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey,
        focusColor: Colors.blue,
        unselectedWidgetColor: Colors.grey,
        disabledColor: Colors.blue,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      title: "Test",
      debugShowCheckedModeBanner: false,
      initialRoute: '/index',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
