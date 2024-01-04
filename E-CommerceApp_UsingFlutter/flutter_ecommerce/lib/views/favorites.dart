import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/themes.dart';
import 'package:flutter_ecommerce/controllers/itembag_controller.dart';
import 'package:flutter_ecommerce/controllers/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class Favorites extends ConsumerWidget{
  const Favorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final products = ref.watch(proudctNotifierProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => Card(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(products[index].imgUrl),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].title,
                                  style: AppTheme.kCardTitle,
                                ),
                                const Gap(6),
                                Text(
                                  products[index].shortDescription,
                                  style: AppTheme.kBodyText,
                                ),
                                const Gap(4),
                                Text(
                                  '\$${products[index].price}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ))
                    ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
