import 'package:flutter/material.dart';

class AspectRatio {
  final String name;
  final String ratio;
  final double decimal;
  final String era;
  final String description;
  final String category;

  AspectRatio({
    required this.name,
    required this.ratio,
    required this.decimal,
    required this.era,
    required this.description,
    required this.category,
  });
}

class AspectRatioViewer extends StatefulWidget {
  const AspectRatioViewer({Key? key}) : super(key: key);

  @override
  State<AspectRatioViewer> createState() => _AspectRatioViewerState();
}

class _AspectRatioViewerState extends State<AspectRatioViewer> {
  final List<AspectRatio> aspectRatios = [
    AspectRatio(
      name: 'Academy Ratio',
      ratio: '1.37:1',
      decimal: 1.37,
      era: '1932-1953',
      description: 'Original sound film standard',
      category: 'Classic',
    ),
    AspectRatio(
      name: 'Standard 16mm',
      ratio: '1.33:1',
      decimal: 1.33,
      era: '1910s-1950s',
      description: 'Silent film era, TV standard',
      category: 'Classic',
    ),
    AspectRatio(
      name: 'IMAX 70mm Film',
      ratio: '1.43:1',
      decimal: 1.43,
      era: '1970-present',
      description: 'Original IMAX film format, tallest commercial format',
      category: 'IMAX',
    ),
    AspectRatio(
      name: 'IMAX Digital',
      ratio: '1.90:1',
      decimal: 1.90,
      era: '2008-present',
      description: 'IMAX digital projection standard',
      category: 'IMAX',
    ),
    AspectRatio(
      name: 'IMAX with Laser',
      ratio: '1.43:1',
      decimal: 1.43,
      era: '2014-present',
      description: 'Dual 4K laser projection system',
      category: 'IMAX',
    ),
    AspectRatio(
      name: 'European Widescreen',
      ratio: '1.66:1',
      decimal: 1.66,
      era: '1950s-present',
      description: 'Common in Europe',
      category: 'Standard',
    ),
    AspectRatio(
      name: 'American Widescreen',
      ratio: '1.85:1',
      decimal: 1.85,
      era: '1950s-present',
      description: 'Standard US theatrical',
      category: 'Standard',
    ),
    AspectRatio(
      name: 'Univisium',
      ratio: '2.00:1',
      decimal: 2.00,
      era: '1998-present',
      description: 'Proposed digital standard',
      category: 'Standard',
    ),
    AspectRatio(
      name: 'DCI 2K/4K',
      ratio: '2.39:1',
      decimal: 2.39,
      era: '2000s-present',
      description: 'Digital cinema standard',
      category: 'Standard',
    ),
    AspectRatio(
      name: 'CinemaScope',
      ratio: '2.35:1',
      decimal: 2.35,
      era: '1953-present',
      description: 'Classic anamorphic widescreen',
      category: 'Widescreen',
    ),
    AspectRatio(
      name: 'Panavision',
      ratio: '2.40:1',
      decimal: 2.40,
      era: '1950s-present',
      description: 'Anamorphic widescreen',
      category: 'Widescreen',
    ),
    AspectRatio(
      name: 'IMAX DMR',
      ratio: '2.39:1',
      decimal: 2.39,
      era: '2002-present',
      description: 'Digital remastering for IMAX theaters',
      category: 'IMAX',
    ),
    AspectRatio(
      name: 'Ultra Panavision 70',
      ratio: '2.76:1',
      decimal: 2.76,
      era: '1957-1966',
      description: 'Ultra-wide format (Ben-Hur)',
      category: 'Widescreen',
    ),
  ];

  late List<AspectRatio> selected;
  bool compareMode = true;
  String filterCategory = 'All';
  String sizeMode = 'width'; // 'width' or 'height'

  final List<String> categories = ['All', 'Classic', 'IMAX', 'Standard', 'Widescreen'];
  final double maxDimension = 300.0;

