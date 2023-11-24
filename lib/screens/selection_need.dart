import 'organization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'needExistList.dart';

final hintFont = GoogleFonts.poiretOne(
  color: const Color.fromARGB(255, 101, 101, 101),
  fontWeight: FontWeight.w800,
  letterSpacing: 1,
);
final mainFont = GoogleFonts.poiretOne(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontSize: 20,
  letterSpacing: 1,
);
final containerDecor = BoxDecoration(
  border: Border.all(
    color: Colors.black,
    width: 2,
  ), // Thicker black border
  borderRadius: BorderRadius.circular(10), // Increased border radius
);

class SelectionFormPage extends StatefulWidget {
  final String? selectedValue;

  const SelectionFormPage({Key? key, this.selectedValue}) : super(key: key);

  @override
  State<SelectionFormPage> createState() => _SelectionFormPageState();
}

class _SelectionFormPageState extends State<SelectionFormPage> {
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
                        'from organizations in need of more food',
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
                        'for organizations in need of more food to see',
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
