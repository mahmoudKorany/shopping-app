import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_cubit.dart';
import 'package:shopping_app/modules/shop_home_layout/cubit/shop_states.dart';
import 'package:shopping_app/shared_components/components.dart';
import '../../shared_components/colors.dart';
import '../search_screen/search_screen.dart';

class ShopHomeLayoutScreen extends StatelessWidget {
  const ShopHomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopHomeCubit.get(context);
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title:  Text(
            'salla',
            style: TextStyle(
              fontFamily: 'Jannah',
              color: defaultColor,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(
                  context: context,
                  widget: const SearchScreen(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: cubit.shopScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle:
              Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
          onTap: (index) {
            cubit.changeBottomNavBar(index);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.apps_outlined,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
        ),
      ),
    );
  }
}
