import 'package:flutter/material.dart';


class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Widget> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
    ];
    // _pages = [
    //   {
    //     'page': Home(),
    //   },
    //   {
    //     'page': Feeds(),
    //   },
    //   {
    //     'page': Search(),
    //   },
    //   {
    //     'page': CartScreen(),
    //   },
    //   {
    //     'page': UserInfo(),
    //   },
    // ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPageIndex,
              // selectedLabelStyle: TextStyle(fontSize: 16),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  // title: Text('Home'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dns), label: 'Feeds'),
                BottomNavigationBarItem(
                    activeIcon: null, icon: Icon(null), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_shopping_cart_sharp ,
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined ), label: 'User'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(Icons.search),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}