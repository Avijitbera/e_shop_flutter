import 'package:e_shop/provider/state.provider.dart';
import 'package:e_shop/screen/filter.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/product.model.dart';
import '../widgets/ProductItem.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> _products = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProducts();
      Provider.of<StateProvider>(context, listen: false).getCategoryList();
    });
  }

  void getProducts()async{
    var _list = await Provider.of<StateProvider>(context, listen: false).getProducts();
    setState(() {
      _products = _list;
    });
  }

  void handleSearch()async{
    if(_controller.text.isEmpty){
      getProducts();
      return;
    }
    var _list = await Provider.of<StateProvider>(context, listen: false).searchItem(_controller.text);
    setState(() {
      _products = _list;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: ListView(children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (v) {
                        handleSearch();
                      },
                      decoration: InputDecoration(
                        hintText: "Search..",
                        border: OutlineInputBorder(),
                        isDense: true,
                        suffixIcon: IconButton(icon: Icon(Icons.search, size: 20,),
                        onPressed: (){
                          handleSearch();
                        },)
                      ),
                    ),
                  ),
              
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
                  }, icon: Icon(Icons.filter_alt))
                ],
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
              ProductModel e = _products[index];
              return ProductItem(product: e,);
            }, separatorBuilder: (context, index) {
              return SizedBox(height: 20,);
            }, itemCount: _products.length)
          ],),
    );
  }
}
