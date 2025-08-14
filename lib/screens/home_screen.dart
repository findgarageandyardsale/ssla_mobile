import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/school_provider.dart';
import '../providers/testimonials_provider.dart';
import '../providers/gallery_provider.dart';
import '../services/supabase_service.dart';
import '../utils/app_colors.dart';
import '../widgets/carousel_slider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolInfoAsync = ref.watch(schoolProvider);
    final testimonialsAsync = ref.watch(testimonialsProvider);
    final galleryAsync = ref.watch(galleryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('SSLA School')),
      drawer: _buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(schoolProvider);
          ref.refresh(testimonialsProvider);
          ref.refresh(galleryProvider);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider(
                  images: const [
                    'assets/slider/slider1.png',
                    'assets/slider/slider2.png',
                    'assets/slider/slider3.png',
                    'assets/slider/slider4.png',
                  ],
                  height: 300,
                  autoPlayInterval: const Duration(seconds: 4),
                ),
              ),

              // Philosophy Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Our Philosophy',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            schoolInfo.philosophy,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) => const Text('Error loading philosophy'),
                ),
              ),

              // Vision & Mission Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Our Vision ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            schoolInfo.vision,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) =>
                          const Text('Error loading vision & mission'),
                ),
              ),

              // Gallery Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push('/gallery'),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: galleryAsync.when(
                        data: (galleryItems) {
                          // Show only 6-7 images on home screen
                          final displayItems = galleryItems.take(6).toList();

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: displayItems.length,
                            itemBuilder: (context, index) {
                              final item = displayItems[index];
                              // Get the full Supabase URL
                              final imageUrl = SupabaseService.getImageUrl(
                                item.imageUrl,
                              );

                              return Container(
                                width: 200,
                                margin: const EdgeInsets.only(right: 12),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error:
                            (error, stack) =>
                                const Text('Error loading gallery'),
                      ),
                    ),
                  ],
                ),
              ),

              // Testimonials Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'What People Say',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    testimonialsAsync.when(
                      data:
                          (testimonials) => SizedBox(
                            height: _calculateTestimonialsHeight(testimonials),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  testimonials.length > 3
                                      ? 3
                                      : testimonials.length,
                              itemBuilder: (context, index) {
                                final testimonial = testimonials[index];
                                return Container(
                                  width: 280,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColors.primary,
                                                radius: 20,
                                                child: Text(
                                                  _getInitials(
                                                    testimonial.name,
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      testimonial.name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color:
                                                            AppColors
                                                                .textPrimary,
                                                      ),
                                                    ),
                                                    Text(
                                                      testimonial.role,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors
                                                                .textSecondary,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            testimonial.content,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.textSecondary,
                                              height: 1.4,
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      loading:
                          () => const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      error:
                          (error, stack) => const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Error loading testimonials'),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 320, // Custom height for drawer header
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 35),
                Image.asset(
                  'assets/ssla_logo_white.png',
                  height: 120,
                  width: 120,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.school,
                      size: 50,
                      color: Colors.white,
                    );
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6,
                    children: [
                      Text(
                        'ਵਿਦਿਆ ਵਿਚਾਰੀ ਤਾਂ ਪਰਉਪਕਾਰੀ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'SIKH SCHOOL OF LOS ANGELES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'KHALSA CARE FOUNDATIONn',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),

                      Text(
                        '9989 LAUREL CANYON BLVD.,PACOIMA, CA, 91331',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => context.push('/'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () => context.push('/about'),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Courses'),
            onTap: () => context.push('/courses'),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () => context.push('/gallery'),
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('Contact'),
            onTap: () => context.push('/contact'),
          ),
          ListTile(
            leading: const Icon(Icons.announcement),
            title: const Text('Notice Board'),
            onTap:
                () => context.push(
                  '/image-notice?title=Notice Board&imageURL=assets/notice.jpeg',
                ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap:
                () => context.push(
                  '/image-notice?title=Calendar&imageURL=assets/calendar.jpeg',
                ),
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Registration'),
            onTap: () => context.push('/registration-web'),
          ),
          ListTile(
            leading: const Icon(Icons.rule),
            title: const Text('Rules & Regulations'),
            onTap: () => context.push('/rules'),
          ),
        ],
      ),
    );
  }

  // Helper method to calculate dynamic height for testimonials
  double _calculateTestimonialsHeight(List testimonials) {
    // Base height for the card structure
    double baseHeight = 120.0; // Header + padding + margins

    // Calculate content height based on text length
    double contentHeight = 0;
    for (var testimonial in testimonials.take(3)) {
      // Estimate height based on content length and role length
      double estimatedHeight = 80.0; // Base content height
      if (testimonial.content.length > 150) {
        estimatedHeight += 20.0; // Additional height for longer content
      }
      if (testimonial.role.length > 50) {
        estimatedHeight += 15.0; // Additional height for longer roles
      }
      contentHeight =
          contentHeight > estimatedHeight ? contentHeight : estimatedHeight;
    }

    return baseHeight + contentHeight;
  }

  // Helper method to get initials from a name
  String _getInitials(String name) {
    if (name.isEmpty) return '';

    final nameParts = name.trim().split(' ');
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 1).toUpperCase();
    } else if (nameParts.length >= 2) {
      return '${nameParts[0].substring(0, 1)}${nameParts[1].substring(0, 1)}'
          .toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }
}
