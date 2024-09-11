import 'package:cart_geek/app/models/current_booking_response.dart';
import 'package:cart_geek/app/models/packages_response.dart';
import 'package:cart_geek/app/services/api_client.dart';
import 'package:cart_geek/app/services/api_urls.dart';
import 'package:cart_geek/app/widgets/custom_drawer/controller.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    apiCall();
  }

  final apiClient = ApiClient();
  final advancedDrawerController = AdvancedDrawerController();
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  PackagesResponse? packagesResponse;
  CurrentBookingResponse? currentBookingResponse;

  bool _loading = false;

  bool get loading => _loading;

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> apiCall() async {
    setLoading = true;
    await fetchPackages();
    await fetchCurrentBookings();
    setLoading = false;
  }

  Future<void> fetchPackages() async {
    try {
      final response = await apiClient.get<dynamic>(ApiUrls.packagesList);
      packagesResponse = PackagesResponse.fromJson(response);
      notifyListeners();
    } catch (e) {
      debugPrint('fetchPackages error: $e');
    }
  }

  Future<void> fetchCurrentBookings() async {
    try {
      final response = await apiClient.get<dynamic>(ApiUrls.currentBookingList);
      currentBookingResponse = CurrentBookingResponse.fromJson(response);
      notifyListeners();
    } catch (e) {
      debugPrint('fetchCurrentBookings error: $e');
    }
  }

  void handleMenuButtonPressed() {
    advancedDrawerController.toggleDrawer();
  }

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
