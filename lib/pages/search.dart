import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minHeight: 56.0,
                  maxWidth: 300.0,
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4)),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('trackinfo')
                        .snapshots(),
                    builder: (context, snapshot) {
                      var _carnumber;

                      return DropdownButton(
                        value: _carnumber,
                        onChanged: (valueSelectedByUser) {
                          _carnumber = valueSelectedByUser;
                        },
                        hint: Text('トラックを選択'),
                        items: snapshot.data?.docs
                            .map((DocumentSnapshot document) {
                          return DropdownMenuItem<String>(
                            value: document.id,
                            child: Text(document.id),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
