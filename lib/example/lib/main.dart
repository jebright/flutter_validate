import 'package:flutter/material.dart';
import 'package:flutter_validate/example/lib/contact.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  //final _contactPreferenceKey = GlobalKey<FormFieldState>();
  //final RuleEngine _engine = new RuleEngine();
  final Contact contact = new Contact();
  ContactValidator myContactValidator;

  final nameController = new TextEditingController();
  final dobController = new TextEditingController();
  final phoneController = new TextEditingController();
  FormFieldValidator nameValidator;
  FormFieldValidator dobValidator;
  FormFieldValidator phoneValidator;

  MyCustomFormState() {
    //Controllers are used to sync up the formfield data with the Contact view model.
    //This allows us to validate against the business object data.
    nameController.addListener(() => contact.name = nameController.text);
    dobController.addListener(() => contact.dob = DateTime.tryParse(dobController.text));
    phoneController.addListener(() => contact.phone = phoneController.text);

    //WULO: you thought you could set the errortext property.  Not so.  The InputDecoration ctor is declared as const.
    //remember how flutter works, components are recreated in the build method and most properties are passed into ctors as final

    // _engine.ruleFor("fullName")
    //   ..notEmpty()
    //   ..withMessage('Name is required.')
    //   ..length(10, 20)
    //   ..withMessage('Name must be between 10 and 20 characters.');
    // _engine.ruleFor("dob")..notEmpty();
    // _engine.ruleFor("phone")
    //   ..notEmpty()
    //   ..when((v) => contactPreferenceIsPhoneNumber(v));

    //------v2---------
    //the advantage of passing in a function is that I have real-time access to the value I am validating.

    myContactValidator = new ContactValidator(contact);
    myContactValidator.ruleFor("name", () => contact.name)
      ..notEmpty()
      ..withMessage('Name is required.')
      ..length(10, 20)
      ..withMessage('Name must be between 10 and 20 characters.');
    myContactValidator.ruleFor("dob", () => contact.dob)..notEmpty();
    myContactValidator.ruleFor("phone", () => contact.phone)
      ..notEmpty()
      ..when(() => contact.contactPreference == 'PHONE');

    nameValidator =
        (value) => myContactValidator.validateRuleFor("name").errorText;
    dobValidator =
        (value) => myContactValidator.validateRuleFor("dob").errorText;
    phoneValidator =
        (value) => myContactValidator.validateRuleFor("phone").errorText;
  }

  // String getErrorTextForName() {
  //   print('getting error text for name');
  //   String e =_engine.validateRuleFor("fullName", nameController.text).errorText;
  //   print("Error was: " + e);
  //   return e;
  // }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      autovalidate: true,
      child: new ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your first and last name',
              labelText: 'Full Name',
            ),
            controller: nameController,
            validator: nameValidator,
          ),
          TextFormField(
            decoration: new InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth',
              labelText: 'Dob',
            ),
            controller: dobController,
            keyboardType: TextInputType.datetime,
            validator: dobValidator,
          ),
          Column(
            children: <Widget>[
              RadioListTile<String>(
                title: const Text('Phone'),
                value: 'PHONE',
                groupValue: contact.contactPreference,
                onChanged: (String value) {
                  setState(() {
                    contact.contactPreference = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Email'),
                value: 'EMAIL',
                groupValue: contact.contactPreference,
                onChanged: (String value) {
                  setState(() {
                    contact.contactPreference = value;
                  });
                },
              ),
            ],
          ),
          TextFormField(
            decoration: new InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter your phone number',
              labelText: 'Phone',
            ),
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: phoneValidator,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
                else {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Form not valid!')));
                }
              },
              child: Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                _formKey.currentState.reset();
              },
              child: Text('Reset'),
            ),
          ),          
        ],
      ),
    );
  }
}
