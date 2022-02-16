import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_text/pdf_text.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tts/tts.dart';
import 'package:tts/viewpdf.dart';

class DownloadPDF extends StatefulWidget {
  const DownloadPDF({Key? key}) : super(key: key);

  @override
  _DownloadPDFState createState() => _DownloadPDFState();
}

class _DownloadPDFState extends State<DownloadPDF> {
  late PdfViewerController _pdfViewerController;

  PDFDoc? _pdfDoc;

  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  var sub;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;
  var files;
  late File file;
  bool showCard = false;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.zoomLevel = 3;
    _pdfViewerController.pageNumber.isEven;
    initTts();
  }

  initTts() async {
    flutterTts = FlutterTts();

    flutterTts.setLanguage("hi");

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        log("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        log("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        log("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          log("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          log("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        log("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  final imgUrl =
      "https://ia904608.us.archive.org/4/items/life-earth-h/LIFE%20%20EARTH%20-%20H.pdf";

  var dio = Dio();

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      setState(() {});
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        debugPrint((received / total * 100).toStringAsFixed(0) + "%");
        sub = (received / total * 100).toStringAsFixed(0) + "%";
      });

      if (sub != 100) {
        const CircularProgressIndicator();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_outlined)),
        title: const Text('PDF View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (sub != null) ? Text("$sub") : Container(),
          ElevatedButton.icon(
              onPressed: () async {
                // String path =
                //     await ExternalPath.getExternalStoragePublicDirectory(
                //         ExternalPath.DIRECTORY_DOWNLOADS);
                // String fullPath = "$path/newtask1.pdf";
                String fullPath = "/storage/emulated/0/Download/newtask1.pdf";
                download2(dio, imgUrl, fullPath);
                showDownloadProgress;
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text("Download")),
          ElevatedButton.icon(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  setState(() {
                    showCard = true;
                    file = File(result.files.single.path.toString());
                  });
                } else {
                  // User canceled the picker
                }
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("FilePicker")),
          showCard ? Card(
            child: ListTile(
              title: Text("file"),
              leading: const Icon(Icons.picture_as_pdf),
              trailing: const Icon(
                Icons.arrow_forward,
                color: Colors.redAccent,
              ),
              onTap: () {
                print("file------------------------");
                print(file);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPDF(
                      downloadPdf: file,
                    ),
                  ),
                );
              },
            ),
          ) : Container(),
        ],
      ),
    );
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      log(engine);
    }
  }

  /// Reads a random page of the document
  Future _readRandomPage() async {
    log("Read Page Function Called!!");

    //Display the text.
    //_showResult(text);

    _pdfDoc = await PDFDoc.fromURL(
        "https://ia904608.us.archive.org/4/items/life-earth-h/LIFE%20%20EARTH%20-%20H.pdf");

    log("PDF is non null!!");

    _pdfViewerController.jumpToPage(10);

    /* String text =
        await _pdfDoc!.pageAt(Random().nextInt(_pdfDoc!.length) + 1).text; */
    String text = await _pdfDoc!.pageAt(10).text;

    log("Text Which we have to Read : $text\n");

    speak(text);
  }

  Future speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    log(directory.path);
    return directory.path;
  }
}
