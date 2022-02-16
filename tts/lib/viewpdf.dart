import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_text/pdf_text.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show consolidateHttpClientResponseBytes, kIsWeb;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tts/tts.dart';

class ViewPDF extends StatefulWidget {
  File downloadPdf;
  ViewPDF({Key? key, required this.downloadPdf}) : super(key: key);

  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  late PdfViewerController _pdfViewerController;

  late PDFDoc _pdfDoc;

  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  int currentPageNumber = 1;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.zoomLevel = 3;
    _pdfViewerController.pageNumber.isEven;
    initTts();
/*
    var path = localFile;
    log("\n***** PATH : $path *****\n");
      final filePath = downloadFile(
        dir: "$path",
        fileName: "data1.pdf",
        url:
            "https://ia904608.us.archive.org/4/items/life-earth-h/LIFE%20%20EARTH%20-%20H.pdf");

    log("\n***** FILE PATH 2 : $filePath *****\n"); */
  }

  initTts() async {
    /*  _pdfDoc = await PDFDoc.fromURL(
        "https://ia904608.us.archive.org/4/items/life-earth-h/LIFE%20%20EARTH%20-%20H.pdf"); */

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

    flutterTts.setErrorHandler((msg) {
      setState(() {
        log("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
    _readRandomPage(currentPageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: currentPageNumber == 1 ? Colors.grey : Colors.blue,
                onPressed: () {
                  if(currentPageNumber == 1){

                  }else{
                    if (currentPageNumber != 0) {
                    currentPageNumber = currentPageNumber - 1;

                    _pdfViewerController.jumpToPage(currentPageNumber);

                    log("\n Changed Page 1 : $currentPageNumber\n");
                    // flutterTts.setPauseHandler(() {
                    //   setState(() {
                    //     log("Paused");
                    //     ttsState = TtsState.paused;
                    //   });
                    // });
                    //_readRandomPage(currentPageNumber);
                    cancel();
                  _readRandomPage(currentPageNumber);
                  }
                  }
                  
                },
                // child: const Icon(Icons.exposure_minus_1),
                child: const Text("Prev",
                style: TextStyle(fontSize:12),),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                int lastPage = _pdfViewerController.pageCount;
                log("\nPage Count : $lastPage\n");

                currentPageNumber = currentPageNumber + 1;

                _pdfViewerController.jumpToPage(currentPageNumber);

                log("\n Changed Page 2 : $currentPageNumber\n");
                // if (currentPageNumber <= 17) {
                //   // flutterTts.setPauseHandler(() {
                //   //   setState(() {
                //   //     log("Paused");
                //   //     ttsState = TtsState.paused;
                //   //   });
                //   // });
                //   cancel();
                //   _readRandomPage(currentPageNumber);
                // }
                // cancel();
                  cancel();
                  _readRandomPage(currentPageNumber);
              },
              // child: const Icon(Icons.plus_one),
              child: const Text("Next",
              style: TextStyle(fontSize:12),),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            cancel();
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: const Text('PDF View'),
      ),
      body: SfPdfViewer.file(
        widget.downloadPdf,
        //'http://ebooks.syncfusion.com/downloads/flutter-succinctly/flutter-succinctly.pdf',
        controller: _pdfViewerController,
        onPageChanged: (details) {
          setState(() {
            int lastPage = _pdfViewerController.pageCount;
            log("\nPage Count : $lastPage\n");
            log("\n Changed Page 3 : ${details.newPageNumber}\n");
            currentPageNumber = details.newPageNumber;
            print("currentPageNumber----------------------");
            print(currentPageNumber);
            _readRandomPage(currentPageNumber);
          });
        },
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

  void complete() {
    flutterTts.setCompletionHandler(() {
      setState(() {
        log("Complete");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future cancel() async {
    await flutterTts.stop();
    flutterTts.setCancelHandler(() {
      setState(() {
        log("Cancel");
        ttsState = TtsState.stopped;
      });
    });
  }

  void pause() {
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
  }

  /// Reads a random page of the document
  Future _readRandomPage(int pageNumber) async {
    log("Read Page Function Called!!");

    // cancel();

    // _pdfDoc = await PDFDoc.fromURL(
    //     "https://ia904608.us.archive.org/4/items/life-earth-h/LIFE%20%20EARTH%20-%20H.pdf");
    _pdfDoc = await PDFDoc.fromFile(
         widget.downloadPdf);
        

    String text = await _pdfDoc.pageAt(pageNumber).text;

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

  Future<File> get localFile async {
    final path = await _localPath;

    return File(path);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    log(directory.path);
    return directory.path;
  }
}
