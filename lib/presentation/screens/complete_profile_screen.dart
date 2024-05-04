import 'package:e_commerce_1/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key,});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _firstNameTEController = TextEditingController();
  final _lastNameTEController = TextEditingController();
  final _mobileTEController = TextEditingController();
  final _cityTEController = TextEditingController();
  final _shippingAddressTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme= Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80,),
                const AppLogo(),
                const SizedBox(height: 16,),
                Text("Complete Profile",style: textTheme.headlineLarge),
                const SizedBox(height: 4,),
                Text("Get started with us with your details",style: textTheme.headlineSmall),
                const SizedBox(height: 24,),
                _buildProfileForm(), // method extraction
                const SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: (){},
                  child:const Text('Complete'),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _buildProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(
              hintText: 'first Name',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(
              hintText: 'last Name',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _mobileTEController,
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _cityTEController,
            decoration: const InputDecoration(
              hintText: 'City',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _shippingAddressTEController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Shipping Address',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    //_formKey dispose(); ? --------------------------
    super.dispose();
  }
}

// 56:30
