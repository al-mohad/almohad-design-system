import 'package:almohad_design_system/src/widgets/morphisms/morphisms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class DynamicImageGrid extends StatelessWidget {
  final List<String> imageUrls;

  const DynamicImageGrid({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    int count = imageUrls.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child:
          count == 1
              ? _buildSingleImage(context, imageUrls[0])
              : count == 2
              ? _buildTwoImages(context)
              : count == 3
              ? _buildThreeImages(context)
              : _buildFourImages(),
    );
  }

  /// 🔹 Single Image (Reduced to Half)
  Widget _buildSingleImage(BuildContext context, String url) {
    return GestureDetector(
      onTap: () => _showImagePreview(context, url),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 100, // Reduced to half (100px)
      ),
    );
  }

  /// 🔹 Two Images Layout (Reduced Spacing and Image Size)
  Widget _buildTwoImages(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _showImagePreview(context, imageUrls[0]),
            child: CachedNetworkImage(
              imageUrl: imageUrls[0],
              fit: BoxFit.cover,
              height: 75, // Reduced to half (75px)
            ),
          ),
        ),
        Gutter.tiny(), // Reduced gutter spacing
        Expanded(
          child: GestureDetector(
            onTap: () => _showImagePreview(context, imageUrls[1]),
            child: CachedNetworkImage(
              imageUrl: imageUrls[1],
              fit: BoxFit.cover,
              height: 75, // Reduced to half (75px)
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Three Images Layout (Reduced Sizes)
  Widget _buildThreeImages(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _showImagePreview(context, imageUrls[0]),
            child: CachedNetworkImage(
              imageUrl: imageUrls[0],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 75, // Reduced to half (75px)
            ),
          ),
        ),
        Gutter.tiny(),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showImagePreview(context, imageUrls[1]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6), // Reduced radius
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls[1],
                      fit: BoxFit.cover,
                      height: 37.5, // Reduced to half (37.5px)
                    ),
                  ),
                ),
              ),
              Gutter.tiny(),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6), // Reduced radius
                  ),
                  child: GestureDetector(
                    onTap: () => _showImagePreview(context, imageUrls[2]),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls[2],
                      fit: BoxFit.cover,
                      height: 37.5, // Reduced to half (37.5px)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 Four or More Images Layout (Grid with Smaller Size)
  Widget _buildFourImages() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1, // Reduced spacing
        crossAxisSpacing: 1,
        childAspectRatio: 1, // Square aspect ratio
      ),
      itemCount: imageUrls.length > 4 ? 4 : imageUrls.length,
      itemBuilder: (context, index) {
        final url = imageUrls[index];

        return GestureDetector(
          onTap: () => _showImagePreview(context, url),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),

              // 🔥 Overlay if more than 4 images
              if (index == 3 && imageUrls.length > 4)
                Container(
                  color: Colors.black.withValues(alpha: 0.5), // Dark overlay
                  alignment: Alignment.center,
                  child: Text(
                    "+${imageUrls.length - 4} more",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10, // Reduced font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 Show Fullscreen Preview (Reduced Padding & Button Size)
  void _showImagePreview(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Reduced radius
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6), // Reduced radius
                    child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 4), // Reduced space
                  ElevatedButton.icon(
                    onPressed: () async {},
                    icon: Icon(Icons.download, size: 16), // Reduced icon size
                    label: Text(
                      "Download",
                      style: TextStyle(fontSize: 12),
                    ), // Reduced text size
                  ),
                  SizedBox(height: 4), // Reduced space
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0), // Reduced padding
                child: Glassmorphism(
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ), // Reduced icon size
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
