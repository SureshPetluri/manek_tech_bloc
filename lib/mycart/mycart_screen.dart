import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../model/local_storage_model.dart';
import '../themes/themes.dart';
import '../utils/utils.dart';

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
    cartList = LocalStorage.getListDeviceFromStorage();
  }

  int quantityGetting() {
    int totalQuantity = 0;
    for (int i = 0; i < cartList.length; i++) {
      totalQuantity += cartList[i].quantity ?? 0;
    }
    return totalQuantity;
  }

  int totalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < cartList.length; i++) {
      totalPrice += cartList[i].quantity! * cartList[i].price!;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "My Cart",
          style: LocalStorage.buildTextStyle(appBar: "appBar"),
        )),
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) => InkWell(
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
                              cartList[index].productImage ??
                                  "assets/images/emptypng.png",
                              fit: BoxFit.fitHeight,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 14.0),
                                child: Text(
                                  cartList[index].productName ?? "",
                                  style: LocalStorage.buildTextStyle(),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, left: 14),
                                    child: Text(
                                      "Price",
                                      style: LocalStorage.buildTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 18.0),
                                    child: Text(
                                        "\$${cartList[index].quantity! * cartList[index].price!}",
                                        style: LocalStorage.buildTextStyle()),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, left: 14),
                                    child: Text("Quantity",
                                        style: LocalStorage.buildTextStyle()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 18),
                                    child: Text(
                                        "${cartList[index].quantity ?? 1}",
                                        style: LocalStorage.buildTextStyle()),
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
                  return alert(context, index);
                },
              );
            }),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: ThemeColors.lightBlueColor,
        child: ListTile(
          leading: Text("Total Items: ${quantityGetting()}",
              style: LocalStorage.buildTextStyle()),
          trailing: Text("GrandTotal :   ${totalPrice()}",
              style: LocalStorage.buildTextStyle()),
        ),
      ),
    );
  }

  AlertDialog alert(BuildContext context, int index) {
    return AlertDialog(
      title: const Text("Remove Item"),
      content: const Text("Are you sure you want to remove this item?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  cartList.removeAt(index);
                  box.remove("localCartData");
                  box.write("localCartData", cartList);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text("Remove")),
          ],
        )
      ],
    );
  }
}
