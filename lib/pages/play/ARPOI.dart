import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/startupConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/play/question.dart';

class ArPOIWidget extends StatefulWidget {
  @override
  _ArPOIWidgetState createState() => _ArPOIWidgetState();
}

class _ArPOIWidgetState extends State<ArPOIWidget> with WidgetsBindingObserver {
  ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "cHBWfDc6QxkcDQvFW1sBVMjOFDMPh0hKO6Z3k5Yu8azOvr6puhiwR7pM17vhturOmBdgnPkkoQ6uVYjtxWnYU2o+sTTQrbCXpy1Kfzyk/1LE6UR4zuCtFRdf43FmMHNsfRr/+cwFy+y6oFUmoPWvkhGKg2mTZaqwZGiZ3gQLwHBTYWx0ZWRfXwoxiZybKkOd/4kF2++bu9aD1ZhBB7pAq3uaaufwJBRgG3flCMR0K9bAwFW0d5x1VGbzAeckY8YywVraffMXf2xm+VSg+GNaqwaIJ469K4Sc7kZVBJyloUOvZTNR36mHw56fH9x4GvDaZEsduvx3NprXP/PPPwUVtEK0lECMXzdM0+igVsE3AbeVdanlrQ9oPAlB7wx57vgfirvjAr5K/aa5t89dlA5WLkTVHCC73/3HmrS1pgYVTtBKoE09809LnQ2km6O7ZrIIe7AXfMzWD8Dh1KoFwPdTkSPYsfEQoFw/v4lm0Q0iaMl0VoUcxUm4ueOd+ulHn7KB5so6BVBp7lNptSF8nSz9GcLawc22ArHmqJr6Zer3FB4l00D0t1QI2MlRmUg3/1MboFnB5mMs4albPsHg5ZYt+vCmo5vgsYrxX276bXZ9a0somtVa+Xb8FDCgssjNbymCXbd7+u266x9Ac+jG70zo2ydCfnpdeZmVlApzig1lluqnVULxhQJJwfHtEAv8amiTujPpQ4gDE+tSWie3ppK0RSsW8WH7jNGtVtIFvYhUTaIvSfpVGX1NgzUHoOKEbqgqySGvI3C4eiT9q+FRgROaj9IZqdrhZKu/hAQg+v66OZ5YvBEL5vB1u/AGNZiZc7GK+NPw2WS7Qe2jU2csv00jVB9YHn4ittXTMz5rHlxIOy0=";
  StartupConfiguration startupConfiguration = StartupConfiguration(
      cameraPosition: CameraPosition.BACK,
      cameraResolution: CameraResolution.AUTO);
  List<String> features = ["image_tracking", "geo"];

  void onJSONObjectReceived(Map<String, dynamic> jsonObject) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionPage()),
    ).then((value) => Navigator.pop(context));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    architectWidget = new ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: startupConfiguration,
      features: this.features,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text("Find the object"),
      ),
      backgroundColor: Color(0xff21254A),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: architectWidget,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        if (this.architectWidget != null) {
          this.architectWidget.pause();
        }
        break;
      case AppLifecycleState.resumed:
        if (this.architectWidget != null) {
          this.architectWidget.resume();
        }
        break;

      default:
    }
  }

  @override
  void dispose() {
    if (this.architectWidget != null) {
      this.architectWidget.pause();
      this.architectWidget.destroy();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> onArchitectWidgetCreated() async {
    this.architectWidget.load(
        "samples/WiktitudeFunction/index.html", onLoadSuccess, onLoadFailed);
    this.architectWidget.resume();
    this.architectWidget.setJSONObjectReceivedCallback(
        (result) => onJSONObjectReceived(result));
  }

  Future<void> onLoadSuccess() async {
    debugPrint("Successfully loaded Architect World");
  }

  Future<void> onLoadFailed(String error) async {
    debugPrint("Failed to load Architect World");
    debugPrint(error);
  }
}
