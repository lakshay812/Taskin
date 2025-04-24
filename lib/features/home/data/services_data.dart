class Shop {
  final String name;
  final String image;
  final double rating;
  final String description;
  final String address;

  const Shop({
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    required this.address,
  });
}

class ServiceInfo {
  final String bannerImage;
  final List<Shop> shops;

  const ServiceInfo({
    required this.bannerImage,
    required this.shops,
  });
}

class ServiceData {
  static const Map<String, ServiceInfo> services = {
    'Electronics Repair': ServiceInfo(
      bannerImage: 'assets/images/electronics_banner.png',
      shops: [
        Shop(
          name: 'Kirti Electronics Solutions',
          image: 'assets/images/er1.jpg',
          rating: 4.7,
          description: 'Leading electronics repair center in Bhopal with state-of-the-art diagnostic equipment and skilled technicians. We specialize in repairing all types of electronic devices including smartphones, laptops, TVs, and home appliances. Our team provides quick turnaround times with genuine parts and warranty support. We also offer doorstep services for large appliances and emergency repairs.',
          address: '45 Maharana Pratap Nagar, Zone 1, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Sharma Tech Repairs',
          image: 'assets/images/electronics_repair_shop.jpg',
          rating: 4.8,
          description: 'Premier electronics repair service with over 15 years of experience in Bhopal. Our certified technicians handle everything from basic repairs to complex circuit diagnostics. We pride ourselves on using original parts and providing detailed repair reports. Our workshop is equipped with modern tools for precise diagnosis and efficient repairs.',
          address: '123 MP Nagar Zone 2, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Bajaj Electronics Care',
          image: 'assets/images/er2.png',
          rating: 4.6,
          description: 'Authorized service center for multiple electronics brands in Bhopal. We offer comprehensive repair solutions with genuine parts and manufacturer warranty. Our team specializes in smart device repairs, home theater systems, and gaming consoles. We maintain transparent pricing and provide free diagnostic services for all devices.',
          address: '78 New Market, TT Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Tara Electronics Seva',
          image: 'assets/images/er3.png',
          rating: 4.5,
          description: 'Trusted electronics repair shop serving Bhopal for over a decade. We handle repairs for all major brands of electronics and appliances. Our experienced technicians provide honest assessments and cost-effective solutions. We specialize in data recovery, motherboard repairs, and software issues.',
          address: '234 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Vishnu Digital Repairs',
          image: 'assets/images/er4.jpg',
          rating: 4.9,
          description: 'Modern electronics repair center offering cutting-edge solutions for digital devices. Our team excels in repairing latest smartphones, tablets, and laptops. We provide express repair services with quality assurance and post-repair support. Our workshop uses advanced tools for precise diagnostics and repairs.',
          address: '567 Shahpura, Bhopal, Madhya Pradesh 462039',
        ),
      ],
    ),
    'Laundry': ServiceInfo(
      bannerImage: 'assets/images/laundry_banner.jpg',
      shops: [
        Shop(
          name: 'Chawala Pristine Laundry',
          image: 'assets/images/l1.jpg',
          rating: 4.8,
          description: 'Premium laundry service offering expert care for all types of fabrics. We use eco-friendly detergents and modern washing techniques to ensure your clothes receive the best treatment. Our services include dry cleaning, steam ironing, and stain removal. We also offer express service and free pickup and delivery.',
          address: '89 Malviya Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Suri Fresh Dhobi',
          image: 'assets/images/l2.png',
          rating: 4.6,
          description: 'Traditional laundry service combining conventional wisdom with modern methods. We specialize in handling delicate fabrics and traditional wear. Our team ensures proper sorting, washing, and packaging of your clothes. We offer competitive prices and reliable doorstep service.',
          address: '456 Kolar Road, Bhopal, Madhya Pradesh 462042',
        ),
        Shop(
          name: 'Naina Clean Fabrics',
          image: 'assets/images/laundry.png',
          rating: 4.7,
          description: 'Professional laundry service with state-of-the-art cleaning equipment. We handle everything from daily wear to premium garments with utmost care. Our services include wash and fold, dry cleaning, and specialty fabric care. We ensure quick turnaround times without compromising on quality.',
          address: '321 Habibganj, Bhopal, Madhya Pradesh 462024',
        ),
        Shop(
          name: 'Kapoor Spotless Laundry',
          image: 'assets/images/l3.png',
          rating: 4.5,
          description: 'Expert laundry service specializing in stain removal and fabric care. We use advanced cleaning agents and techniques to handle tough stains. Our services include bulk washing, starching, and premium packaging. We offer flexible pickup and delivery schedules to suit your convenience.',
          address: '789 BHEL, Bhopal, Madhya Pradesh 462022',
        ),
        Shop(
          name: 'Vastra Dhulai Services',
          image: 'assets/images/l4.png',
          rating: 4.9,
          description: 'Complete laundry solution for all your fabric care needs. We offer customized washing programs for different types of clothes. Our services include deep cleaning, sanitization, and premium packaging. We use quality detergents and provide same-day delivery for urgent requirements.',
          address: '234 Bairagarh, Bhopal, Madhya Pradesh 462030',
        ),
      ],
    ),
    'Cleaning': ServiceInfo(
      bannerImage: 'assets/images/cleaning_banner.png',
      shops: [
        Shop(
          name: 'Nirmal Cleaning Solutions',
          image: 'assets/images/cl1.jpeg',
          rating: 4.8,
          description: 'Professional cleaning service offering comprehensive solutions for homes and offices. We use eco-friendly cleaning products and modern equipment for superior results. Our services include deep cleaning, sanitization, and maintenance cleaning. We ensure thorough cleaning with attention to detail.',
          address: '567 MP Nagar Zone 1, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Swachh Seva',
          image: 'assets/images/cleaning.jpeg',
          rating: 4.9,
          description: 'Leading cleaning service provider with trained professionals and advanced cleaning equipment. We specialize in residential and commercial cleaning services. Our team ensures thorough cleaning of all areas with proper sanitization. We offer customized cleaning plans to suit your needs.',
          address: '123 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Chamak Cleaning Services',
          image: 'assets/images/cl2.png',
          rating: 4.7,
          description: 'Expert cleaning service focusing on quality and customer satisfaction. We provide comprehensive cleaning solutions for all types of spaces. Our team uses professional-grade cleaning products and equipment. We offer regular cleaning schedules and one-time deep cleaning services.',
          address: '890 TT Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Shanti Home Cleaners',
          image: 'assets/images/cl3.png',
          rating: 4.6,
          description: 'Reliable home cleaning service with experienced staff and modern cleaning methods. We specialize in residential cleaning and maintenance services. Our team ensures thorough cleaning of all areas including hard-to-reach spaces. We offer flexible scheduling and competitive pricing.',
          address: '456 Shahpura, Bhopal, Madhya Pradesh 462039',
        ),
        Shop(
          name: 'Safai Express',
          image: 'assets/images/cl4.png',
          rating: 4.8,
          description: 'Quick and efficient cleaning service for homes and commercial spaces. We provide prompt and thorough cleaning solutions with trained staff. Our services include regular maintenance, deep cleaning, and special event cleaning. We use safe and effective cleaning products.',
          address: '321 Kolar Road, Bhopal, Madhya Pradesh 462042',
        ),
      ],
    ),
    'Plumbing': ServiceInfo(
      bannerImage: 'assets/images/plumbing_banner.png',
      shops: [
        Shop(
          name: 'Jal Guru Plumbing',
          image: 'assets/images/pl1.png',
          rating: 4.7,
          description: 'Expert plumbing service with licensed professionals and modern tools. We handle all types of plumbing repairs and installations. Our team provides quick response for emergency plumbing issues. We ensure quality workmanship with durable solutions.',
          address: '789 MP Nagar Zone 2, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Patel Pipe Masters',
          image: 'assets/images/plumbing_shop.jpg',
          rating: 4.8,
          description: 'Professional plumbing service specializing in residential and commercial solutions. We offer comprehensive plumbing services with guaranteed workmanship. Our team handles everything from minor repairs to major installations. We provide 24/7 emergency services.',
          address: '234 Malviya Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Singh Plumbing Solutions',
          image: 'assets/images/pl2.png',
          rating: 4.6,
          description: 'Reliable plumbing service with experienced technicians and quality materials. We provide complete plumbing solutions for all your needs. Our team specializes in modern plumbing systems and water conservation. We offer transparent pricing and warranty on services.',
          address: '567 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Neer Flow Services',
          image: 'assets/images/pl3.png',
          rating: 4.9,
          description: 'Advanced plumbing solutions with focus on quality and efficiency. We handle all aspects of plumbing maintenance and repair. Our team uses latest tools for accurate diagnosis and repair. We provide preventive maintenance plans for homes and businesses.',
          address: '890 Habibganj, Bhopal, Madhya Pradesh 462024',
        ),
        Shop(
          name: 'Pani Experts',
          image: 'assets/images/pl4.png',
          rating: 4.7,
          description: 'Comprehensive plumbing service with skilled technicians and modern equipment. We offer complete plumbing solutions for residential and commercial properties. Our team ensures quality work with attention to detail. We provide emergency services with quick response time.',
          address: '123 BHEL, Bhopal, Madhya Pradesh 462022',
        ),
      ],
    ),
    'Carpenter': ServiceInfo(
      bannerImage: 'assets/images/carpentar_banner.jpg',
      shops: [
        Shop(
          name: 'Lakdi Crafts',
          image: 'assets/images/carp1.png',
          rating: 4.8,
          description: 'Expert carpentry service specializing in custom furniture and woodwork. We create beautiful pieces with attention to detail and quality. Our team uses premium materials and modern tools for precise work. We offer custom design services and furniture repair.',
          address: '456 MP Nagar Zone 1, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Sharma Woodworks',
          image: 'assets/images/carp2.png',
          rating: 4.7,
          description: 'Professional carpentry service with skilled craftsmen and quality materials. We provide comprehensive woodworking solutions for homes and offices. Our team specializes in custom furniture and installations. We ensure durability and aesthetic appeal in all our work.',
          address: '789 TT Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Kumar Furniture Solutions',
          image: 'assets/images/carpentar_shop.jpg',
          rating: 4.9,
          description: 'Premium carpentry service offering innovative furniture solutions. We create custom pieces that combine style and functionality. Our team handles everything from design to installation. We use quality wood and modern finishing techniques.',
          address: '234 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Lakshmi Carpentry',
          image: 'assets/images/carp3.png',
          rating: 4.6,
          description: 'Traditional carpentry service with modern techniques and tools. We specialize in custom furniture and wooden installations. Our team provides quality craftsmanship with attention to detail. We offer repair and restoration services for all types of furniture.',
          address: '567 Shahpura, Bhopal, Madhya Pradesh 462039',
        ),
        Shop(
          name: 'Mehta Wood Masters',
          image: 'assets/images/carp4.png',
          rating: 4.8,
          description: 'Expert carpentry service with focus on quality and design. We create custom furniture pieces and wooden installations. Our team combines traditional skills with modern techniques. We provide complete woodworking solutions for your space.',
          address: '890 Kolar Road, Bhopal, Madhya Pradesh 462042',
        ),
      ],
    ),
    'AC Servicing': ServiceInfo(
      bannerImage: 'assets/images/ac_banner.jpg',
      shops: [
        Shop(
          name: 'Thanda Solutions',
          image: 'assets/images/ac1.png',
          rating: 4.7,
          description: 'Professional AC service center with certified technicians. We handle all brands and types of air conditioners. Our team provides comprehensive maintenance and repair services. We ensure efficient cooling and energy savings through proper servicing.',
          address: '123 MP Nagar Zone 2, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Sheetala AC Services',
          image: 'assets/images/ac_servicing_shop.jpeg',
          rating: 4.8,
          description: 'Leading AC service provider with experienced technicians and modern tools. We offer complete AC solutions from installation to maintenance. Our team handles emergency repairs and regular servicing. We provide annual maintenance contracts for hassle-free service.',
          address: '456 Malviya Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Cool Breeze Technicians',
          image: 'assets/images/ac2.png',
          rating: 4.6,
          description: 'Reliable AC service center offering comprehensive maintenance solutions. We specialize in all types of AC repairs and installations. Our team ensures proper functioning and efficiency of your AC. We provide quick response for emergency service calls.',
          address: '789 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Himshital AC Care',
          image: 'assets/images/ac3.png',
          rating: 4.9,
          description: 'Expert AC service with focus on quality and customer satisfaction. We provide complete AC maintenance and repair solutions. Our team uses advanced tools for accurate diagnosis and repair. We offer preventive maintenance plans for optimal performance.',
          address: '234 Habibganj, Bhopal, Madhya Pradesh 462024',
        ),
        Shop(
          name: 'Arora Cooling Systems',
          image: 'assets/images/ac4.png',
          rating: 4.7,
          description: 'Professional AC service center with modern diagnostic equipment. We handle all aspects of AC maintenance and repair. Our team provides efficient solutions for cooling problems. We ensure quality service with genuine spare parts.',
          address: '567 BHEL, Bhopal, Madhya Pradesh 462022',
        ),
      ],
    ),
    'Porter Delivery': ServiceInfo(
      bannerImage: 'assets/images/delivery_banner.png',
      shops: [
        Shop(
          name: 'Vahak Express',
          image: 'assets/images/del1.png',
          rating: 4.8,
          description: 'Professional porter service with trained staff and proper equipment. We handle all types of goods with care and efficiency. Our team ensures safe transportation and timely delivery. We provide real-time tracking and insurance coverage.',
          address: '890 MP Nagar Zone 1, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Fast Delivery',
          image: 'assets/images/del2.png',
          rating: 4.7,
          description: 'Quick and reliable porter service for all your moving needs. We offer efficient transportation solutions with careful handling. Our team specializes in same-day delivery and express service. We ensure safe handling of fragile items.',
          address: '123 TT Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Samaan Seva',
          image: 'assets/images/porter_shop.jpg',
          rating: 4.9,
          description: 'Trusted porter service with experienced staff and proper equipment. We provide comprehensive moving and transportation solutions. Our team ensures careful handling and timely delivery. We offer competitive rates and insurance coverage.',
          address: '456 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Tez Transporters',
          image: 'assets/images/del3.png',
          rating: 4.6,
          description: 'Efficient porter service with focus on quick and safe delivery. We handle all types of goods transportation with care. Our team provides professional moving services. We ensure proper packaging and handling of items.',
          address: '789 Shahpura, Bhopal, Madhya Pradesh 462039',
        ),
        Shop(
          name: 'Bharat Carriers',
          image: 'assets/images/del4.png',
          rating: 4.8,
          description: 'Reliable porter service with trained personnel and proper equipment. We offer complete moving and transportation solutions. Our team ensures safe handling and timely delivery. We provide tracking and insurance for valuable items.',
          address: '234 Kolar Road, Bhopal, Madhya Pradesh 462042',
        ),
      ],
    ),
    'Health & Medical': ServiceInfo(
      bannerImage: 'assets/images/medical_banner.png',
      shops: [
        Shop(
          name: 'Arogya Aushadhi',
          image: 'assets/images/med1.png',
          rating: 4.9,
          description: 'Complete healthcare store with wide range of medicines and medical supplies. We stock all major pharmaceutical brands and generic medicines. Our team includes qualified pharmacists for proper guidance. We offer home delivery and 24/7 emergency service.',
          address: '567 MP Nagar Zone 2, Bhopal, Madhya Pradesh 462011',
        ),
        Shop(
          name: 'Jeevan Health Pharmacy',
          image: 'assets/images/med2.png',
          rating: 4.8,
          description: 'Modern pharmacy with comprehensive medical supplies and equipment. We provide complete healthcare solutions under one roof. Our team offers professional advice and guidance. We ensure availability of essential medicines round the clock.',
          address: '890 Malviya Nagar, Bhopal, Madhya Pradesh 462003',
        ),
        Shop(
          name: 'Sanjivani Medicines',
          image: 'assets/images/med3.png',
          rating: 4.7,
          description: 'Trusted medical store with quality medicines and healthcare products. We maintain proper storage conditions for all medicines. Our team includes experienced pharmacists for proper guidance. We offer quick home delivery services.',
          address: '123 Arera Colony, Bhopal, Madhya Pradesh 462016',
        ),
        Shop(
          name: 'Ayush Medical Store',
          image: 'assets/images/med4.png',
          rating: 4.6,
          description: 'Complete pharmacy offering both allopathic and ayurvedic medicines. We stock wide range of healthcare and wellness products. Our team provides proper guidance for medicine usage. We ensure authentic products with proper storage.',
          address: '456 Habibganj, Bhopal, Madhya Pradesh 462024',
        ),
        Shop(
          name: 'Swasthya Pharma Care',
          image: 'assets/images/med5.png',
          rating: 4.8,
          description: 'Professional pharmacy with focus on quality healthcare products. We maintain extensive stock of medicines and medical supplies. Our team ensures proper handling and storage of medicines. We provide emergency delivery services.',
          address: '789 BHEL, Bhopal, Madhya Pradesh 462022',
        ),
      ],
    ),
  };
}