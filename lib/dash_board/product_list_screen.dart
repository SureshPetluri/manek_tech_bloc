import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech/mycart/mycart_screen.dart';
import '../model/product_listing_model.dart';
import '../themes/themes.dart';
import 'product_list_bloc.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListBloc _newsBloc = ProductListBloc();
  final ScrollController _scrollController = ScrollController();
  bool loading = false, allLoaded = false, reachEnd = true;

  List<String> items = [];
  List<ProductListingModel> listModel = [];
  dynamic totalRecords = 0;

  _listener() async {
    final scroll = _scrollController.position.minScrollExtent;
    if (_scrollController.offset >= scroll) {
      reachEnd = false;
      setState(() {});
      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        totalRecords = totalRecords + 5;
      });
    } else {
      reachEnd = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    _newsBloc.add(GetProductList());
    totalRecords = 7;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(_listener);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Shopping Mall")),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 40),
          child: BlocProvider(
            create: (_) => _newsBloc,
            child: BlocListener<ProductListBloc, productListState>(
              listener: (context, state) {
                if (state is ProductListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child: BlocBuilder<ProductListBloc, productListState>(
                builder: (context, state) {
                  if (state is ProductListInitial) {
                    return _buildLoading();
                  } else if (state is ProductListLoading) {
                    return _buildLoading();
                  } else if (state is ProductListLoaded) {
                    return buildProductShowGridView(state.dashBoardModel);
                  } else if (state is ProductListError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Stack buildProductShowGridView(ProductListingModel model) {
    return Stack(children: [
      GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30),
          itemCount: totalRecords <= model.data?.length
              ? totalRecords
              : model.data?.length,
          itemBuilder: (context, index) => InkWell(
                child: Container(
                  decoration: _buildContainerBoxDecoration(),
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      decoration: _buildContainerBoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: 130,
                              width: 150, // MediaQuery.of(context).size.height,
                              decoration: _buildContainerBoxDecoration(),
                              child: Image.network(
                                model.data?[index].featuredImage ?? " ",
                                fit: BoxFit.fitHeight,
                              )),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: ThemeColors.whiteColor,
                            ),
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      model.data?[index].title ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyCartScreen(model.data?[index])),
                  );
                },
              )),
      reachEnd == false && totalRecords <= model.totalRecord
          ? Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 80,
                child: _buildLoading(),
              ))
          : const SizedBox(),
    ]);
  }

  BoxDecoration _buildContainerBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}