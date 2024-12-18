import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:footballnews_mobile/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF082756),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: Get.back,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Foto Profil
              Obx(() {
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(controller.profileImage.value!) as ImageProvider
                          : AssetImage('assets/default_profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.showImagePickerOptions,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20),

              // Nama
              Obx(() {
                return GestureDetector(
                  onTap: () {
                    nameController.text = controller.name.value;
                    _showEditNameDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.name.value,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 16),

              // Tombol Mic (Dibawah Nama)
              Obx(() {
                return IconButton(
                  icon: Icon(
                    controller.isListening.value ? Icons.mic : Icons.mic_none,
                    color: controller.isListening.value ? Colors.blue : Colors.grey,
                  ),
                  onPressed: controller.startListeningForName,
                );
              }),
              SizedBox(height: 16),

              // Lokasi
              _buildEditableField(
                label: 'Location',
                value: Obx(() => Text(
                      controller.location.value,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )),
                onTap: () async {
                  await controller.updateLocation();
                },
              ),
              SizedBox(height: 24),

              // Tombol Cek Lokasi (Google Maps) - Menggunakan Ikon dengan ukuran kecil
              IconButton(
                onPressed: controller.openLocationInGoogleMaps,
                icon: Icon(Icons.map, color: Colors.grey),
                iconSize: 24, // Ukuran ikon disamakan dengan ikon mic
              ),
              SizedBox(height: 30),

              // Tombol Logout
              ElevatedButton.icon(
                onPressed: controller.logout,
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog untuk mengedit nama
  void _showEditNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Name'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: 'Enter your name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.updateName(nameController.text);
              Navigator.of(context).pop();
            },
            child: Text('Save', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Widget reusable untuk field editable
  Widget _buildEditableField({
    required String label,
    required Widget value,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            value,
          ],
        ),
      ),
    );
  }
}
