import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/role_provider.dart';
import '../../../../core/models/user_model.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOtpInput(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == 6) {
      _verifyOtp(otp);
    }
  }

  void _handleBackspace(int index) {
    if (index > 0 && _controllers[index].text.isEmpty) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOtp(String otp) {
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      // Mock user data - In production, this should come from API response
      // For demo purposes, we'll use phone number to determine role
      // Phone ending in '0' or '5' will be managers, others will be operators
      final lastDigit = widget.phoneNumber.isNotEmpty
          ? int.parse(widget.phoneNumber[widget.phoneNumber.length - 1])
          : 0;

      final isManager = (lastDigit == 0 || lastDigit == 5);
      final userRole = isManager ? 'Station Manager' : 'Station Operator';

      // Create mock user
      final user = UserModel(
        id: 'user_${widget.phoneNumber}',
        name: isManager ? 'Amit Sharma' : 'Rajesh Kumar',
        email:
            isManager ? 'amit.sharma@navswap.com' : 'rajesh.kumar@navswap.com',
        phone: '+91 ${widget.phoneNumber}',
        role: userRole,
        isVerified: true,
        isApproved: true,
        createdAt: DateTime.now(),
      );

      // Set user in provider
      ref.read(currentUserProvider.notifier).state = user;

      // Navigate based on role
      if (isManager) {
        context.go('/manager/dashboard');
      } else {
        context.go('/staff/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify OTP',
                style: Theme.of(context).textTheme.displaySmall,
              ),

              const SizedBox(height: 8),

              Text(
                'Enter the 6-digit code sent to',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 4),

              Text(
                '+91 ${widget.phoneNumber}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.gradientStart,
                    ),
              ),

              const SizedBox(height: 48),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: Theme.of(context).textTheme.headlineMedium,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppTheme.surfaceColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppTheme.gradientStart,
                            width: 2,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) => _handleOtpInput(index, value),
                      onTap: () {
                        if (_controllers[index].text.isNotEmpty) {
                          _controllers[index].selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _controllers[index].text.length,
                          );
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              if (_isLoading)
                Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(
                        color: AppTheme.gradientStart,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Verifying...',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              Center(
                child: TextButton(
                  onPressed: () {
                    // Resend OTP logic
                  },
                  child: const Text('Resend OTP'),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.darkCard,
                child: Row(
                  children: [
                    const Icon(
                      Icons.security_outlined,
                      color: AppTheme.successGreen,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Your login is secured with two-factor authentication',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
