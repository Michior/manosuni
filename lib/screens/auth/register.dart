import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart'; // Importa tu archivo de AppTheme

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Definimos el theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --- Main content ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 150),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Title
                    Text(
                      "ManosUni",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.appBarTheme.foregroundColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Welcome, let's make a difference.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.appBarTheme.foregroundColor?.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // --- Name ---
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Nombre",
                        prefixIcon: Icon(Icons.person, color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),

                    // --- Email ---
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined, color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // --- Password ---
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline, color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),

                    // --- Register button ---
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/explorer'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          "Registrarme",
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.appBarTheme.foregroundColor, // cambia con tema oscuro
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Footer ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                  text: "¿Ya tienes cuenta? ",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.appBarTheme.foregroundColor?.withOpacity(0.6),
                  ),
                  children: [
                    TextSpan(
                      text: "Iniciar Sesión",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/login'),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
