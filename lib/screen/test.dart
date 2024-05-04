import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'File Upload Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileUploadScreen(),
    );
  }
}

class FileUploadController extends GetxController {
  var files = <PlatformFile>[].obs;

  void addFiles(List<PlatformFile> newFiles) {
    files.addAll(newFiles);
  }
}

class FileUploadScreen extends StatelessWidget {
  final FileUploadController fileUploadController = Get.put(FileUploadController());

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        fileUploadController.addFiles(result.files);
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }
  void _deleteFile(int index) {
    fileUploadController.files.removeAt(index);
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
              Obx(
                    () => GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: fileUploadController.files.length,
                  itemBuilder: (context, index) {
                    var file = fileUploadController.files[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPdfScreen(pdfPath: file.path!),
                          ),
                        );
                      },
                      child: GridTile(
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: file.path?.toLowerCase()?.endsWith('.pdf') ?? false
                                    ? PDFView(
                                  filePath: file.path!,
                                )
                                    : Image.memory(
                                  file.bytes!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              file.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _deleteFile(index);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
