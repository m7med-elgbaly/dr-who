import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heathly/firestore-data/firebase.dart';
import 'package:heathly/screens/medicaldetail.dart';
import 'package:heathly/screens/screen_ar/medicaldetail.dart';

class Medical_Ar extends StatefulWidget {
  const Medical_Ar({Key? key}) : super(key: key);

  @override
  State<Medical_Ar> createState() => _Medical_ArState();
}

class _Medical_ArState extends State<Medical_Ar> {
  @override
  void initState() {
    super.initState();
  }

  Future scanBarcodeNormal() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.BARCODE)
          .then((String barcodeScanRes) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScanBarcode(barcodeKey: barcodeScanRes)));
        print(barcodeScanRes);
      });
    } on PlatformException {
      return 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'الأدوية',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('medical_ar')
                    .orderBy('name')
                    .startAt(['']).endAt(['' + '\uf8ff']).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot medical = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Card(
                              color: Colors.blue[50],
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 8,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MedicalDetail_Ar(
                                          medical: medical['name'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(medical['image']),
                                        //backgroundColor: Colors.blue,
                                        radius: 35,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              medical['name'],
                                              style: GoogleFonts.lato(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              medical['description'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: GoogleFonts.lato(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 16,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                alignment: Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                        child: const Icon(Icons.search_sharp),
                        onPressed: () {
                          scanBarcodeNormal();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
