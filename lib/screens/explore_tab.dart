import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/services_data.dart';
import 'package:val_graphics_mobile_app/models/service_model.dart';
import 'package:val_graphics_mobile_app/widgets/service_card.dart';

import '../db/constants.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final TextEditingController _controller = TextEditingController();

  List<ServiceModel> _results = [];

  void _search() {
    String query = _controller.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _results.clear();
      } else {
        _results = servicesList
            .where((item) => item.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ServiceModel> itemsToShow =
        _results.isEmpty && _controller.text.isEmpty
        ? servicesList // default popular services
        : _results;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Modern Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Search services...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.clear();
                                    _results.clear(); // 🔹 show default again
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      // 🔹 Run search as user types
                      onChanged: (_) => _search(),
                      // still works with "enter"
                      onSubmitted: (_) => _search(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE81564),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: _search,
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔹 Section Title
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // default color for rest
                  ),
                  children: [
                    TextSpan(
                      text: _controller.text.isEmpty ? "Popular " : "Search ",
                      style: TextStyle(
                        color:
                            primaryColor, // 🔹 only "Explore" in primary color
                      ),
                    ),
                    TextSpan(
                      text: _controller.text.isEmpty
                          ? "services these days"
                          : "results",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Services List
              Expanded(
                child: itemsToShow.isEmpty
                    ? const Center(child: Text("No results found"))
                    : ListView.builder(
                        itemCount: itemsToShow.length,
                        itemBuilder: (context, index) {
                          final item = itemsToShow[index];
                          return ServiceCard(service: item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
