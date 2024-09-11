import 'package:cart_geek/app/constants/colors.dart';
import 'package:cart_geek/app/constants/strings.dart';
import 'package:cart_geek/app/provider/home_provider.dart';
import 'package:cart_geek/app/screens/home_tab.dart';
import 'package:cart_geek/app/screens/widget/common_drawer.dart';
import 'package:cart_geek/app/widgets/custom_drawer/value.dart';
import 'package:cart_geek/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider _homeProvider;

  List<Widget> bottomItems = [
    const HomeTab(),
    const Center(child: Text("Coming Soon")),
    const Center(child: Text("Coming Soon")),
    const Center(child: Text("Coming Soon")),
  ];

  @override
  void initState() {
    _homeProvider = HomeProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _homeProvider,
        child: Consumer<HomeProvider>(
            builder: (context, value, child) => CustomDrawer(
                controller: value.advancedDrawerController,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar:
                        AppBar(surfaceTintColor: Colors.transparent, backgroundColor: Colors.white, actions: [
                      IconButton(
                          onPressed: () => value.advancedDrawerController.showDrawer(),
                          icon: ValueListenableBuilder<AdvancedDrawerValue>(
                              valueListenable: value.advancedDrawerController,
                              builder: (_, value, __) {
                                return SvgPicture.asset(Assets.assets_svgs_drawer_icon_svg);
                              })),
                      const SizedBox(width: 20)
                    ]),
                    body: bottomItems[value.selectedIndex],
                    bottomNavigationBar: BottomNavigationBar(
                        elevation: 10,
                        type: BottomNavigationBarType.fixed,
                        items: <BottomNavigationBarItem>[
                          _buildNavItem(Assets.assets_svgs_home_icon_svg, home, 0),
                          _buildNavItem(Assets.assets_svgs_packages_icon_svg, packages, 1),
                          _buildNavItem(Assets.assets_svgs_booking_icon_svg, bookings, 2),
                          _buildNavItem(Assets.assets_svgs_profile_icon_svg, profile, 3)
                        ],
                        currentIndex: value.selectedIndex,
                        selectedItemColor: AppColors.selectedColor,
                        unselectedItemColor: AppColors.unSelectedColor,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        onTap: value.updateIndex)))));
  }

  BottomNavigationBarItem _buildNavItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
        label: '',
        icon: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 5),
            SvgPicture.asset(icon,
                color: value.selectedIndex == index ? AppColors.selectedColor : AppColors.unSelectedColor),
            Text(label,
                style: TextStyle(
                    fontFamily: alegreya,
                    fontSize: 10,
                    color:
                        value.selectedIndex == index ? AppColors.selectedColor : AppColors.unSelectedColor)),
            if (value.selectedIndex == index)
              const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: CircleAvatar(backgroundColor: AppColors.selectedColor, radius: 3))
          ]),
        ));
  }
}
