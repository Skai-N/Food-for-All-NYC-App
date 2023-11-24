import 'organization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'needExistList.dart';


final containerDecor = BoxDecoration(
  border: Border.all(
    color: Colors.black,
    width: 2,
  ), // Thicker black border
  borderRadius: BorderRadius.circular(10), // Increased border radius
);

class SelectionHaveFormPage extends StatefulWidget {
  final String? selectedValue;

  const SelectionHaveFormPage({Key? key, this.selectedValue}) : super(key: key);

  @override
  State<SelectionHaveFormPage> createState() => SelectionHaveFormPageState();
}

class SelectionHaveFormPageState extends State<SelectionHaveFormPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
            color: const Color.fromRGBO(72, 164, 244, 1),
          ),
          elevation: 0,
        ),

        body: Center(
          child: Column(
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const existingListings(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        children: [
                          Text(
                              'See existing listings',
                              style: mainFont.copyWith(fontSize: 20)
                          ),
                          Text(
                              'from organizations with surplus food',
                              style: mainFont.copyWith(fontSize: 12)
                          )
                        ]
                    )
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const organizationFormPage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:15, horizontal: 1),
                    child: Column(
                        children: [
                          Text(
                              'Create new listing',
                              style: mainFont.copyWith(fontSize: 20)
                          ),
                          Text(
                              'for organizations with surplus food to see',
                              style: mainFont.copyWith(fontSize: 12)
                          )
                        ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
