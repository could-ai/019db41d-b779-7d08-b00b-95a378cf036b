import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'main_layout.dart';
import '../theme/app_theme.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerify() async {
    if (_otpController.text.length == 6) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.verifyOtp(widget.phone, _otpController.text);
      
      if (success && mounted) {
        // Navigate to Main Layout and clear stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainLayout()),
          (route) => false,
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP. Use 123456 for testing.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter OTP',
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'We have sent a 6-digit code to +91 ${widget.phone}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(letterSpacing: 8),
                decoration: const InputDecoration(
                  hintText: '000000',
                  counterText: '',
                ),
                onChanged: (value) {
                  if (value.length == 6) {
                    _handleVerify();
                  }
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authProvider.isLoading ? null : _handleVerify,
                  child: authProvider.isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Verify & Proceed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}