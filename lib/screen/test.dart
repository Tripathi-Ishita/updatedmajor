import "dart:io";
import 'package:flutter_pdfview/flutter_pdfview.dart';

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";
import 'package:file_picker/file_picker.dart';

class MedDocs extends StatefulWidget {
  const MedDocs({super.key});

  @override
  State<MedDocs> createState() => _MedDocsState();
}

class _MedDocsState extends State<MedDocs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileUploadScreen(),
    );
    // Scaffold(
  }
}

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  List<PlatformFile> _files = [];

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _files.addAll(result.files);
        });
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

            children: [
              ElevatedButton(
                onPressed: _pickFiles,
                child: Text('Select Files'),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: _files.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new screen to display the PDF in full
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullPdfScreen(pdfPath: _files[index].path!),
                        ),
                      );
                    },
                    child: GridTile(
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height*0.18,
                              // Adjust the height as needed
                              width: MediaQuery.of(context).size.width*0.4, // Adjust the width as needed
                              child: _files[index].path?.toLowerCase()?.endsWith('.pdf') ?? false
                                  ? PDFView(
                                filePath: _files[index].path!,
                              )
                                  : Image.memory(
                                _files[index].bytes!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10), // Add spacing between PDF and text
                          Text(
                            _files[index].name, // Display the file name below the PDF
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class FullPdfScreen extends StatelessWidget {
  final String pdfPath;

  const FullPdfScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full PDF View'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
