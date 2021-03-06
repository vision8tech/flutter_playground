import 'package:flutter/material.dart';
import 'package:spend_tracker/pages/icons/icon_holder.dart';
import 'package:spend_tracker/pages/icons/icons_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //
  var _formData = Map<String, dynamic>();
  var _formKey = GlobalKey<FormState>();
  IconData _newIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_formKey.currentState.validate()) return;
                _formKey.currentState.save();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                IconHolder(
                  newIcon: _newIcon,
                  onIconChange: (IconData iconData) {
                    setState(() {
                      _newIcon = iconData;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (String value) => _formData['name'] = value,
                  validator: (String value) {
                    return (value.isEmpty) ? 'Required' : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Balance'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  onSaved: (String value) => _formData['balance'] = value,
                  validator: (String value) {
                    if (value.isEmpty) return 'Required';
                    return (double.tryParse(value) == null) ? 'Invalid Number' : null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
