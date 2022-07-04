import 'package:flutter/material.dart';
import '../model/local_storage_model.dart';
import '../sqflite_db/sqflite_db.dart';
import '../themes/themes.dart';
import '../utils/utils.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<LocalStorageCartModel> cartList = [];
  List<LocalStorageCartModel> cartList1 = [];
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allRows = [];
  @override
  void initState() {
    super.initState();

    cartList1.clear();
    _query();
  }

  void _query() async {
    cartList1 = await AppUtils.getListDeviceFromStorage();
    cartList.clear();
    cartList.addAll(cartList1.reversed);
    setState(() {});
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "My Cart",
          style: AppUtils.buildTextStyle(appBar: "appBar"),
        )),
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
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
                              height: 125,
                              width: width > 400 ? width * 0.3 : width * 0.35,
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
                                    style: AppUtils.buildTextStyle(),
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
                                        style: AppUtils.buildTextStyle(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 18.0),
                                      child: Text(
                                          "\$${cartList[index].quantity! * cartList[index].price!}",
                                          style: AppUtils.buildTextStyle()),
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
                                          style: AppUtils.buildTextStyle()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 18),
                                      child: Text(
                                          "${cartList[index].quantity ?? 1}",
                                          style: AppUtils.buildTextStyle()),
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
                    return _alert(context, index);
                  },
                );
              });
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: ThemeColors.lightBlueColor,
        child: ListTile(
          leading: Text("Total Items: ${quantityGetting()}",
              style: AppUtils.buildTextStyle()),
          trailing: Text("GrandTotal :   ${totalPrice()}",
              style: AppUtils.buildTextStyle()),
        ),
      ),
    );
  }

  AlertDialog _alert(BuildContext context, int index) {
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
                onPressed: () async {
                  _delete(cartList[index].productId ?? 0);
                  cartList.removeAt(index);
                  setState(() {});

                  Navigator.pop(context);
                },
                child: const Text("Remove")),
          ],
        )
      ],
    );
  }

  void _delete(int index) async {
    await dbHelper.delete(index);
  }
}
