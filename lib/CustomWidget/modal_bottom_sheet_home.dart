import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/Form_pages/field_response_model.dart';
import 'package:sr_health_care/const/colors.dart';

class SortFilterBottomSheet extends StatefulWidget {
  const SortFilterBottomSheet({super.key, required this.onApplyFilter});
  final void Function(Map<String, List> filters, Map<String, String> sorts)
      onApplyFilter;

  @override
  State<SortFilterBottomSheet> createState() => _SortFilterBottomSheetState();
}

class _SortFilterBottomSheetState extends State<SortFilterBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _sortCategories = ['Time'];
  final Map<String, String> _selectedSortOption = {};
  List<FieldTypeModel> fieldList = [];
  List<FieldTypeModel> postTypeList = [];
  bool isLoading = false;
  final Map<String, List<dynamic>> _selectedFilters = {};
  final sortTimeOptions = ['Newest First', 'Oldest First'];

  final List<String> _filterCategories = [
    'Field',
    'Type',
    'Date',
    // 'Location',
    // 'Post Creator',
    // 'Following'
  ];

  /// Key: Category, Value: List of filters for that category
  late final Map<String, List> _filterData;

  late String _selectedFilterCategory;

  @override
  void initState() {
    super.initState();
    _selectedFilterCategory = _filterCategories[0];
    _getIntialData();

    _tabController = TabController(length: 2, vsync: this);
  }

  void _resetFilters() {
    _selectedFilters.clear();
    setState(() {});
  }

  void _applyFilters() {
    Navigator.pop(context);
    widget.onApplyFilter(_selectedFilters, _selectedSortOption);
  }

  void _getIntialData() async {
    setState(() {
      isLoading = true;
    });
    // Fetch data for fields
    final fieldResponse = await CreatePostService().fethInitialData('field');
    fieldList = fieldResponse?.masterList
            ?.where((item) => item.status == 'Active')
            .toSet()
            .toList() ??
        []; // Ensure uniqueness

    // Fetch data for post types
    final postTypeResponse = await CreatePostService().fethInitialData('post');
    postTypeList = postTypeResponse?.masterList
            ?.where((item) => item.status == 'Active')
            .toSet()
            .toSet()
            .toList() ??
        []; // Ensure uniqueness
    _filterData = {
      _filterCategories[0]: fieldList,
      _filterCategories[1]: postTypeList,
      _filterCategories[2]: ['Today(120)'],
      //  {
      //   'Today(120)': false,
      // 'Tomorrow(60)': false,
      // 'This Week(40)': false,
      // 'Last Week(40)': false,
      // 'This Month(25)': false,
      // 'Custom Range': false,
      // },
      // 3: {
      //   'Nearby': false,
      //   'Within 5km': false,
      //   'Within 10km': false,
      // },
      // 4: {
      //   'Individual(120)': false,
      //   'Organization(60)': false,
      //   'This Week(40)': false,
      // },
      // 5: {
      //   'Following (Yes)': false,
      //   'Not Following': false,
      // },
    };
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSortByTab(),
                      _buildFilterByTab(),
                    ],
                  ),
          ),
          _bottomButtons(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.deepPurpleAccent,
      labelColor: Colors.deepPurpleAccent,
      unselectedLabelColor: Colors.black,
      tabs: const [
        Tab(text: 'Sort By'),
        Tab(text: 'Filter By'),
      ],
    );
  }

  Widget _buildSortByTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('Time', 'assets/filter/greyc.png'),
            _buildOptionRow(sortTimeOptions, _sortCategories[0]),
            // const SizedBox(height: 6),
            // _sectionHeader('Location', 'assets/filter/greyll.png'),
            // _buildOptionRow(['Closest', 'Farthest'], 1),
            // const SizedBox(height: 6),
            // _sectionHeader('Popularity', 'assets/filter/greyl.png'),
            // _buildOptionRow(['Most Shared', 'Most Commented'], 2),
            // const SizedBox(height: 6),
            // _sectionHeader('Date', 'assets/filter/greycc.png'),
            // _buildOptionRow(['Today', 'Custom'], 3),
          ],
        ),
      ),
    );
  }

// Helper to create rows of buttons for options
  Widget _buildOptionRow(List<String> options, String sortCategory) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options.map((option) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedSortOption[sortCategory] = option;
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: _selectedSortOption[sortCategory] == option
                      ? Colors.deepPurpleAccent
                      : Colors.white,
                  side: BorderSide(
                    color: _selectedSortOption[sortCategory] == option
                        ? Colors.deepPurpleAccent
                        : Colors.grey.shade300,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                      color: _selectedSortOption[sortCategory] == option
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

// Helper to create section headers
  Widget _sectionHeader(String title, String asset) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.asset(
            asset,
            height: 16,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterByTab() {
    return Row(
      children: [
        // Left Side Navigation
        Container(
          padding: const EdgeInsets.only(left: 5),
          width: 120,
          color: buttonColor.withValues(alpha: .1),
          child: ListView.builder(
            itemCount: _filterCategories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedFilterCategory = _filterCategories[index];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _filterCategories[index],
                        style: GoogleFonts.poppins(
                          color: _selectedFilterCategory ==
                                  _filterCategories[index]
                              ? buttonColor
                              : Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 2,
                        height: 25,
                        color:
                            _selectedFilterCategory == _filterCategories[index]
                                ? buttonColor
                                : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Right Side Filter Options
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: _filterData[_selectedFilterCategory]!.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CheckboxListTile(
                    side: const BorderSide(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      (option is FieldTypeModel)
                          ? (option).name.toString()
                          : option.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    value: (_selectedFilters[_selectedFilterCategory] ?? [])
                        .contains(option),
                    // _filterData[_selectedFilterCategory]![option],
                    activeColor: buttonColor,
                    onChanged: (bool? value) {
                      if (value == true) {
                        final tempList =
                            _selectedFilters[_selectedFilterCategory] ?? [];
                        tempList.add(option);
                        _selectedFilters[_selectedFilterCategory] = tempList;
                      } else {
                        _selectedFilters[_selectedFilterCategory]!
                            .remove(option);
                      }
                      setState(() {
                        // _filterData[_selectedFilterCategory]![option] = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetFilters,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Reset',
                style: GoogleFonts.poppins(color: buttonColor),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _applyFilters();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Apply',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// void showSortFilterBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(16),
//         topRight: Radius.circular(16),
//       ),
//     ),
//     builder: (_) => const SortFilterBottomSheet(),
//   );
// }
