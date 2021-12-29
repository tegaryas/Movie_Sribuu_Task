import 'package:flutter/material.dart';
import 'package:movie_sribuu_task/model/app_tab.dart';
import 'package:movie_sribuu_task/ui/movie_favorite_page.dart';
import 'package:movie_sribuu_task/ui/movie_page.dart';

class MovieNavigation extends StatefulWidget {
  const MovieNavigation({Key? key}) : super(key: key);

  @override
  State<MovieNavigation> createState() => _MovieNavigationState();
}

class _MovieNavigationState extends State<MovieNavigation> {
  PageController? pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  final List<Widget> _pages = [
    const MoviePage(),
    const MovieFavoritePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: _navbar(pageController),
    );
  }

  Widget _navbar(PageController? pageController) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedIconTheme: const IconThemeData(
        color: Colors.red,
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      unselectedItemColor: Colors.white,
      currentIndex: _currentPage,
      onTap: (index) {
        _onItemTapped(index);
        pageController!.jumpToPage(_currentPage);
      },
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.home ? Icons.home : Icons.favorite,
          ),
          label: tab == AppTab.home ? "Home" : "Favorite",
        );
      }).toList(),
    );
  }
}
