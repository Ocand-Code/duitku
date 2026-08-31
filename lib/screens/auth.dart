import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme/app_theme.dart';

class AuthCard extends StatelessWidget {
  final String title;
  final Widget form;

  const AuthCard({super.key, required this.title, required this.form});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F9D58), Color(0xFF11B57A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 30,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 24),
                      form,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Field email reusable.
class EmailField extends StatefulWidget {
  final ValueChanged<String>? onChange;
  final String? error;

  const EmailField({super.key, this.onChange, this.error});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF1F2937)),
      cursorColor: const Color(0xFF0F9D58),
      textInputAction: TextInputAction.next,
      autocorrect: false,
      autofillHints: const [AutofillHints.email],
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0F9D58), width: 2),
        ),
        prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF9CA3AF), size: 20),
        prefixIconConstraints: BoxConstraints(minWidth: 36),
      ),
    );
  }
}

/// Field password dengan tombol show/hide.
class PasswordField extends StatefulWidget {
  final ValueChanged<String>? onChange;
  final String? error;

  const PasswordField({super.key, this.onChange, this.error});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool _hidden;

  @override
  void initState() {
    super.initState();
    _hidden = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _hidden,
      obscuringCharacter: '•',
      style: const TextStyle(color: Color(0xFF1F2937)),
      cursorColor: const Color(0xFF0F9D58),
      textInputAction: TextInputAction.done,
      autocorrect: false,
      autofillHints: const [AutofillHints.password],
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0F9D58), width: 2),
        ),
        prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 20),
        prefixIconConstraints: BoxConstraints(minWidth: 36),
      ),
    );
  }
}