class BannerAdd {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String? link;

  BannerAdd({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.link,
  });

  //Dummy data for testing
  static List<BannerAdd> dummyBanners = [
    BannerAdd(
      id: '1',
      imageUrl: 'assets/images/banner-1.webp',
      title: 'Special Offer',
      description: 'Get 20% off on your first booking',
      link: '/offers/1',
    ),
    BannerAdd(
      id: '2',
      imageUrl: 'assets/images/banner-2.webp',
      title: 'Special Offer',
      description: 'Get 20% off on your first booking',
      link: '/properties/new',
    ),
  ];
}
