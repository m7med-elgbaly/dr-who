import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalDetail_Ar extends StatefulWidget {
  final String medical;
  const MedicalDetail_Ar({Key? key, required this.medical}) : super(key: key);

  @override
  State<MedicalDetail_Ar> createState() => _MedicalDetail_ArState();
}

class _MedicalDetail_ArState extends State<MedicalDetail_Ar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.medical,
          style: GoogleFonts.lato(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('medical_ar')
                .orderBy('name')
                .startAt([widget.medical]).endAt(
                    [widget.medical + '\uf8ff']).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                  physics: const ClampingScrollPhysics(),
                  children: snapshot.data!.docs.map((document) {
                    var size = MediaQuery.of(context).size;
                    return SingleChildScrollView(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  filterQuality: FilterQuality.high,
                                  image: NetworkImage(
                                    document['image'],
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: size.height * 0.45),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                        child: Container(
                                          width: 150,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.red[50],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              document['description'],
                                              style: GoogleFonts.lato(
                                                  color: Colors.black54,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))),
                        ],
                      ),
                    );
                  }).toList());
            }),
      ),
    );
  }
}
