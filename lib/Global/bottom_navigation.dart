import 'package:flutter/material.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/Pages/homePage/search_page.dart';
import 'package:sr_health_care/Pages/myfeed/myfeed_main.dart';
import 'package:sr_health_care/Pages/profilePage/setting.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/trash/unique_home_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  // List of pages
   late final List<Widget> _pages ;

  final List<String> _titles = ["Home", "Search", "My Feed", "Profile"];
  final List<String> _iconPaths = [
    "assets/bottomnav/home.png",
    "assets/bottomnav/search.png",
    "assets/bottomnav/feed.png",
  ];

  @override
  void initState() {
    
    super.initState();
   _pages= [ 
    // const MainHomePage(),
    UniqueHomePage(),
    const SearchPage(),
    MyFeedPage(
      userID: SharedPreferenceHelper().getUserData()?.id.toString() ??'',
    ),
     SettingPage(
      onUpdate: () {
        setState(() {});
      },
     )
  ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildProfileIcon() {
    return SharedPreferenceHelper().getUserData()?.photo?.url?.isNotEmpty ==
            true
        ? AppCacheNetworkImage(
            borderRadius: 12,
            height: 25,
            width: 25,
            imageUrl: (SharedPreferenceHelper().getUserData()?.photo!.url),
          )
        : Icon(Icons.person,
            size: 28, color: _selectedIndex == 3 ? Colors.blue : Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: buttonColor,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            elevation: 0,
            iconSize: 24,
            items: [
              for (int i = 0; i < _titles.length; i++)
                BottomNavigationBarItem(
                  icon: i == 3
                      ? Column(
                          children: [
                            if (_selectedIndex == i)
                              Container(
                                // margin: EdgeInsets.only(top: 4),
                                height: 3,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xff402CD8),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                              ),
                               const SizedBox(
                              height: 10,
                            ),
                            _buildProfileIcon(),
                           
                          ],
                        )
                      : Column(
                          children: [
                            if (_selectedIndex == i)
                              Container(
                                // margin: EdgeInsets.only(top: 4),
                                height: 3,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xff402CD8),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              _iconPaths[i],
                              width: 24,
                              height: 24,
                              color: _selectedIndex == i
                                  ? const Color(0xff402CD8)
                                  : Colors.grey,
                            ),
                          ],
                        ),
                  label: _titles[i],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
