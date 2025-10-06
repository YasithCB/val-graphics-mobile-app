import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/services_data.dart';
import 'package:val_graphics_mobile_app/models/service_model.dart';
import 'package:val_graphics_mobile_app/widgets/sub_service_card.dart';

import '../../db/constants.dart';
import '../../l10n/app_localizations.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final TextEditingController _controller = TextEditingController();

  List<SubServiceModel> _results = [];

  void _search() {
    String query = _controller.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _results.clear();
      } else {
        _results = getAllSubServices(
          Localizations.localeOf(context).languageCode,
        ).where((item) => item.name.toLowerCase().contains(query)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<SubServiceModel> itemsToShow =
        _results.isEmpty && _controller.text.isEmpty
        ? getPopularServices(
            Localizations.localeOf(context).languageCode,
          ) // default popular services
        : _results;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
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
                          hintText: AppLocalizations.of(
                            context,
                          )!.searchServices,
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
                                      _results.clear(); // show default again
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
                        onChanged: (_) => _search(),
                        onSubmitted: (_) => _search(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 60, // fixed small button width
                      height: 50, // fixed button height for uniform shape
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: metallicGold,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: _search,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 Section Title
                Text(
                  _controller.text.isEmpty
                      ? AppLocalizations.of(context)!.popularServicesTheseDays
                      : AppLocalizations.of(context)!.searchResults,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // 🔹 Services List
                Expanded(
                  child: itemsToShow.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.noResultsFound,
                          ),
                        )
                      : ListView.builder(
                          itemCount: itemsToShow.length,
                          itemBuilder: (context, index) {
                            final item = itemsToShow[index];
                            return SubServiceCard(service: item);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
