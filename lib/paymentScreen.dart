import 'package:flutter/material.dart';


class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  _StripePaymentScreenState createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  int _currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  void _submitPayment() {
    // Implement payment processing logic here
    // This is a placeholder for demonstration purposes
    print("Payment submitted!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Payment'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        steps: [
          Step(
            title: Text('Card Information'),
            isActive: _currentStep >= 0,
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Card Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid card number';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Expiry'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid expiry';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'CVV'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text('Review Payment'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                Text('Card Number: ${_cardNumberController.text}'),
                Text('Expiry: ${_expiryController.text}'),
                Text('CVV: ${_cvvController.text}'),
              ],
            ),
          ),
          Step(
            title: Text('Confirmation'),
            isActive: _currentStep >= 2,
            content: Column(
              children: [
                Text('Confirm payment details.'),
                ElevatedButton(
                  onPressed: _submitPayment,
                  child: Text('Submit Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
