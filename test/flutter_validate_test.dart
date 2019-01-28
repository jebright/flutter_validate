import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_validate/flutter_validate.dart';

void main() {


// //--playing around with message
//   test('when not equal / with message, notEqual called, has proper message', () {
//       String a = 'a';
//       String b = 'b';
//       var x = new NotEqualValidator()..notEqual(a, b)..withMessage('a <> b');
//       expect(x.message, 'a <> b');
//   });

//   test('when equal / with message, notEqual called, has null message', () {
//       String a = 'a';
//       String b = 'a';
//       var x = new NotEqualValidator()..notEqual(a, b)..withMessage('a <> b')..validate();
//       expect(x.message, null);
//   });


  //TODO: how to validate an entire object ????  My design so far means we have to pass in a property value when we call validateOnly.
  //how can we say engine.validate(customer) ???

// //playing around with when
//   test('when not equal / onlyWhen, notEqual called, returns null', () {
//       String a = 'a';
//       String b = 'b';
//       var x = new NotEqualValidator()..notEqual(a, b)..withMessage('a <> b')..onlyWhen();
//       expect(x.message, null);
//   });
}
