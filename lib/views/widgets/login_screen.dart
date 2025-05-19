import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newshive/routes/route_names.dart';
import 'package:newshive/views/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _isLoading = false;
  bool _showSuccess = false;

  void _navigateToRegister() {
    context.pushNamed(RouteName.register);
  }

  void _showSuccessNotification() {
    setState(() => _showSuccess = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showSuccess = false);
        context.goNamed(RouteName.home);
      }
    });
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      setState(() => _isLoading = false);
      _showSuccessNotification();
    }
  }

  InputDecoration _inputDeco(String hint, {Widget? prefix, Widget? suffix}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: subtitle2.copyWith(color: cTextBlue),
        filled: true,
        fillColor: cGrey,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Text('*', style: TextStyle(color: cError, fontSize: 14)),
            hsSuperTiny,
            Text(text,
                style: subtitle2.copyWith(
                    color: cBlack, fontWeight: FontWeight.w600)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header and form fields...
                    Text('Hello',
                        style: headline2.copyWith(
                            color: cBlack, fontWeight: FontWeight.w700)),
                    vsTiny,
                    Text('Again',
                        style: headline2.copyWith(
                            color: cPrimary, fontWeight: FontWeight.w700)),
                    vsTiny,
                    Text('Welcome back you\'ve been missed',
                        style: subtitle2.copyWith(color: cTextBlue)),
                    vsLarge,

                    _label('Email'),
                    TextFormField(
                      decoration: _inputDeco('Enter your email',
                          prefix: Icon(Icons.email_outlined, color: cTextBlue)),
                      validator: (v) =>
                          v!.isEmpty ? 'Please enter your email' : null,
                    ),
                    vsMedium,

                    _label('Password'),
                    TextFormField(
                      obscureText: _obscure,
                      decoration: _inputDeco('Enter your password',
                          prefix: Icon(Icons.lock_outline, color: cTextBlue),
                          suffix: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          )),
                      validator: (v) =>
                          v!.length < 6 ? 'Minimum 6 characters' : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?',
                            style: subtitle2.copyWith(color: cError)),
                      ),
                    ),
                    vsXLarge,

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text('Login',
                                style: subtitle1.copyWith(
                                    color: cWhite,
                                    fontWeight: FontWeight.w600)),
                      ),
                    ),
                    vsLarge,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? ',
                            style: subtitle2.copyWith(color: cTextBlue)),
                        GestureDetector(
                          onTap: _navigateToRegister,
                          child: Text('Sign Up',
                              style: subtitle2.copyWith(
                                  color: cPrimary,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Success Notification
          if (_showSuccess)
            Center(
              child: Container(
                width: 220, // Adjusted width
                height: 220, // Adjusted height
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cSuccess,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.white, size: 36),
                    const SizedBox(height: 8),
                    Text('Sign Up Successful!',
                        style: subtitle1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
