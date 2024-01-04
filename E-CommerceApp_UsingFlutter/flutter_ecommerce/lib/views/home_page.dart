
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/themes.dart';
import 'package:flutter_ecommerce/controllers/itembag_controller.dart';
import 'package:flutter_ecommerce/controllers/product_controller.dart';
import 'package:flutter_ecommerce/views/Notification.dart';
import 'package:flutter_ecommerce/views/detail_page.dart';
import 'package:flutter_ecommerce/views/favorites.dart';
import 'package:flutter_ecommerce/views/login.dart';
import 'package:flutter_ecommerce/widgets/chip_widget.dart';
import 'package:flutter_ecommerce/widgets/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../widgets/ads_banner_widget.dart';
import 'cart_page.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});
class HomePage extends ConsumerWidget {
  int mycurrentindex = 0;
  List pages = [
    Home_view(),
    const Favorites(),
     Home_view(),
    const Notifications(),
 
  ];
  HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(proudctNotifierProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        // title: const Text("E-Commerce App", style: TextStyle(letterSpacing: 3),),
        title: SvgPicture.asset(
          'assets/general/store_brand_white.svg',
          color: kWhiteColor,
          width: 180,
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Badge(
                label: Text(itemBag.length.toString()),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.local_mall,
                      size: 24,
                    )),
              ))
        ],
      ),
      drawer: Drawer(
        surfaceTintColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kSecondaryColor,
              ),
              accountName: Text(
                "Kulmiye Hussein Hassan",
                style: TextStyle(fontSize: 16),
              ),
              accountEmail: Text("kulmiyehussein@gmail.com", style: TextStyle(fontSize: 14),),
              currentAccountPicture: CircleAvatar(
                foregroundImage: AssetImage("assets/onboard1.jpeg"),
              ),
            ),
             ListTile(
              selectedColor: kPrimaryColor,
              title: const Text("Home",),
              leading: const Icon(Icons.home_outlined, color: kSecondaryColor,),
              onTap: (){
                // Navigator.pop(context);
              },
            ),
            ListTile(
              onTap: (){},
              title: const Text("My orders"),
              leading: const Icon(Icons.local_mall_outlined, color: kSecondaryColor,),
            ),
              ListTile(
                splashColor: kSecondaryColor,
              onTap: (){
                pages[1];
              },
              title: const Text("Favorites"),
              leading: const Icon(Icons.favorite_outline, color: kSecondaryColor,),
            ),
              ListTile(
              onTap: (){},
              title: const Text("Notifications"),
              leading: const Icon(Icons.notifications_outlined, color: kSecondaryColor,),
            ),
            const Divider(
              height: 30,
              color: Colors.black38,
            ),
            ListTile(
              onTap: (){},
              title: const Text("Settings"),
              leading: const Icon(Icons.settings_outlined, color: kSecondaryColor,),
            ),
            ListTile(
              onTap: (){},
              title: const Text("About Us"),
              leading: const Icon(Icons.help_outline, color: kSecondaryColor,),
            ),
             ListTile(
              onTap: (){},
              title: const Text("About developers"),
              leading: const Icon(Icons.code_outlined, color: kSecondaryColor,),
            ),
            ListTile(
              onTap: ()  {
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              title: const Text("Logout"),
              leading: const Icon(Icons.logout_outlined, color: kSecondaryColor,),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: ElevatedButton(onPressed:  (){}, 
            //   child: Text("Logout"),
            //   ),
            // )
          ],
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) =>
            ref.read(currentIndexProvider.notifier).update((state) => value),
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kSecondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Location',
            activeIcon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notification',
            activeIcon: Icon(Icons.notifications),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   label: 'Profile',
          //   activeIcon: Icon(Icons.person),
          // ),
        ],
      ),
    );
  }
}
