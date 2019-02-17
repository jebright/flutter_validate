import 'package:flutter/material.dart';
import 'package:flutter_validate/flutter_validate.dart';

// Create a Form Widget
class ValidationFormField extends StatefulWidget {
  @override
  ValidationFormFieldState createState() {
    return ValidationFormFieldState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class ValidationFormFieldState extends State<ValidationFormField> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<ValidationFormFieldState>!
  final _formKey = GlobalKey<FormState>();
  final RuleEngine _engine = new RuleEngine();

  ValidationFormFieldState() {
    _engine.ruleFor("fullName")
      ..notEmpty()
      ..withMessage('Name is required.')
      ..length(10, 20)
      ..withMessage('Name must be between 10 and 20 characters.');
    _engine.ruleFor("dob")..notEmpty();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: new ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          Text(
            'FORM FIELD VALIDATION',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your first and last name',
              labelText: 'Full Name',
            ),
            validator: (value) {
              return _engine.validateRuleFor("fullName", value).errorText;
            },
          ),
          TextFormField(
            decoration: new InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth',
              labelText: 'Dob',
            ),
            keyboardType: TextInputType.datetime,
            validator: (value) {
              return _engine.validateRuleFor("dob", value).errorText;
            },
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
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
