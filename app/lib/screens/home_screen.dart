import 'package:flutter/material.dart';
import 'package:foodie/screens/checkout_screen.dart';

import 'package:foodie/screens/guides_screen.dart';
import 'package:foodie/screens/profile_screen.dart';
import 'package:foodie/screens/favorite_meals_screen.dart';
import 'package:foodie/widgets/home_screen/homestack.dart';
import 'package:foodie/widgets/home_screen/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _buildContent() {
    switch (_selectedPageIndex) {
      case 1:
        return const GuidesScreen();
      case 2:
        return const CheckoutScreen();
      case 3:
        return const FavoriteMealsScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const Homestack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dwith = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: dwith < 600 ? 200 : 300,
        ),
      ),
      body: _buildContent(),
      bottomNavigationBar: BottomNavigation(
        onSelectPage: _selectPage,
        pageIndex: _selectedPageIndex,
      ),
    );
  }
}
