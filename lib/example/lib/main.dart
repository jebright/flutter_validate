import 'package:flutter/material.dart';
import 'package:flutter_validate/example/lib/contact.dart';

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

// Create a corresponding State class. This class will hold the data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final Contact contact = new Contact();
  ContactValidator myContactValidator;

  final nameController = new TextEditingController();
  final dobController = new TextEditingController();
  final phoneController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();
  FormFieldValidator nameValidator;
  FormFieldValidator dobValidator;
  FormFieldValidator phoneValidator;
  FormFieldValidator emailValidator;
  FormFieldValidator passwordValidator;
  FormFieldValidator confirmPasswordValidator;

  bool beUniqueEmailAddress<String>(String email) {

    List<String> emails = List.from(["test@test.com", "1@1.com", "joe@gmail.com"]);

    return !emails.contains(email);
  }

  MyCustomFormState() {
    //Controllers are used to sync up the formfield data with the Contact view model.
    //This allows us to validate against the business object data.
    nameController.addListener(() => contact.name = nameController.text);
    dobController.addListener(() => contact.dob = dobController.text);
    phoneController.addListener(() => contact.phone = phoneController.text);
    emailController.addListener(() => contact.email = emailController.text);
    passwordController.addListener(() => contact.password = passwordController.text);
    confirmPasswordController.addListener(() => contact.confirmPassword = confirmPasswordController.text);

    //Create a validator and add rules
    myContactValidator = new ContactValidator(contact);
    myContactValidator.ruleFor("name", () => contact.name)
      ..notEmpty()
      ..withMessage('Name is required.')
      ..length(10, 20)
      ..withMessage('Name must be between 10 and 20 characters.');
    myContactValidator.ruleFor("dob", () => contact.dob)
      ..notEmpty()
      ..date();
    myContactValidator.ruleFor("phone", () => contact.phone)
      ..notEmpty()
      ..phoneNumber()
      ..when(() => contact.contactPreference == 'PHONE');
    myContactValidator.ruleFor("email", () => contact.email)
      ..notEmpty()
      ..emailAddress()
      ..must(beUniqueEmailAddress)
      ..when(() => contact.contactPreference == 'EMAIL');
    myContactValidator.ruleFor("password", () => contact.password)
      ..notEmpty()
      ..length(8, 16);
    myContactValidator.ruleFor("confirmPassword", () => contact.confirmPassword)
      ..equal(() => contact.password, 'Password');

    //In Flutter, signaling a validation rule error is done by providing any
    //non-null text to a FormField's validator.
    nameValidator =
        (value) => myContactValidator.validateRuleFor("name").errorText;
    dobValidator =
        (value) => myContactValidator.validateRuleFor("dob").errorText;
    phoneValidator =
        (value) => myContactValidator.validateRuleFor("phone").errorText;
    emailValidator = 
        (value) => myContactValidator.validateRuleFor("email").errorText;
    passwordValidator = 
        (value) => myContactValidator.validateRuleFor("password").errorText;
    confirmPasswordValidator = 
        (value) => myContactValidator.validateRuleFor("confirmPassword").errorText;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      autovalidate: true,
      child: new ListView(
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
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Enter your email address',
              labelText: 'Email',
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.lock),
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: passwordValidator,
          ),
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.lock),
              hintText: 'Enter your password again',
              labelText: 'Confirm Password',
            ),
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: confirmPasswordValidator,
          ),          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Good news! All data in form is valid!')));
                } else {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Form not valid!')));
                }
              },
              child: Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
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
