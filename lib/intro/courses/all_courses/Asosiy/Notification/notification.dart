import 'package:flutter/material.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';


class Notificationlar extends StatelessWidget {
  const Notificationlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Padding(
          padding: EdgeInsets.only(left: 55.0),
          child: Text("Bildirishnomalar"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 15),
                          Image.network("https://picsum.photos/250?image=9"),
                          SizedBox(height: 15),
                          Text('Test rejimida', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(height: 15),
                          Text('09.02.2023, 18:24', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                          SizedBox(height: 15),
                          Text(
                            "Prepared by experienced English teachers, the texts, articles and conversations...",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(height: 100),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: AppColors.bar_color,
                            ),
                            child: SizedBox(
                              width: 330.0,
                              height: 40,
                              child: Center(
                                child: Text('Yaxshi'),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    )

                  ),
                );
              },
            );
          },
          child:ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Text(
                    'Texniki ishlar $index', // Use the index to make each item unique
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    '09.02.2023, 18:24',
                  ),
                ),
              );
            },
          )


      ),
    );}
}
