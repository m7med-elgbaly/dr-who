import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  final String disease;
  const Detail({required this.disease});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.disease,
          style: GoogleFonts.lato(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('disease')
                .orderBy('name')
                .startAt([widget.disease]).endAt(
                    [widget.disease + '\uf8ff']).snapshots(),
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
                                    document['Image'],
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
                                              document['Description'],
                                              style: GoogleFonts.lato(
                                                  color: Colors.black54,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'How does it spread?',
                                              style: GoogleFonts.lato(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              document['Spread'],
                                              style: GoogleFonts.lato(
                                                color: Colors.black54,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Symtomps',
                                              style: GoogleFonts.lato(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              document['Symtomps'],
                                              style: GoogleFonts.lato(
                                                color: Colors.black54,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Warning Signs',
                                              style: GoogleFonts.lato(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              document['Warning'],
                                              style: GoogleFonts.lato(
                                                color: Colors.black54,
                                                fontSize: 18,
                                              ),
                                            )
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