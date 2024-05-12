import 'package:flutter/material.dart';
import 'package:krishi_sahayak/providers/feild_measurment_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';

class FeildMeasurmentScreen extends StatefulWidget {
  const FeildMeasurmentScreen({super.key});

  @override
  State<FeildMeasurmentScreen> createState() => _FeildMeasurmentScreenState();
}

class _FeildMeasurmentScreenState extends State<FeildMeasurmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FeildMeasurmentProvider>(
      builder: (context, feildProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Feild Measurment"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                feildProvider.clearPoints();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Note*\n1. Start at the corder of your feild.\n2. Use 'Add current position' to add feild marks for measurment\n3. This is an approximate conversion factor\n",
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: feildProvider.points.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      surfaceTintColor: Colors.transparent,
                      child: ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(
                            "Latitude: ${feildProvider.points[index].latitude.toStringAsFixed(3)} - Longitude: ${feildProvider.points[index].longitude.toStringAsFixed(3)}"),
                        trailing: IconButton(
                            onPressed: () {
                              feildProvider.removePoint(index);
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  title: "Add current position",
                  isLoading: feildProvider.isLoading,
                  callBack: () {
                    feildProvider.addPoint();
                  },
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  title: "Measure Area",
                  isLoading: false,
                  callBack: () {
                    feildProvider.measureFeild();
                  },
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Table(
                  children: [
                    const TableRow(
                      children: [
                        Center(
                            child: Text(
                          "Acre",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Center(
                            child: Text(
                          "Hectare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Center(
                            child: Text(
                          "Bigha",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Center(
                            child: Text(
                          "Square Foot",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Center(
                            child: Text(
                          "Square Meter",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    TableRow(
                      children: [
                        Center(child: Text(feildProvider.acre.toString())),
                        Center(child: Text(feildProvider.hectare.toString())),
                        Center(child: Text(feildProvider.bigha.toString())),
                        Center(
                            child: Text(feildProvider.squareFoot.toString())),
                        Center(
                            child: Text(
                                feildProvider.areaInSquareMeters.toString())),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
