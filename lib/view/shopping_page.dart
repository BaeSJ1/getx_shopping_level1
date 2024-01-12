import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shopping_level1/controller/cart_controller.dart';
import 'package:getx_shopping_level1/controller/shopping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final shoppingController = Get.put(ShoppingController()); //디펜던시 인젝션
  final cartController = Get.put(CartController());
  //컨트롤러가 디펜던시 인젝션 되면 다시 생성할 필요 없고, 다른 페이지로 이동해도 Get.find메소드로 컨트롤러 가져올 수 있음.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Expanded(
            child: GetX<ShoppingController>(builder: (controller) {
              return Scrollbar(
                child: ListView.builder(
                  //계속 ShoppingController를 listen하다가 데이터가 바뀌면 그 즉시 업데이트
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${controller.products[index].productName}',
                                        style: TextStyle(fontSize: 24)),
                                    Text(
                                        '${controller.products[index].productDescription}'),
                                  ],
                                ),
                                Text(
                                  '\$${controller.products[index].price}',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cartController.addToItem((controller.products[index]));
                                }, child: Text('Add to cart'))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          SizedBox(
            height: 30,
          ),
          GetX<CartController>(
            builder: (controller) {
              return Text(
                'Total amount: \$ ${controller.totalPrice}',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              );
            }
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: GetX<CartController>(
          builder: (controller) {
            return Text(
              cartController.count.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            );
          }
        ),
        icon: Icon(Icons.add_shopping_cart_rounded,
        color: Colors.white70,),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
