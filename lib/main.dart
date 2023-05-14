import 'package:Sprout/components/navigation/customnavbar.dart';
import 'package:Sprout/components/provider.dart';
import 'package:Sprout/screens/shop/shop.dart';
import 'package:Sprout/services/session.dart';
import 'package:Sprout/screens/SearchPalnts.dart';
import 'package:Sprout/screens/homescreen.dart';
import 'package:Sprout/screens/login.dart';
import 'package:Sprout/screens/resetpass.dart';
import 'package:Sprout/screens/searchpage.dart';
import 'package:Sprout/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/lauchscreen.dart';
import '../screens/loading.dart';
import '../screens/account.dart';
import '../screens/community.dart';
import '../screens/schedule.dart';
import '../screens/zengarden.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

int? initScreen = 0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  if (prefs.getString('token') != null) {
    await prefs.setInt("initScreen", 1);
    initScreen = await prefs.getInt("initScreen");
  }
  print('initScreen ${initScreen}');

  runApp(ChangeNotifierProvider(create: (_) => UserProvider(), child: MyApp()));
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
  int _selectedIndex = 0;
  bool isuser = false;

  @override
  void initState() {
    // userdata();
  }

  // void userdata() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   print(sharedPreferences.getString("token"));
  //   if (sharedPreferences.getString("token") != null) {
  //     setState(() {
  //       isuser = true;
  //     });
  //   }
  // }

  List<Widget> _widgetOptions() {
    return [MyHomePage(), PlantSchedule(), ZenGarden(), ComunnityTab(), Shop()];
  }

  List<PersistentBottomNavBarItem> _navItems() {
    return [
      PersistentBottomNavBarItem(
          icon: ImageIcon(AssetImage("assets/images/home.png")),
          title: 'Home',
          activeColorPrimary: Color(0xff17BB0A),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/images/Group.png")),
        title: 'Schedule',
        activeColorPrimary: Color(0xff17BB0A),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/zen.png"),
          ),
          title: 'Zen',
          activeColorPrimary: Color(0xff17BB0A),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: ImageIcon(AssetImage("assets/images/Vector.png")),
          title: 'Community',
          activeColorPrimary: Color(0xff17BB0A),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: ImageIcon(AssetImage("assets/images/shopping-bag.png")),
          title: 'Shop',
          activeColorPrimary: Color(0xff17BB0A),
          inactiveColorPrimary: Colors.black),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  void _onItemTapped(int index) {
    setState(() {
      _controller.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.cok);
    // pushNotifications.init();
    DateTime backPressed = DateTime.now();
    // return WillPopScope(
    // onWillPop: () async {
    // final isExit = diffrence >= Duration(seconds: 2);
    // backPressed = DateTime.now();
    // if (isExit) {
    //   final message = "Press again to exit";
    //   Fluttertoast.showToast(msg: message, fontSize: 18);
    //   return false;
    // } else {
    //   return true;
    // }
    // },
    // child: Scaffold(
    //   body: PageTransitionSwitcher(
    //     transitionBuilder: ((child, primaryAnimation, secondaryAnimation) {
    //       return FadeThroughTransition(
    //         animation: primaryAnimation,
    //         secondaryAnimation: secondaryAnimation,
    //         child: child,
    //       );
    //     }),
    //     child: _widgetOptions[_selectedIndex],
    //   ),
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      print(userProvider.isuser);
      return !userProvider.isuser!
          ? SplashScreen()
          : PersistentTabView.custom(
              context,
              screens: _widgetOptions(),
              itemCount: 5,
              controller: _controller,
              stateManagement: true,
              hideNavigationBarWhenKeyboardShows: true,
              handleAndroidBackButtonPress: true,
              screenTransitionAnimation: ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 500),
              ),

              onWillPop: (context) async {
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
              confineInSafeArea: true,
              customWidget: CustomNavBarWidget(
                  items: _navItems(),
                  selectedIndex: _controller.index,
                  onItemSelected: _onItemTapped),
              // currentIndex: _selectedIndex,
              // selectedItemColor: Color(0xff17BB0A),
              // unselectedItemColor: Colors.black,
              // unselectedLabelStyle: TextStyle(
              //     color: Colors.black,
              //     fontSize: 12,
              //     fontFamily: 'Mada',
              //     fontWeight: FontWeight.w500),
              // onTap: _onItemTapped,

              // ),
            );
    });
  }
}
