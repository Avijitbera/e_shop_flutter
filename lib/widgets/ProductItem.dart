import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/model/product.model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product });

  @override
  Widget build(BuildContext context) {
    return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CachedNetworkImage(imageUrl: product.thumbnail,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,),
                  Text(product.title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600
                  ),),
                   Text(product.description,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey.shade700

                  ),),
                  SizedBox(height: 5,),
                  Row(children: [
                    Text("\$${product.price}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),
                      
                    ),
                    Spacer(),
                    Text(product.rating.toString()),
                    Icon(Icons.star, color: Colors.yellow.shade600,),
                    SizedBox(width: 10,),
                    Container(height: 25, width: 1,
                    color: Colors.black,),
                    SizedBox(width: 10,),
                    Text("2.6K")
                  ],),
                  SizedBox(height: 8,),
                  Row(children: [
                    Expanded(child: FilledButton.icon(onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                        side: BorderSide(width: 1, color: Colors.grey.shade400)
                      ))
                    ),
                     icon: Icon(Icons.add_shopping_cart), label: Text("Clothes",
                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black
                     ),))),
                     SizedBox(width: 20,),
                    Expanded(child: FilledButton.icon(onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                        side: BorderSide(width: 1, color: Colors.grey.shade400)
                      ))
                    ),
                     icon: Icon(Icons.location_on_outlined), label: Text("Bedfordshire",
                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black
                     ),))),
                  ],)
                ],),
              );
  }
}

