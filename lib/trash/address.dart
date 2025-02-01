// import 'package:flutter/material.dart';
// import 'package:country_state_city_picker/country_state_city_picker.dart';
// import 'package:sr_health_care/const/colors.dart';

// class AddressDetailsForm extends StatefulWidget {
//   @override
//   _AddressDetailsFormState createState() => _AddressDetailsFormState();
// }

// class _AddressDetailsFormState extends State<AddressDetailsForm> {
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       // appBar: AppBar(
//       //   title: Text('Address Details'),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
            

//             SelectState(
            
//               dropdownColor: Colors.white, 
//               style: TextStyle(
//                 fontSize: 14,             
//               ),
//               onCountryChanged: (value) {

//                 setState(() {
//                   selectedCountry = value;
//                 });
//               },
//               onStateChanged: (value) {
//                 setState(() {
//                   selectedState = value;
//                 });
//               },
//               onCityChanged: (value) {
//                 setState(() {
//                   selectedCity = value;
//                 });
//               },
//             ),

//             SizedBox(height: 20),
            
          
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: AddressDetailsForm(),
//   ));
// }
