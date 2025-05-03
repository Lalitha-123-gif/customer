import 'package:customer/data/data%20source/menu_data_source/menu_listing_service.dart';
import 'package:customer/data/models/category_model.dart';
import 'package:customer/data/models/product_model.dart';

import 'package:get/get.dart';

class MenuViewController extends GetxController {
  final menuService = MenuListingService();
  RxBool isLoading = false.obs;
  RxString selectedCategoryId = ''.obs;
  RxBool isProductsLoading = false.obs;

  final RxList<Category> categoryList = <Category>[].obs;
  final RxList<Product> productsList = <Product>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getCategories();
  }

  getCategories() async {
    isLoading.value = true;
    final response = await menuService.categoryList();
    print('3698:${response.map((e) => e.entries)}');

    isLoading.value = false;

    if (response.isNotEmpty) {
      categoryList.value =
          response
              .map((categoryData) => Category.fromMap(categoryData))
              .toList();
      if (categoryList.isNotEmpty) {
        selectedCategoryId.value = categoryList[0].categoryId ?? '';
        await getProductsList(selectedCategoryId.value);
      }
    }
  }

  getProductsList(String cateogryId) async {
    isProductsLoading.value = true;
    final response = await menuService.productsList(cateogryId);

    if (response.isNotEmpty) {
      productsList.value =
          response.map((productdata) => Product.fromMap(productdata)).toList();
    }
    isProductsLoading.value = false;
  }
}
