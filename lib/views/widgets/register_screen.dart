import 'package:flutter/material.dart';
import 'package:newshive/views/widgets/login_screen.dart';
import 'package:newshive/views/utils/helper.dart'; // warna, spacing, textStyle

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  // ---------------- WIDGET UTIL ----------------
  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          text,
          style: subtitle2.copyWith(color: cBlack, fontWeight: semibold),
        ),
      );

  InputDecoration _inputDeco(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: subtitle2,
        filled: true,
        fillColor: cGrey,
        contentPadding: fieldPadding,
        border: enableBorder,
        enabledBorder: enableBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: cWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------ HEADER ------------
                Text('Hello',
                    style: headline2.copyWith(color: cBlack, fontWeight: bold)),
                vsTiny,
                Text('Signup to get started',
                    style: subtitle2.copyWith(color: cTextBlue)),
                vsLarge,

                // ------------ NAME --------------
                _label('* Name'),
                SizedBox(
                  height: fieldHeight,
                  child: TextFormField(
                    decoration: _inputDeco('Name'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
                vsMedium,

                // ------------ PHONE -------------
                _label('* Phone Number'),
                SizedBox(
                  height: fieldHeight,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: _inputDeco('Phone Number'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
                vsMedium,

                // ------------ EMAIL -------------
                _label('* Email'),
                SizedBox(
                  height: fieldHeight,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDeco('Email'),
                    validator: (v) =>
                        (v == null || v.isEmpty || !v.contains('@'))
                            ? 'Enter valid email'
                            : null,
                  ),
                ),
                vsMedium,

                // ----------- PASSWORD -----------
                _label('* Password'),
                SizedBox(
                  height: fieldHeight,
                  child: TextFormField(
                    obscureText: _obscure,
                    decoration: _inputDeco('Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility),
                        color: cTextBlue,
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (v) =>
                        v != null && v.length < 6 ? 'Min 6 characters' : null,
                  ),
                ),
                vsXLarge,

                // -------- REGISTER BUTTON -------
                SizedBox(
                  width: double.infinity,
                  height: fieldHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Register success')),
                        );
                      }
                    },
                    child: Text('Register',
                        style: subtitle1.copyWith(
                            color: cWhite, fontWeight: semibold)),
                  ),
                ),

                vsSmall,
                // ------------- FOOTER -----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                        style: subtitle2.copyWith(color: cBlack)),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      child: Text('Login',
                          style: subtitle2.copyWith(
                              color: cPrimary, fontWeight: semibold)),
                    ),
                  ],
                ),
                vsLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
