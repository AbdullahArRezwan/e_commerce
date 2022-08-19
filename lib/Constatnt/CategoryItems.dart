import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// class CategoryItems extends StatelessWidget {
//   final double height,
//       width,
//       radius,
//       titleSize,
//       paddingHorizontal,
//       paddingVertical;
//   final String image, title;
//   final Color color;
//   final align, blendMode;
//
//   const CategoryItems({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.radius,
//     required this.titleSize,
//     required this.image,
//     required this.title,
//     required this.color,
//     this.align,
//     this.blendMode,
//     required this.paddingHorizontal,
//     required this.paddingVertical,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(5.w),
//       child: Stack(
//         children: [
//           Container(
//             height: height,
//             width: width,
//             child: Ink.image(
//               image: AssetImage(image),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(color, blendMode),
//               child: InkWell(
//                 onTap: () {},
//               ),
//             ),
//           ),
//           Align(
//             alignment: align,
//             child: Container(
//               height: 30.h,
//               width: 160.w,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(radius),
//               ),
//               child: Center(
//                 child: Text.rich(
//                   TextSpan(
//                       text: title,
//                       // style: TextStyle(color: Colors.white, fontSize: titleSize),
//                       style: GoogleFonts.zenKurenaido(
//                         fontStyle: FontStyle.normal,
//                         decoration: TextDecoration.none,
//                         fontSize: titleSize,
//                         fontWeight: FontWeight.w900,
//                         color: Colors.white,
//                       ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
