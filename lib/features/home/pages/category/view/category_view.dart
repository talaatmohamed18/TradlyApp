import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradly/core/widgets/card_view.dart';
import 'package:tradly/features/home/pages/category/viewmodel/category_viewmodel.dart';
import 'package:tradly/features/products/presentation/screen/product_details_screen.dart';

class CategoryView extends ConsumerWidget {
  final String category;
  const CategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryProductsProvider(category));
    return Scaffold(
      appBar: AppBar(title: Text(category), elevation: 0),
      body: state.when(
        data: (products) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) => CardView(
              image: products[index].thumbnail,
              name: products[index].title,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(productId: products[index].id),
                ),
              ),
            ),
          ),
        ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
