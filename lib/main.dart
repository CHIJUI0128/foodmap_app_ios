// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Map + Image Picker',
//       home: MapWithPhotoPicker(),
//     );
//   }
// }

// class MapWithPhotoPicker extends StatefulWidget {
//   @override
//   _MapWithPhotoPickerState createState() => _MapWithPhotoPickerState();
// }

// class _MapWithPhotoPickerState extends State<MapWithPhotoPicker> {
//   late GoogleMapController mapController;
//   File? _imageFile;

//   final LatLng _center = const LatLng(24.1477, 120.6736); // 台中

//   Future<void> _pickImage() async {
//     final status = await Permission.photos.request();
//     if (!status.isGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('需要照片權限才能選取圖片')),
//       );
//       return;
//     }

//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Map + 選照片'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 14.0,
//             ),
//           ),
//           if (_imageFile != null)
//             Positioned(
//               bottom: 100,
//               left: 10,
//               right: 10,
//               child: Image.file(_imageFile!, height: 150),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickImage,
//         child: Icon(Icons.photo),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'ocr_test_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FoodMap OCR',
//       theme: ThemeData(primarySwatch: Colors.teal),
//       home: OcrTestPage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'ocr_map_page.dart'; // 如果你的檔名是這個

void main() {
  runApp(MaterialApp(
    home: OcrMapPage(),
    debugShowCheckedModeBanner: false,
  ));
}