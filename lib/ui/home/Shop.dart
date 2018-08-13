import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/config/Constants.dart';
import 'package:flutter_gank/models/Product.dart';

class Shop extends StatefulWidget {
  @override
  ShopState createState() => new ShopState();
}

class ShopState extends State<Shop> with AutomaticKeepAliveClientMixin {

  List<Product> list = <Product>[];
  num currPage = 1;
  ScrollController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        var maxScroll = _controller.position.maxScrollExtent;
        var pixels = _controller.position.pixels;
        if (maxScroll - pixels < 200.0) {
          currPage++;
          _getData(false);
        }
      });
    _getData(true);
  }

  //stack1
  Widget imageStack(String img) => CachedNetworkImage(
        placeholder: Image.asset(
          'images/loading.png',
          fit: BoxFit.cover,
        ),
        imageUrl: img,
        fit: BoxFit.cover,
      );

  //stack2
  Widget descStack(Product product) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(product.price,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(double rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget productGrid(List<Product> products) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
    controller: _controller,
        children: products
            .map((product) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
//                    onDoubleTap: () => showSnackBar("Added to cart."),
                    child: Material(
                      elevation: 2.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          imageStack(product.image),
                          descStack(product),
                          ratingStack(product.rating),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );

  Widget bodyData() {
    return list.isNotEmpty
        ? RefreshIndicator(
      child: productGrid(list),
      onRefresh: () => _getData(true),
    )
        : Center(child: CircularProgressIndicator());
  }

  Future<Null> _getData(bool isRefresh) async {
    if (isRefresh) {
      list.clear();
      currPage = 1;
    }

    List<Product> list_temp = <Product>[];
    for (int i = 0; i < 10; i++) {
      Product product = new Product();
      product.name = "Coffeemaker" + i.toString();
      product.image = Constants.TEST_IMAGE1;
      product.price = "￥998.9";
      product.rating = 5.0;
      list_temp.add(product);
    }
    setState(() {
      list.addAll(list_temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return bodyData();
  }
}
