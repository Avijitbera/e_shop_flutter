import 'package:e_shop/provider/state.provider.dart';
import 'package:e_shop/screen/filter.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/product.model.dart';
import '../widgets/ProductItem.dart';

class CategoryScreen extends StatefulWidget {
  String category;
  int minPrice;
  int maxPrice;
  double rating;
   CategoryScreen({super.key, required this.category, 
   this.maxPrice = 500,
   this.minPrice = 0,
   this.rating = 0.0 });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String dropdownValue = "Most Popular";
  bool loading = false;
  List<ProductModel> products = [];
  TextEditingController  _controller = TextEditingController();

  double rating = 0.0;
  int maxPrice = 500;
  int minPrice = 0;


  @override
  void initState() {
    rating = widget.rating;
    minPrice = widget.minPrice;
    maxPrice = widget.maxPrice;
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }
  void getData()async{
    setState(() {
      loading = true;
    });
    products = await Provider.of<StateProvider>(context, listen: false).getCategoryProducts(name: widget.category,
    maxPrice: maxPrice, minPrice: minPrice, rating: rating);
    setState(() {
      loading = false;
    });

  }

  void handleSearch()async{
    if(_controller.text.isEmpty){
      getData();
      return;
    }
    var result = await Provider.of<StateProvider>(context,listen: false).searchProduct(name: _controller.text,
    maxPrice: maxPrice, minPrice: minPrice, rating: rating,
    category: widget.category);
    setState(() {
      products = result;
    });

  }

  void applyFilter(double _rating, int _maxPrice, int _minPrice, String category)async{
    setState(() {
      widget.category = category;
    });
    if(_controller.text.isNotEmpty){
      var result = await Provider.of<StateProvider>(context,listen: false).searchProduct(name: _controller.text,
        maxPrice: _maxPrice, minPrice: _minPrice, rating: _rating, category: widget.category);
        setState(() {
          products = result;
        });
    }else{
      setState(() {
            loading = true;
          });
        products = await Provider.of<StateProvider>(context, listen: false).getCategoryProducts(name: category,
        maxPrice: _maxPrice, minPrice: _minPrice, rating: _rating);
        setState(() {
          loading = false;
        });
    }
  }

  void handleSort(String value){
    var result = Provider.of<StateProvider>(context, listen: false).sortProducts(category: widget.category, sortBy: value);
    setState(() {
      products = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),

        

      ),
      body: ListView(
        children: [
          Row(children: [
            Text("Sort By:"),
            Expanded(child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
                handleSort(newValue == "Most Popular" ? "most" : "less");
              },
              items: <String>['Most Popular', "Less Popular"]
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
            ),)
          ],),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),

            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (v) => handleSearch(),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search..",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        
                      ),
                      suffixIcon: IconButton(icon: Icon(Icons.search),onPressed: (){
                        handleSearch();
                      },)
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(
                    category: widget.category,
                    maxPrice: maxPrice,
                    minPrice: minPrice,
                    rating: rating,
                    onUpdate: applyFilter,
                  ),
                  fullscreenDialog: true),);
                }, icon: Icon(Icons.filter_alt))
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            itemBuilder: (context, index) {
            return ProductItem(product: products[index],);
          }, separatorBuilder: (context, index) {
            return SizedBox(height: 16,);
          }, itemCount: products.length)
        ],
      ),
    );
  }
}

