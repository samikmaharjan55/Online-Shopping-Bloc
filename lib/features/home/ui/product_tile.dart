import 'package:flutter/material.dart';
import 'package:online_shopping_bloc/features/home/models/home_product_data_model.dart';

class ProductTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductTile({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  productDataModel.imageUrl,
                ),
              ),
            ),
          ),
          Text(productDataModel.name),
          Text(productDataModel.description),
        ],
      ),
    );
  }
}
