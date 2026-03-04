import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedRole = 'operator'; // 'operator' or 'manager'

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        context.push('/otp', extra: {
          'phone': _phoneController.text,
          'role': _selectedRole,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.darkBackground,
                AppTheme.darkBackground.withOpacity(0.95),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Logo/Header Section
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.gradientStart,
                            AppTheme.gradientEnd
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.gradientStart.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Image.asset(
                              'assets/icons/LogoBackgroundRemoved.png',
                              color: Colors.white,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NAVSWAP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Power your journey',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white.withOpacity(0.95),
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppTheme.gradientStart,
                                AppTheme.gradientEnd
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Select your role and enter your mobile number',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Role Selector
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppTheme.gradientStart,
                                      AppTheme.gradientEnd
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.badge_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Select Your Role',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(
                                      () => _selectedRole = 'operator'),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      gradient: _selectedRole == 'operator'
                                          ? const LinearGradient(
                                              colors: [
                                                AppTheme.gradientStart,
                                                AppTheme.gradientEnd
                                              ],
                                            )
                                          : null,
                                      color: _selectedRole != 'operator'
                                          ? AppTheme.cardBackground
                                          : null,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _selectedRole == 'operator'
                                            ? Colors.transparent
                                            : AppTheme.textSecondary
                                                .withOpacity(0.3),
                                        width: 2,
                                      ),
                                      boxShadow: _selectedRole == 'operator'
                                          ? [
                                              BoxShadow(
                                                color: AppTheme.gradientStart
                                                    .withOpacity(0.4),
                                                blurRadius: 15,
                                                offset: const Offset(0, 5),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.person_outline_rounded,
                                          color: _selectedRole == 'operator'
                                              ? Colors.white
                                              : AppTheme.textSecondary,
                                          size: 40,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Station\nOperator',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: _selectedRole == 'operator'
                                                ? Colors.white
                                                : AppTheme.textSecondary,
                                            fontWeight:
                                                _selectedRole == 'operator'
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedRole = 'manager'),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      gradient: _selectedRole == 'manager'
                                          ? const LinearGradient(
                                              colors: [
                                                AppTheme.gradientStart,
                                                AppTheme.gradientEnd
                                              ],
                                            )
                                          : null,
                                      color: _selectedRole != 'manager'
                                          ? AppTheme.cardBackground
                                          : null,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _selectedRole == 'manager'
                                            ? Colors.transparent
                                            : AppTheme.textSecondary
                                                .withOpacity(0.3),
                                        width: 2,
                                      ),
                                      boxShadow: _selectedRole == 'manager'
                                          ? [
                                              BoxShadow(
                                                color: AppTheme.gradientStart
                                                    .withOpacity(0.4),
                                                blurRadius: 15,
                                                offset: const Offset(0, 5),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.admin_panel_settings_outlined,
                                          color: _selectedRole == 'manager'
                                              ? Colors.white
                                              : AppTheme.textSecondary,
                                          size: 40,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Station\nManager',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: _selectedRole == 'manager'
                                                ? Colors.white
                                                : AppTheme.textSecondary,
                                            fontWeight:
                                                _selectedRole == 'manager'
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Phone Number Input
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.surfaceColor.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter 10-digit mobile number',
                          prefixIcon: Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppTheme.gradientStart,
                                  AppTheme.gradientEnd
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.phone_android_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          filled: true,
                          fillColor: AppTheme.surfaceColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppTheme.surfaceColor.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppTheme.gradientStart,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppTheme.criticalRed,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppTheme.criticalRed,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          }
                          if (value.length != 10) {
                            return 'Please enter valid 10-digit number';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Login Button
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.gradientStart,
                            AppTheme.gradientEnd
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.gradientStart.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Get OTP',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Info Cards
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.infoBlue.withOpacity(0.1),
                            AppTheme.infoBlue.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.infoBlue.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.infoBlue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.verified_user_outlined,
                              color: AppTheme.infoBlue,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Authorized Access Only',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.infoBlue,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'This portal is exclusively for verified station personnel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.help_outline_rounded,
                                color: AppTheme.textSecondary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Need Help?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.support_agent_rounded,
                              size: 20,
                            ),
                            label: const Text(
                              'Contact Administrator',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
