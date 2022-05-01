import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NewItemPage extends StatelessWidget {
  static String routeName = '/newItem';
  
  const NewItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Consumer<Favorites>(
          builder: (context, value, child) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: MyCustomForm(),
              )),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormBuilderState>();

  List<User> users = [
    User(
      id: 1,
      name: 'Name',
    ),
    User(
      id: 2,
      name: 'Name2',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FormBuilder(
          key: _formKey,
          // autovalidate: true,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                name: 'title',
                validator: FormBuilderValidators.required(context),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              FormBuilderDropdown(
                name: 'userId',
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                // initialValue: 'Male',
                allowClear: true,
                validator: FormBuilderValidators.required(context),
                hint: Text('Select Gender'),
                // validator: FormBuilderValidators.compose(
                //     [FormBuilderValidators.required(context)]),
                items: users
                    .map((gender) => DropdownMenuItem(
                          value: gender.id,
                          child: Text(gender.name),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    print(_formKey.currentState!.value);
                    Navigator.pop(context, true);
                  } else {
                    print("validation failed");
                  }
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState!.reset();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
