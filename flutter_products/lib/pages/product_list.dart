import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped_models/main.dart';

//
class ProductListPage extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(model.products[index].title),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection dd) {
                  model.selectProduct(index);
                  model.deleteProduct();
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(backgroundImage: AssetImage(model.products[index].image)),
                      title: Text(model.products[index].title),
                      subtitle: Text('\$${model.products[index].price.toString()}'),
                      trailing: _buildItemEdit(context, index, model),
                    ),
                    Divider()
                  ],
                ),
              );
            },
            itemCount: model.products.length,
          ),
        );
      },
    );
  }

  //
  Widget _buildItemEdit(BuildContext context, int index, MainModel model) {
    //
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        );
      },
    );
  }
}
