import 'package:flutter/material.dart';

class LandscapeHomeLayout extends StatelessWidget {
  const LandscapeHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 15, bottom: 30),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Icon(
                                  Icons.qr_code_scanner,
                                  size: 150,
                                  color: Theme.of(context).focusColor,
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  alignment: Alignment.bottomRight,
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.black87,
                                    child: Icon(
                                      Icons.camera,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Scan',
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 15, right: 30, bottom: 30),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 150,
                                  color: Theme.of(context).focusColor,
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  alignment: Alignment.bottomRight,
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.black87,
                                    child: Icon(
                                      Icons.add,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Create',
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}