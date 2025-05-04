import 'package:customer/presentation/Features/menus/menu_view_model.dart';
import 'package:customer/data/models/category_model.dart';
import 'package:customer/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuView extends GetView<MenuViewController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuViewController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menus'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        }

        if (controller.categoryList.isEmpty) {
          return const Center(child: Text('No categories available'));
        }

        return Column(
          children: [
            // Categories Horizontal List
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final category = controller.categoryList[index];

                  return GestureDetector(
                    onTap: () async {
                      controller.selectedCategoryId.value =
                          category.categoryId ?? '';

                      await controller.getProductsList(category.categoryId!);
                    },
                    child: Obx(
                      () => CategoryCard(
                        category: category,
                        isSelected:
                            controller.selectedCategoryId.value ==
                            category.categoryId,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Divider
            const Divider(thickness: 1),

            // Products Section Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => Text(
                      '${controller.productsList.length} items',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),

            // Products Grid
            Expanded(
              child: Obx(() {
                if (controller.isProductsLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                }

                // Then check if product list is empty
                if (controller.productsList.isEmpty) {
                  return const Center(
                    child: Text('No products available in this Category'),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.productsList.length,
                  itemBuilder: (context, index) {
                    final product = controller.productsList[index];
                    return ProductCard(product: product);
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryCard({
    Key? key,
    required this.category,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
       
        color: isSelected ? Colors.green.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Colors.green, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category,
            size: 32,
            color: isSelected ? Colors.green : Colors.green.withOpacity(0.7),
          ),
          const SizedBox(height: 8),
          Text(
            category.categoryName ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.green : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(Icons.fastfood, size: 64, color: Colors.grey[400]),
              ),
            ),
          ),

          // Product Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'Unknown Product',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${product.price?.toStringAsFixed(2) ?? '0'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const Icon(Icons.add_circle, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
