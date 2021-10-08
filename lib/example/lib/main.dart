import 'package:flutter/material.dart';
import 'package:flutter_validate/example/lib/contact.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

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
  const MyCustomForm();

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final Contact contact = Contact();
  late ContactValidator myContactValidator;

  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late FormFieldValidator nameValidator;
  late FormFieldValidator dobValidator;
  late FormFieldValidator phoneValidator;
  late FormFieldValidator emailValidator;
  late FormFieldValidator passwordValidator;
  late FormFieldValidator confirmPasswordValidator;

  //Make sure the passed in email address does not already exist
  bool beUniqueEmailAddress<String>(String email) {
    List<String> emails = List.from(["test@test.com", "test1@test.com", "test3@test.com"]);
    return !emails.contains(email);
  }

  MyCustomFormState() {
    //Controllers are used to sync up the formfield data with the Contact view model.
    //This allows us to validate against the business object data.
    //We could just validate against the values coming from the form fields instead and that
    //might be the direction you go if you do not have a model or a really simple use case.
    nameController.addListener(() => contact.name = nameController.text);
    dobController.addListener(() => contact.dob = dobController.text);
    phoneController.addListener(() => contact.phone = phoneController.text);
    emailController.addListener(() => contact.email = emailController.text);
    passwordController.addListener(() => contact.password = passwordController.text);
    confirmPasswordController.addListener(() => contact.confirmPassword = confirmPasswordController.text);

    //Validating an object always begins with creating a validator and is followed by
    //adding rules to that validator.  In this case we created a ContactValidator by
    //deriving from AbstractValidator<T>.  Then we begin adding rules to the validator
    //for each Contact property that needed validation.  This is the approach you would
    //take when validating business objects but again if you don't have an object, you
    //can use the underlying validators (e.g. notEmptyValidator) directly.
    myContactValidator = ContactValidator(contact);
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
    myContactValidator
        .ruleFor("confirmPassword", () => contact.confirmPassword)
        .equal(() => contact.password, 'Password');

    //In Flutter, signaling a validation rule error is done by providing any
    //non-null text to a FormField's validator.  We declare this outside of the
    //build method just to keep our code easier to read.
    nameValidator = (value) => myContactValidator.validateRuleFor("name").errorText;
    dobValidator = (value) => myContactValidator.validateRuleFor("dob").errorText;
    phoneValidator = (value) => myContactValidator.validateRuleFor("phone").errorText;
    emailValidator = (value) => myContactValidator.validateRuleFor("email").errorText;
    passwordValidator = (value) => myContactValidator.validateRuleFor("password").errorText;
    confirmPasswordValidator = (value) => myContactValidator.validateRuleFor("confirmPassword").errorText;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      autovalidate: true, //we can flip this on/off to have real-time validation
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your first and last name',
              labelText: 'Full Name',
            ),
            controller: nameController,
            validator: nameValidator,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
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
                onChanged: (String? value) {
                  setState(() {
                    contact.contactPreference = value ?? '';
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Email'),
                value: 'EMAIL',
                groupValue: contact.contactPreference,
                onChanged: (String? value) {
                  setState(() {
                    contact.contactPreference = value ?? '';
                  });
                },
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              hintText: 'Enter your phone number',
              labelText: 'Phone',
            ),
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: phoneValidator,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Enter your email address',
              labelText: 'Email',
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: passwordValidator,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
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
                if (_formKey.currentState?.validate() == true) {
                  Scaffold.of(context)
                      .showSnackBar(const SnackBar(content: Text('Good news! All data in form is valid!')));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(content: const Text('Form not valid!')));
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: RaisedButton(
              onPressed: () {
                _formKey.currentState?.reset();
              },
              child: const Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }
}
