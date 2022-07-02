import 'package:flutter/material.dart';
import 'package:manek_tech/model/product_listing_model.dart';
import '../themes/themes.dart';

class MyCartScreen extends StatelessWidget {
 const  MyCartScreen(this.data, {Key? key} ) : super(key: key);
 final Datum? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text("My Cart")),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Container(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20,top: 40),
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
                            data?.featuredImage ?? "",
                            fit: BoxFit.fitHeight,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                              padding: const EdgeInsets.only(bottom: 8.0, left: 14),
                              child: Text(data?.title ?? ""),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 8.0, left: 14),
                                  child: Text("Price"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8.0, right: 18),
                                  child: Text("\$${data?.price}"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 8.0, left: 14),
                                  child: Text("Quantity"),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 8.0, right: 18),
                                  child: Text("1"),
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
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: ThemeColors.lightBlueColor,
        child: ListTile(
          leading: const Text("Total Items: 1"),
          trailing: Text("GrandTotal :       ${data?.price}"),
        ),
      ),
    );
  }
}
