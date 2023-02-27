import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../core/app_colors.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            color: Colors.white,
            depth: 1,
            intensity: 5,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SingleChildScrollView(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    AutoSizeText(
                      'Brand',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Lenovo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Manufacturer',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Lenovo, MOTOROLA (WUHAN)MOBILITY TECHNOLOGIES COMMUNICATION CO LTD,NO19,GAOXIN 4TH ROAD, EAST LAKE HIGH TECH ZONE,WUHAN,HUBEI, PR CHINA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Series',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Lenovo Tab K10 FHD (10.3 inch (26.16 cm), 3GB, 32GB, LTE, Calling)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Colour',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Abyss Blue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Item Height',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '8 Millimeters',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Item Width',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '15.3 Centimeters',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Standing screen display size',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '10.3 Inches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Product Dimensions',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '24.4 x 15.3 x 0.8 cm; 460 Grams',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Batteries',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '1 Lithium Polymer batteries required. (included)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Item Weight',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '460 g',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Wireless communication technologies',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Bluetooth, WiFi Hotspot',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Connectivity technologies',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Bluetooth, WiFi Hotspot',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Special features',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Dual SIM, GPS, Music Player, Video Player, FM Radio, Accelerometer, Proximity sensor, Ambient light sensor, E-compass, Gyroscope',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Other camera features',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '1080p Full HD Recording',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Form factor',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Touchscreen Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Weight',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '460 Grams',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Colour',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Black',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Battery Power Rating',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '5000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Whats in the box',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Handset, Adapter, USB Cable, SIM Ejector Tool, Warranty Card, User Guide, Protective Case',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Model Number',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'M2004J19C',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                  TableRow(children: [
                    AutoSizeText(
                      'Model Name',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Redmi Note 9 Pro',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 4,
                    ),
                  ]),
                  const TableRow(children: [
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
