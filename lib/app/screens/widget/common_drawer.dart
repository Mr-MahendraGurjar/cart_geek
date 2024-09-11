import 'package:cart_geek/app/constants/colors.dart';
import 'package:cart_geek/app/constants/strings.dart';
import 'package:cart_geek/app/widgets/custom_drawer/controller.dart';
import 'package:cart_geek/app/widgets/custom_drawer/widget.dart';
import 'package:cart_geek/assets.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Widget child;
  final AdvancedDrawerController controller;

  const CustomDrawer({super.key, required this.child, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white)),
        openRatio: 0.6,
        controller: controller,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        openScale: 0.8,
        disabledGestures: false,
        childDecoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 15)],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        drawer: DrawerWidget(controller: controller),
        child: child);
  }
}

class DrawerWidget extends StatelessWidget {
  final AdvancedDrawerController controller;

  const DrawerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(children: [
              const SizedBox(height: 32),
              const CircleAvatar(radius: 36, backgroundImage: AssetImage(Assets.assets_pngs_profile_pic_png)),
              const SizedBox(height: 8),
              const Text(emilyCyrus,
                  style: TextStyle(
                      color: AppColors.selectedColor,
                      fontSize: 18,
                      fontFamily: alegreya,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              headingText(onTap: () => controller.hideDrawer(), name: home),
              headingText(onTap: () {}, name: bookANanny),
              headingText(onTap: () {}, name: howItWorks),
              headingText(onTap: () {}, name: whyNannyVanny),
              headingText(onTap: () {}, name: myBookings),
              headingText(onTap: () {}, name: myProfile),
              headingText(onTap: () {}, name: support, isLast: true)
            ])));
  }

  Widget headingText({Function()? onTap, required String name, bool isLast = false}) {
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(name,
                          style: const TextStyle(
                              color: AppColors.headingColor,
                              fontFamily: alegreya,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)))),
              if (!isLast) const Divider()
            ])));
  }
}
