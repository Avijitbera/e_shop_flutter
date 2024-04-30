import 'package:e_shop/provider/state.provider.dart';
import 'package:e_shop/screen/category.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {
  Function(double rating, int minPrice, int maxPrice, String category )? onUpdate;
  double? rating;
  int? minPrice;
  int? maxPrice;
  String? category;
   FilterScreen({super.key, this.category, this.maxPrice, this.minPrice, this.onUpdate, this.rating });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selected_category;
  SfRangeValues _values = SfRangeValues(0.0, 500.0);
  double _rating = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if(widget.maxPrice != null && widget.minPrice != null){
          _values = SfRangeValues(widget.minPrice!.toDouble(), widget.maxPrice!.toDouble());
        }
        if(widget.rating != null){
          _rating = widget.rating!;
        }
        if(widget.category != null){
          selected_category = widget.category;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close))
        ],
      ),
      body: Consumer<StateProvider>(
        builder: (context, state, _) {
          return ListView(children: [
              Padding(
                 padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text("Price Range",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600
                            ),),
              ),
            SizedBox(height: 15,),
            SfRangeSlider(
              min: 0.0,
              max: 5000.0,
              values: _values,
              interval: 500,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (SfRangeValues values){
                setState(() {
                  _values = values;
                });
              },
            ),
            SizedBox(height: 12,),
             Padding(
               padding: const EdgeInsets.only(left: 12, right: 12),
               child: Text("Rating",
                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600
                           ),),
             ),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              maxRating: 10,

              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                setState(() {
                  _rating = rating;
                });
              },
            ),
            
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text("Categories",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12,),
              child: Wrap(
                runSpacing: 8,
                spacing: 10,
                children: state.categories.map((e) {
                  return ActionChip(
                    backgroundColor: selected_category == e ?
                    Colors.blue : Colors.grey,
                    label: Text(e, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white
                    ),),
                  onPressed: (){
                    setState(() {
                      selected_category = e;
                    });
                  },);
                }).toList(),
              ),
            ),
            FilledButton(onPressed: (){
              if(widget.onUpdate == null){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category: selected_category!,
                  maxPrice: (_values.end as double).toInt(),
                  minPrice:(_values.start as double).toInt(),
                  rating: _rating,),));
              }else{
                widget.onUpdate!(_rating, (_values.end as double).toInt(), (_values.start as double).toInt(), selected_category!);
                Navigator.pop(context);
              }
              
            }, child: Text("Apply")),
          ],);
        }
      ),

    );
  }
}

