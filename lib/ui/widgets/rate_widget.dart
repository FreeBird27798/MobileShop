// import 'package:connect_store/models/product.dart';
// import 'package:connect_store/ui/widgets/star.dart';
// import 'package:flutter/material.dart';
//
// class RateWidget extends StatelessWidget {
//   late double val;
//   late double val_01;
//   late double val_02;
//   late double val_03;
//   late double val_04;
//   late double val_05;
//   RateWidget({
//     required this.val
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     val_01 = val == 0.5 || val == 1 ? val : 0;
//     val_02 = val == 1.5 || val == 2 ? val : 0;
//     val_03 = val == 2.5 || val == 3 ? val : 0;
//     val_04 = val == 3.5 || val == 4 ? val : 0;
//     val_05 = val == 4.5 || val == 5 ? val : 0;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Star(
//           // onPressed: () {},
//           val: val_01,
//           isRated: val >= 0.5,
//         ),
//         Star(
//           // onPressed: () {},
//           val: val_02,
//           isRated: val >= 1.5,
//         ),
//         Star(
//           // onPressed: () {},
//           val: val_03,
//           isRated: val >= 2.5,
//         ),
//         Star(
//           // onPressed: () {},
//           val: val_04,
//           isRated: val >= 3.5,
//         ),
//         Star(
//           // onPressed: () {},
//           val: val_05,
//           isRated: val >= 4.5,
//         ),
//       ],
//     );
//   }
// }
