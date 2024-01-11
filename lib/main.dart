import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bricopartagefront/ListMap.dart';
import 'package:bricopartagefront/map_screen.dart';
import 'package:bricopartagefront/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Notch Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const ListObjet(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Colors.black87,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.list,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.list,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.map,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.map,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 3',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
