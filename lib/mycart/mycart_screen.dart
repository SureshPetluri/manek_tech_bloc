import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:manek_tech/model/product_listing_model.dart';
import '../model/local_storage_model.dart';
import '../themes/themes.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<LocalStorageCartModel> cartList = [];
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    cartList = box.read('localCartData');
  }

  quantityGetting() {
    int totalQuantity = 0;
    for (int i = 0; i < cartList.length; i++) {
      totalQuantity += cartList[i].quantity ?? 0;
    }
    return totalQuantity;
  }
  totalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice += cartList[i].quantity! * cartList[i].price! ;
    }
    return totalPrice;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("My Cart")),
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) => Container(
          child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Image.network(
                                cartList[index].productImage ?? "",
                                fit: BoxFit.fitHeight,
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 14),
                                  child:
                                      Text(cartList[index].productName ?? ""),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8.0, left: 14),
                                      child: Text("Price"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 18),
                                      child: Text("\$${cartList[index].price}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8.0, left: 14),
                                      child: Text("Quantity"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 18),
                                      child: Text("${cartList[index].quantity ?? 1}"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert(context,index);
                  },
                );
              }),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: ThemeColors.lightBlueColor,
        child: ListTile(
          leading: Text("Total Items: ${quantityGetting()}"),
          trailing: Text("GrandTotal :   ${totalPrice()}"),
        ),
      ),
    );
  }

  AlertDialog alert(BuildContext context,int index) {
    return AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        TextButton(
            onPressed: () {
              cartList.removeAt(index);
              box.remove("localCartData");
              box.write("localCartData", cartList);
              Navigator.pop(context);
              setState((){});
            },
            child: Text("Ok"))
      ],
    );
  }
}
