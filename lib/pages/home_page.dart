import 'package:do_it/model/vocabset_model.dart';
import 'package:do_it/network/vocabset_network.dart';
import 'package:do_it/pages/vocab_set_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<VocabSet> vocabSetData = [];
  bool isLoading  = false;
  Color mainColor = Color(0xFF21B6A8);
  Color blackColor = Color(0xFF2B2B2B);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading  = true;
    });
    VocabSetNetworkRequest.fetchVocabSet().then((dataFromServer) {
      setState(() {
        vocabSetData = dataFromServer.toList();
      });
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        isLoading 
        ? 
        Center(child: CircularProgressIndicator(),) 
        :
        Container(
          decoration: BoxDecoration(
            // color: Color.fromARGB(74, 170, 171, 172),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(21),
              topRight: Radius.circular(21)
            )
            ),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
          children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "CATEGORY",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2B2B2B)),
              textAlign: TextAlign.left,
            ),
          ),
        
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: vocabSetData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white)
                            ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VocabSetPage(
                                          vocabSetID: vocabSetData[index].id.toString(), 
                                          vocabSetName: vocabSetData[index].nickname.toString(),
                                          ),
                                          ),
                                          );
                              },
                              child: Text(
                                vocabSetData[index].nickname.toString(),
                                style: TextStyle(fontSize: 18, color: blackColor),
                              )),
                        )),
                  );
                }),
          )
              ]),
            ),
        ));
  }
}
