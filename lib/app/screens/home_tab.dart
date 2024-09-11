import 'package:cart_geek/app/constants/colors.dart';
import 'package:cart_geek/app/constants/strings.dart';
import 'package:cart_geek/app/provider/home_provider.dart';
import 'package:cart_geek/app/screens/widget/common_button.dart';
import 'package:cart_geek/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return CustomScrollView(slivers: [
        SliverToBoxAdapter(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildProfileSection(),
          _buildBookingCard(),
          if (provider.loading)
            const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                    child: CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.headingColor,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.selectedColor))))
          else ...[_buildCurrentBookingCard()]
        ])),
        if (!provider.loading) _buildPackagesCardWidget()
      ]);
    });
  }

  Widget _buildProfileSection() {
    return const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Row(children: [
          CircleAvatar(radius: 26.5, backgroundImage: AssetImage(Assets.assets_pngs_profile_pic_png)),
          SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(welcome,
                style: TextStyle(
                    color: AppColors.unSelectedColor,
                    fontSize: 16,
                    fontFamily: alegreya,
                    fontWeight: FontWeight.w700)),
            Text(emilyCyrus,
                style: TextStyle(
                    color: AppColors.selectedColor,
                    fontSize: 20,
                    fontFamily: alegreya,
                    fontWeight: FontWeight.w700))
          ])
        ]));
  }

  Widget _buildBookingCard() {
    return SizedBox(
        height: 210,
        child: Stack(alignment: Alignment.center, children: [
          Container(
              height: 165,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 24, right: 30, top: 20),
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(12)),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 35),
                    Text('Nanny And\nBabysitting Services',
                        style: TextStyle(
                            color: AppColors.headingColor,
                            fontSize: 18,
                            fontFamily: alegreya,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    CommonButton(
                        child: Center(
                            child: Text(bookNow,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: alegreya,
                                    fontWeight: FontWeight.w500))))
                  ])),
          Positioned(
              right: 6,
              top: 0,
              bottom: 0,
              child: SizedBox(
                  height: 220,
                  child: Image.asset(
                    Assets.assets_pngs_new_card_image_png,
                    fit: BoxFit.cover,
                  )))
        ]));
  }

  Widget _buildCurrentBookingCard() {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      if (value.currentBookingResponse == null || value.currentBookingResponse!.response == null) {
        return const SizedBox();
      }
      if (value.currentBookingResponse!.response!.isEmpty) {
        return const Text('No current bookings');
      }
      final booking = value.currentBookingResponse!.response!.first;
      return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24,top: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(yourCurrentBooking,
                style: TextStyle(
                    color: AppColors.headingColor,
                    fontSize: 20,
                    fontFamily: alegreya,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 15),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 20),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withOpacity(0.078), blurRadius: 7)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(children: [
                  Row(children: [
                    Text(booking.title ?? '',
                        style: const TextStyle(
                            color: AppColors.selectedColor,
                            fontSize: 16,
                            fontFamily: alegreya,
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    const CommonButton(
                        height: 24,
                        width: 80,
                        buttonColor: AppColors.selectedColor,
                        child: Center(
                            child: Text(start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontFamily: alegreya,
                                    fontWeight: FontWeight.w500))))
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: fromToWidget(
                            heading: from, date: booking.fromDate ?? '', time: booking.fromTime ?? '')),
                    Expanded(
                        child:
                            fromToWidget(heading: to, date: booking.toDate ?? '', time: booking.toTime ?? ''))
                  ]),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const CommonButton(
                        height: 24,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.star_border, color: Colors.white, size: 14),
                          SizedBox(width: 5),
                          Text(rateUs,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: alegreya,
                                  fontWeight: FontWeight.w500))
                        ])),
                    const CommonButton(
                        width: 100,
                        height: 24,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
                          SizedBox(width: 5),
                          Text(geolocation,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: alegreya,
                                  fontWeight: FontWeight.w500))
                        ])),
                    CommonButton(
                        width: 100,
                        height: 24,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SvgPicture.asset(Assets.assets_svgs_radio_icon_svg),
                          const SizedBox(width: 5),
                          const Text(survillence,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: alegreya,
                                  fontWeight: FontWeight.w500))
                        ]))
                  ])
                ]))
          ]));
    });
  }

  Widget _buildPackagesCardWidget() {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 16),
        sliver: Consumer<HomeProvider>(builder: (context, provider, child) {
          if (provider.packagesResponse == null || provider.packagesResponse!.response == null) {
            return const SliverToBoxAdapter(child: SizedBox());
          }
          if (provider.packagesResponse == null || provider.packagesResponse!.response!.isEmpty) {
            return const SliverToBoxAdapter(child: Text('No packages available'));
          }
          final packages = provider.packagesResponse!.response;
          return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            if (index == 0) {
              return const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text('Packages',
                      style: TextStyle(
                          color: AppColors.headingColor,
                          fontSize: 20,
                          fontFamily: alegreya,
                          fontWeight: FontWeight.w700)));
            }

            final packageIndex = index - 1;
            final package = packages[packageIndex];

            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).copyWith(bottom: 20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: (packageIndex % 2 != 0) ? AppColors.secondCardColor : AppColors.firstCardColor),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        SvgPicture.asset(Assets.assets_svgs_big_calendar_svg,
                            colorFilter: ColorFilter.mode(
                                (packageIndex % 2 != 0) ? Colors.white : AppColors.bigCalendarColor,
                                BlendMode.srcIn)),
                        const Spacer(),
                        CommonButton(
                            height: 24,
                            width: 80,
                            buttonColor: (packageIndex % 2 != 0)
                                ? AppColors.secondButtonColor
                                : AppColors.selectedColor,
                            child: const Center(
                                child: Text('Book Now',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: alegreya,
                                        fontWeight: FontWeight.w500))))
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        Text(package.title ?? '',
                            style: const TextStyle(
                                color: AppColors.headingColor,
                                fontSize: 16,
                                fontFamily: alegreya,
                                fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('₹ ${package.price}',
                            style: const TextStyle(
                                color: AppColors.headingColor,
                                fontSize: 16,
                                fontFamily: alegreya,
                                fontWeight: FontWeight.w700))
                      ]),
                      const SizedBox(height: 8),
                      Text(package.desc ?? '',
                          maxLines: 2,
                          style: TextStyle(
                              color: (packageIndex % 2 != 0) ? Colors.white : AppColors.descriptionColor,
                              fontSize: 10,
                              fontFamily: alegreya,
                              fontWeight: FontWeight.w400))
                    ]));
          }, childCount: packages!.length + 1));
        }));
  }

  Widget fromToWidget({required String heading, required String date, required String time}) {
    return Row(children: [
      Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(heading,
            style: const TextStyle(
                color: AppColors.unSelectedColor,
                fontSize: 12,
                fontFamily: alegreya,
                fontWeight: FontWeight.w400)),
        Row(children: [
          SvgPicture.asset(Assets.assets_svgs_calendar_icon_svg),
          const SizedBox(width: 6),
          Text(date,
              style: const TextStyle(
                  color: AppColors.unSelectedColor,
                  fontSize: 16,
                  fontFamily: alegreya,
                  fontWeight: FontWeight.w500))
        ]),
        Row(children: [
          SvgPicture.asset(Assets.assets_svgs_clock_icon_svg),
          const SizedBox(width: 6),
          Text(time,
              style: const TextStyle(
                  color: AppColors.unSelectedColor,
                  fontSize: 16,
                  fontFamily: alegreya,
                  fontWeight: FontWeight.w500))
        ])
      ]))
    ]);
  }
}
