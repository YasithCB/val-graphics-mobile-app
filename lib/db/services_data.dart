import 'package:flutter/material.dart';

import '../models/service_item.dart';

final List<ServiceItem> SERVICES = [
  ServiceItem(
    title: 'Vehicle Branding',
    imagePath: 'assets/images/vehicle-wrapping.png',
    icon: Icons.directions_car,
  ),
  ServiceItem(
    title: 'Interior Fitouts',
    imagePath: 'assets/images/interior.png',
    icon: Icons.print,
  ),
  ServiceItem(
    title: 'Digital Printing',
    imagePath: 'assets/images/printing-services.png',
    icon: Icons.chair,
  ),
  ServiceItem(
    title: 'Billboard & Signage',
    imagePath: 'assets/images/signage-works.png',
    icon: Icons.business,
  ),
  ServiceItem(
    title: 'Digital Services',
    imagePath: 'assets/images/marketing.jpg',
    icon: Icons.computer,
  ),
];
