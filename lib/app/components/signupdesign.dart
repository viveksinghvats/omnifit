import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TextFormFieldDemo extends StatefulWidget {
  const TextFormFieldDemo({Key key}) : super(key: key);

  @override
  TextFormFieldDemoState createState() => TextFormFieldDemoState();
}

class PersonData {
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.restorationId,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
  });

  final String restorationId;
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> with RestorationMixin {
  final RestorableBool _obscureText = RestorableBool(true);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_obscureText, 'obscure_text');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText.value,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText.value = !_obscureText.value;
            });
          },
          child: Icon(
              _obscureText.value ? Icons.visibility : Icons.visibility_off,
              semanticLabel: "Password"),
        ),
      ),
    );
  }
}

class TextFormFieldDemoState extends State<TextFormFieldDemo>
    with RestorationMixin {
  PersonData person = PersonData();

  FocusNode _phoneNumber, _email, _lifeStory, _password, _retypePassword;

  @override
  void initState() {
    super.initState();
    _phoneNumber = FocusNode();
    _email = FocusNode();
    _lifeStory = FocusNode();
    _password = FocusNode();
    _retypePassword = FocusNode();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _email.dispose();
    _lifeStory.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  @override
  String get restorationId => 'text_field_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_autoValidateModeIndex, 'autovalidate_mode');
  }

  final RestorableInt _autoValidateModeIndex =
      RestorableInt(AutovalidateMode.disabled.index);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();
  final _UsNumberTextInputFormatter _phoneNumberFormatter =
      _UsNumberTextInputFormatter();

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateModeIndex.value =
          AutovalidateMode.always.index; // Start validating on every change.
      Get.snackbar("Invalid", "Please Fill The Required Fields");
    } else {
      form.save();
      print(form);
      showInSnackBar("Form Data Saved : ${person.email}");
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "Please Enter Your Name";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "Only Alphabetical Characters Are Allowed In Names";
    }
    return null;
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Please Enter Your Email";
    }
    if (!value.contains("@") && value.length < 5) {
      return "Enter A valid Email Address";
    }
    return null;
  }

  String _validatePhoneNumber(String value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) {
      return "Please Enter Valid Phone No";
    }
    return null;
  }

  String _validatePassword(String value) {
    final passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty) {
      return "Please Enter Password";
    }
    if (passwordField.value != value) {
      return "Password MisMatch";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
      child: Scrollbar(
        child: SingleChildScrollView(
          restorationId: 'text_field_demo_scroll_view',
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  filled: true,
                  icon: const Icon(Icons.person),
                  hintText: "What People Call You",
                  labelText: "Enter Your Name",
                ),
                onSaved: (value) {
                  person.name = value;
                  _phoneNumber.requestFocus();
                },
                validator: _validateName,
              ),
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: _phoneNumber,
                decoration: InputDecoration(
                  filled: true,
                  icon: const Icon(Icons.phone),
                  hintText: "Where We Can Reach You",
                  labelText: "Enter Your Phone No",
                  prefixText: '+91 ',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  person.phoneNumber = value;
                  _email.requestFocus();
                },
                maxLength: 14,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                validator: _validatePhoneNumber,
                // TextInputFormatters are applied in sequence.
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  // Fit the validating format.
                  _phoneNumberFormatter,
                ],
              ),
              sizedBoxSpace,
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: _email,
                decoration: InputDecoration(
                  filled: true,
                  icon: const Icon(Icons.email),
                  hintText: "Your Email Address",
                  labelText: "Enter Your Email",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                onSaved: (value) {
                  person.email = value;
                  _lifeStory.requestFocus();
                },
              ),
              sizedBoxSpace,
              PasswordField(
                restorationId: 'password_field',
                textInputAction: TextInputAction.next,
                focusNode: _password,
                fieldKey: _passwordFieldKey,
                helperText: "No More Than 8 Characters",
                labelText: "Password",
                onFieldSubmitted: (value) {
                  setState(() {
                    person.password = value;
                    _retypePassword.requestFocus();
                  });
                },
              ),
              sizedBoxSpace,
              TextFormField(
                focusNode: _retypePassword,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Re-Type Password",
                ),
                maxLength: 8,
                obscureText: true,
                validator: _validatePassword,
                onFieldSubmitted: (value) {
                  _handleSubmitted();
                },
              ),
              sizedBoxSpace,
              Center(
                child: ElevatedButton(
                  onPressed: _handleSubmitted,
                  child: Text("Submit"),
                ),
              ),
              sizedBoxSpace,
              Text(
                "* indicates required fields",
                style: Theme.of(context).textTheme.caption,
              ),
              sizedBoxSpace,
            ],
          ),
        ),
      ),
    );
  }
}

/// Format incoming numeric text to fit the format of (###) ###-#### ##
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
