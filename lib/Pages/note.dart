import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps/google_maps.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:uber_clone/Pages/history.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final RateMyApp rateMyApp = RateMyApp(
    minDays: 0,
    minLaunches: 1,
    appStoreIdentifier: '',
    googlePlayIdentifier: '',
  );

  @override
  void iniState() {
    rateMyApp.init().then((_) => {
          if (rateMyApp.shouldOpenDialog)
            {
              rateMyApp.showStarRateDialog(
                context,
                title: "Notez votre voyage",
                message:
                    "Si vous etiez satisfait de ce voyage, s'il vous palait veuillez noter le",
                actionsBuilder: (context, stars) {
                  return [
                    TextButton(
                        onPressed: () async {
                          stars = stars ?? 0;
                          print("Merci d'avoir noter votre voyage");
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.black),
                        ))
                  ];
                },
                dialogStyle: const DialogStyle(
                  titleStyle: TextStyle(
                    color: Colors.black,
                  ),
                  titleAlign: TextAlign.center,
                  messageAlign: TextAlign.center,
                  messagePadding: EdgeInsets.all(20),
                ),
                starRatingOptions: const StarRatingOptions(),
                onDismissed: () => {
                  rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
                },
                ignoreNativeDialog: true,
              ),
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text(
          "Notes",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const HistoryPage()));
          },
        ),
      ),
      body: Center(),
    );
  }
}
