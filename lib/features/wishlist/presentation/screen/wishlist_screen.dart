import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradly/core/widgets/card_view.dart';
import 'package:tradly/features/products/presentation/screen/product_details_screen.dart';
import 'package:tradly/features/wishlist/presentation/provider/wishlist_provider.dart';

class WishListView extends ConsumerWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishList = ref.watch(wishListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
      ),
      body: wishList.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: wishList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = wishList[index];
                  return CardView(
                    image: product.thumbnail,
                    name: product.title,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(productId: product.id),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
