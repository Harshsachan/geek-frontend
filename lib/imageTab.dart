import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'flutterFlow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'flutterFlow/flutter_flow_theme.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  File? selectedImage;
  bool isLoading = false;
  Future<void> _uploadImage() async {
    if (selectedImage == null) {
      Fluttertoast.showToast(
        msg: "Please select an image to upload",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final url =
    Uri.parse("https://b379-2401-4900-1c0e-8fff-00-d3-b0e2.ngrok-free.app/image/upload");

    // Create a multipart request
    final request = http.MultipartRequest('POST', url);

    // Attach the image file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      selectedImage!.path,
    ));

    // Send the request
    final response = await request.send();
    print("response");
    print(response);
    print(response.statusCode);
    if (response.statusCode == 201) {
      // Successful upload
      Fluttertoast.showToast(
        msg: "Image uploaded successfully",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      _fetchImageLinks();
    } else {
      // Handle error here
      Fluttertoast.showToast(
        msg: "Failed to upload image",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _pickImage() async {
    print("Came");
    try {
      print("trying");
      final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      print('${imageFile!.path}');
      if (imageFile == null) return;

      setState(() {
        selectedImage = File(imageFile.path);
      });
      print("pick Images Done");
    } on PlatformException catch (e) {
      print("Image picker error: $e");
    }
    print("pick Image");
  }
  List<String> imageLinks = [];

  @override
  void initState() {
    super.initState();
    // Fetch image links from the API
    _fetchImageLinks();
  }

  Future<void> _fetchImageLinks() async {
    setState(() {
      isLoading = true; // Set isLoading to true while fetching images
    });
    final url =
    Uri.parse("https://b379-2401-4900-1c0e-8fff-00-d3-b0e2.ngrok-free.app/image/links");
    final response = await http.get(url);

    if (response.statusCode == 200) {

      // Successful response
      final List<dynamic> data = jsonDecode(response.body);
      final List<String> links = data.cast<String>();
      setState(() {
        imageLinks = links;
        isLoading = false;
      });
    } else {
      // Handle error here
      print("Failed to fetch image links");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: AutoSizeText(
          'All Images',
          style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading?Center(child: CircularProgressIndicator()):Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 1.0,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: imageLinks.length,
                itemBuilder: (context, index) {
                  final fileName = imageLinks[index];
                  final imageUrl =
                      "https://b379-2401-4900-1c0e-8fff-00-d3-b0e2.ngrok-free.app/image/images/$fileName";

                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.zero,
                  elevation: 4,
                  side: const BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.070,
                  alignment: Alignment.center,
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  _uploadImage();
                  // setState(() {
                  //
                  // });
                  // _reloadPage();
                  print('Uploading Images pressed ...');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B39EF),
                  padding: EdgeInsets.zero,
                  elevation: 4,
                  side: const BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.070,
                  alignment: Alignment.center,
                  child: Text(
                    'Upload images',
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
