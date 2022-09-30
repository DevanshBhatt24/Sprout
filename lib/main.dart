import 'package:Sprout/screens/plantdescription.dart';
import 'package:Sprout/services/session.dart';
import 'package:Sprout/pushnotification.dart';
import 'package:Sprout/screens/SearchPalnts.dart';
import 'package:Sprout/screens/homescreen.dart';
import 'package:Sprout/screens/login.dart';
import 'package:Sprout/screens/resetpass.dart';
import 'package:Sprout/screens/searchpage.dart';
import 'package:Sprout/screens/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/lauchscreen.dart';
import '../screens/loading.dart';
import '../screens/account.dart';
import '../screens/community.dart';
import '../screens/schedule.dart';
import '../screens/zengarden.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/searchbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

int? initScreen = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('token') != null) {
    await prefs.setInt("initScreen", 1);
    initScreen = await prefs.getInt("initScreen");
  }
  print('initScreen ${initScreen}');

  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Cookie())],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? initialroute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/launch': (context) => LaunchScreen(),
        '/mainpage': (context) => MainPage(),
        '/homepage': (context) => MyHomePage(),
        '/login': (context) => LogIn(),
        '/register': (context) => SignUp(),
        '/zengarden': (context) => ZenGarden(),
        '/plantschedule': (context) => PlantSchedule(),
        '/community': (context) => ComunnityTab(),
        '/profile': (context) => Accountdetails(),
        '/search': (context) => Searchpage(),
        '/serachplant': (context) => SearchPlant(),
        '/resetpass': (context) => Resetpass(),
      },
      // theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      initialRoute: initScreen == 0 || initScreen == null ? "/" : "/mainpage",
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PushNotificationsManager pushNotifications = PushNotificationsManager();
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  User? loggedin;
  void initState() {
    // userdata();
  }

  // void userdata() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   print(sharedPreferences.getString("token"));
  //   if (sharedPreferences.getString("token") == null) {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => LaunchScreen()),
  //     );
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => MainPage()),
  //     );
  //   }
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    PlantSchedule(),
    ZenGarden(),
    ComunnityTab(),
    Accountdetails()
  ];

  @override
  Widget build(BuildContext context) {
    // print(widget.cok);
    // pushNotifications.init();
    DateTime backPressed = DateTime.now();
    return WillPopScope(
        onWillPop: () async {
          final diffrence = DateTime.now().difference(backPressed);
          final isExit = diffrence >= Duration(seconds: 2);
          backPressed = DateTime.now();
          if (isExit) {
            final message = "Press again to exit";
            Fluttertoast.showToast(msg: message, fontSize: 18);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: _widgetOptions[_selectedIndex],

          bottomNavigationBar: SizedBox(
            height: 60,
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/home.png")),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/Group.png")),
                  label: 'Schedule',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/zen.png"),
                  ),
                  label: 'Zen',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/Vector.png")),
                  label: 'Community',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    size: 26,
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xff17BB0A),
              unselectedItemColor: Colors.black,
              unselectedLabelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Mada',
                  fontWeight: FontWeight.w500),
              onTap: _onItemTapped,
            ),
          ),
          // ),
        ));
  }
}
