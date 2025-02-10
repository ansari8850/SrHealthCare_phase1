import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // Helper function to format the card number for display as "1234 xxxx 5678"
  String formatCardNumber(String input) {
    // Remove any spaces.
    String digits = input.replaceAll(' ', '');
    if (digits.length != 16) return input; // fallback if not exactly 16 digits.
    String first4 = digits.substring(0, 4);
    String last4 = digits.substring(12, 16);
    return '$first4 xxxx $last4';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey.withOpacity(.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: 'Add Card',
                    size: 24,
                    color: blackColor,
                    weight: FontWeight.w700),
                Text("Card Holder Name"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardHolderController,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    // Allow only alphabets and spaces.
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter card holder name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card holder name';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Only alphabets and spaces are allowed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Card Number
                Text("Card Number"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // Only allow digits.
                    FilteringTextInputFormatter.digitsOnly,
                    // Limit to 16 digits (raw count without spaces).
                    LengthLimitingTextInputFormatter(16),
                    // Custom formatter that inserts a space after every 4 digits.
                    CardNumberInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter card number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number';
                    }
                    // Remove spaces and check that the card number is exactly 16 digits.
                    String digits = value.replaceAll(' ', '');
                    if (digits.length != 16) {
                      return 'Card number must be 16 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Card Holder Name

                // Expiry Date and CVV
                Row(
                  children: [
                    // Expiry Date Field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Expiry Date"),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _expiryController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              ExpiryDateInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter expiry date';
                              }
                              // Validate format MM/YY (month between 01 and 12)
                              if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                                  .hasMatch(value)) {
                                return 'Expiry date must be in MM/YY format';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // CVV Field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CVV"),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              hintText: 'CVV',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter CVV';
                              }
                              if (value.length != 3) {
                                return 'CVV must be 3 digits';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Add Card Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Reformat the card number for display (e.g., "1234 xxxx 5678")
                        String formattedCardNumber =
                            formatCardNumber(_cardNumberController.text);
                        final newCard = {
                          'cardType':
                              null, // You may pass the selected card type here.
                          'cardNumber': formattedCardNumber,
                          'cardHolder': _cardHolderController.text,
                          'expiry': _expiryController.text,
                          'cvv': _cvvController.text,
                        };
                        Get.back(result: newCard);
                      }
                    },
                    child: CustomText(
                      text: 'Add Card',
                      size: 16,
                      color: whiteColor,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Input Formatter for Card Number
/// Inserts a space after every 4 digits.
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all spaces.
    String digits = newValue.text.replaceAll(' ', '');
    // Limit to 16 digits.
    if (digits.length > 16) {
      digits = digits.substring(0, 16);
    }
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      // Insert a space after every 4 digits if not the end.
      if ((i + 1) % 4 == 0 && i + 1 != digits.length) {
        buffer.write(' ');
      }
    }
    final String formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Custom Input Formatter for Expiry Date
/// Automatically inserts a slash after the month digits.
class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any existing slash.
    String digits = newValue.text.replaceAll('/', '');
    // Limit to 4 digits.
    if (digits.length > 4) {
      digits = digits.substring(0, 4);
    }
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(digits[i]);
    }
    final String formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