  @override
  void initState() {
    super.initState();
    selected = [
      aspectRatios[1],
      aspectRatios[6],
      aspectRatios[8],
    ];
  }

  List<AspectRatio> get filteredRatios {
    if (filterCategory == 'All') {
      return aspectRatios;
    }
    return aspectRatios.where((ar) => ar.category == filterCategory).toList();
  }

  void toggleRatio(AspectRatio ratio) {
    setState(() {
      final isSelected = selected.any((r) => r.ratio == ratio.ratio && r.name == ratio.name);
      if (isSelected) {
        selected.removeWhere((r) => r.ratio == ratio.ratio && r.name == ratio.name);
      } else {
        selected.add(ratio);
      }
    });
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case 'IMAX':
        return Colors.red.withOpacity(0.2);
      case 'Classic':
        return Colors.amber.withOpacity(0.2);
      case 'Widescreen':
        return Colors.purple.withOpacity(0.2);
      default:
        return Colors.green.withOpacity(0.2);
    }
  }

  Color getCategoryTextColor(String category) {
    switch (category) {
      case 'IMAX':
        return Colors.red.shade300;
      case 'Classic':
        return Colors.amber.shade300;
      case 'Widescreen':
        return Colors.purple.shade300;
      default:
        return Colors.green.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF111827),
              const Color(0xFF1F2937),
              const Color(0xFF111827),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                // Header
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.movie, size: 40, color: Colors.blue.shade400),
                        const SizedBox(width: 12),
                        const Text(
                          'Movie Aspect Ratio Viewer',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Explore and compare different film formats throughout cinema history',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // Controls
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              compareMode = !compareMode;
                            });
                          },
                          icon: const Icon(Icons.fullscreen, size: 20, color: Colors.white),
                          label: Text(
                            compareMode ? 'Comparison Mode' : 'Individual Mode',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                        ),
                        ...categories.map((cat) => ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  filterCategory = cat;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: filterCategory == cat
                                    ? Colors.purple.shade600
                                    : Colors.grey.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                              child: Text(cat, style: const TextStyle(color: Colors.white)),
                            )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              sizeMode = 'width';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: sizeMode == 'width'
                                ? Colors.green.shade600
                                : Colors.grey.shade700,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                          child: const Text(
                            'Compare by Width (Same Width)',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              sizeMode = 'height';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: sizeMode == 'height'
                                ? Colors.green.shade600
                                : Colors.grey.shade700,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                          child: const Text(
                            'Compare by Height (Same Height)',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      sizeMode == 'width'
                          ? 'All screens have the same width - compare their heights'
                          : 'All screens have the same height - compare their widths',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Main Content - Side by Side
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1200) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildSelectionPanel()),
                          const SizedBox(width: 32),
                          Expanded(child: _buildVisualizationPanel()),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildSelectionPanel(),
                          const SizedBox(height: 32),
                          _buildVisualizationPanel(),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 48),

                // Details Table
                if (selected.isNotEmpty) _buildDetailsTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Aspect Ratios to Compare',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: filteredRatios.length,
          itemBuilder: (context, index) {
            final ar = filteredRatios[index];
            final isSelected = selected.any((r) => r.ratio == ar.ratio && r.name == ar.name);

            return InkWell(
              onTap: () => toggleRatio(ar),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.withOpacity(0.2)
                      : const Color(0xFF1F2937),
                  border: Border.all(
                    color: isSelected ? Colors.blue.shade500 : Colors.grey.shade600,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ar.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: getCategoryColor(ar.category),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            ar.category,
                            style: TextStyle(
                              color: getCategoryTextColor(ar.category),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          ar.ratio,
                          style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          ' • ',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        ),
                        Expanded(
                          child: Text(
                            ar.era,
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVisualizationPanel() {
    if (selected.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Text(
            'Select aspect ratios to see comparison',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visual Comparison',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(12),
          ),
          child: compareMode ? _buildOverlaidComparison() : _buildIndividualComparison(),
        ),
      ],
    );
  }

  Widget _buildOverlaidComparison() {
    // Calculate maximum dimensions
    double maxWidth = 0;
    double maxHeight = 0;

    for (var ar in selected) {
      if (sizeMode == 'width') {
        final w = maxDimension * 2;
        final h = w / ar.decimal;
        maxWidth = maxWidth > w ? maxWidth : w;
        maxHeight = maxHeight > h ? maxHeight : h;
      } else {
        final h = maxDimension;
        final w = h * ar.decimal;
        maxWidth = maxWidth > w ? maxWidth : w;
        maxHeight = maxHeight > h ? maxHeight : h;
      }
    }

    final containerWidth = maxWidth + 40;
    final containerHeight = maxHeight + 40;

    final colors = [
      Colors.blue.withOpacity(0.4),
      Colors.purple.withOpacity(0.4),
      Colors.pink.withOpacity(0.4),
      Colors.green.withOpacity(0.4),
      Colors.yellow.withOpacity(0.4),
    ];

    final borderColors = [
      Colors.blue.shade400,
      Colors.purple.shade400,
      Colors.pink.shade400,
      Colors.green.shade400,
      Colors.yellow.shade400,
    ];

    return Column(
      children: [
        Container(
          color: Colors.black,
          child: SizedBox(
            width: containerWidth,
            height: containerHeight,
            child: Stack(
              children: selected.asMap().entries.map((entry) {
                final idx = entry.key;
                final ar = entry.value;

                double widthPx, heightPx;
                if (sizeMode == 'width') {
                  widthPx = maxDimension * 2;
                  heightPx = widthPx / ar.decimal;
                } else {
                  heightPx = maxDimension;
                  widthPx = heightPx * ar.decimal;
                }

                return Center(
                  child: Container(
                    width: widthPx,
                    height: heightPx,
                    decoration: BoxDecoration(
                      color: colors[idx % colors.length],
                      border: Border.all(
                        color: borderColors[idx % borderColors.length],
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${ar.name} (${ar.ratio})',
                            style: TextStyle(
                              color: borderColors[idx % borderColors.length],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: selected.asMap().entries.map((entry) {
            final idx = entry.key;
            final ar = entry.value;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors[idx % colors.length],
                border: Border.all(color: borderColors[idx % borderColors.length]),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colors[idx % colors.length],
                      border: Border.all(
                        color: borderColors[idx % borderColors.length],
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ar.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${ar.ratio})',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIndividualComparison() {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: selected.length,
        itemBuilder: (context, idx) {
          final ar = selected[idx];

          double widthPx, heightPx;
          if (sizeMode == 'width') {
            widthPx = maxDimension * 2;
            heightPx = widthPx / ar.decimal;
          } else {
            heightPx = maxDimension;
            widthPx = heightPx * ar.decimal;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      ar.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: getCategoryColor(ar.category),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        ar.category,
                        style: TextStyle(
                          color: getCategoryTextColor(ar.category),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  ar.ratio,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: widthPx > 400 ? 400 : widthPx,
                    height: widthPx > 400 ? 400 / ar.decimal : heightPx,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade600, Colors.purple.shade600],
                      ),
                      border: Border.all(color: Colors.blue.shade400, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        ar.ratio,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detailed Comparison Table',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Format',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Ratio',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Decimal',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Category',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Era',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Description',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: selected.map((ar) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        ar.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataCell(Text(ar.ratio, style: TextStyle(color: Colors.blue.shade400))),
                    DataCell(
                      Text(
                        ar.decimal.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getCategoryColor(ar.category),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          ar.category,
                          style: TextStyle(
                            color: getCategoryTextColor(ar.category),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(ar.era, style: TextStyle(color: Colors.grey.shade400))),
                    DataCell(Text(ar.description, style: TextStyle(color: Colors.grey.shade400))),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}