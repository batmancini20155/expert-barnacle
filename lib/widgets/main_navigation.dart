import 'package:flutter/material.dart';
import '../pages/movies_page.dart';
import '../pages/saved_page.dart';
import '../pages/tickets_page.dart';
import '../pages/settings_page.dart';
import '../pages/guide_page.dart';
import 'app_header.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();

  static _MainNavigationState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MainNavigationState>();
  }
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  void switchToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const MoviesPage(),
    const SavedPage(),
    const TicketsPage(),
    const GuidePage(),
    const SettingsPage(),
  ];

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Popular Movies';
      case 1:
        return 'Saved';
      case 2:
        return 'Tickets';
      case 3:
        return 'Guide';
      case 4:
        return 'Settings';
      default:
        return 'Movie App';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: _getPageTitle(_currentIndex),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Guide',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}