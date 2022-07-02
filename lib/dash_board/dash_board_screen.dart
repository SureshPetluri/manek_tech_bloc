import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech/dash_board_detail/dash_board_detail_screen.dart';

import '../model/dash_board_model.dart';
import 'dash_board_bloc.dart';
import 'dash_board_event.dart';
import 'dash_board_state.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final CartBloc _newsBloc = CartBloc();
  ScrollController _scrollController = ScrollController();
  bool loading = false, allLoaded = false;

  List<String> items = [];
  List<DashBoardModel> listModel = [];
  @override
  void initState() {
    _newsBloc.add(GetCartList());
    ScrollController().addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent) {
       // mockFetch();
        loading=true;
        print("sdsssdfdwsc");
      }else{
        print("else else");
      }
    });
    super.initState();
  }

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    List<String> newData = items.length >= 60
        ? []
        : List.generate(20, (index) => "List Item ${index + items.length}");
    if (newData.isNotEmpty) {
      items.addAll(newData);
    }
    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
            child: BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartInitial) {
                    return _buildLoading();
                  } else if (state is CartLoading) {
                    return _buildLoading();
                  } else if (state is CartLoaded) {
                    listModel.add(state.dashBoardModel);
                    print("listModel $listModel");
                    return buildProductShowGridView(state.dashBoardModel);
                  } else if (state is CartError) {
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

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Stack buildProductShowGridView(DashBoardModel model) {
    return Stack(children: [
      GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3.6,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: model.data?.length,
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
                              color: Colors.white,
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
                            DashBoardDetailScreen(model.data?[index])),
                  );
                },
              )),
     if(loading)...[
       Positioned(
           left: 0,
           bottom: 0,
           child: Container(
             height: 80,
            // width: constraints.maxWidth,
             child: _buildLoading(),
           ))
     ],

    ]);
  }

  BoxDecoration _buildContainerBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
