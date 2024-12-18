import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  RxString name = 'Add Username'.obs; // Default name
  RxString location = 'Add Location'.obs; // Default location
  Rx<File?> profileImage = Rx<File?>(null); // Default profile image
  RxBool isLoading = false.obs; // To handle loading state
  stt.SpeechToText _speech = stt.SpeechToText(); // SpeechToText instance
  RxBool isListening = false.obs; // To track if speech-to-text is active

  @override
  void onInit() {
    super.onInit();
    _loadProfileData(); // Load data from SharedPreferences on initialization
  }

  // **Save Profile Data to SharedPreferences**
  Future<void> _saveProfileData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name.value);
      await prefs.setString('location', location.value);
      await prefs.setString('profileImagePath', profileImage.value?.path ?? '');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile data: $e');
    }
  }

  // **Load Profile Data from SharedPreferences**
  Future<void> _loadProfileData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      name.value = prefs.getString('name') ?? 'Add Username';
      location.value = prefs.getString('location') ?? 'Add Location';
      String? imagePath = prefs.getString('profileImagePath');
      if (imagePath != null && imagePath.isNotEmpty) {
        profileImage.value = File(imagePath);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data: $e');
    }
  }

  // **Update Name**
  Future<void> updateName(String newName) async {
    name.value = newName;
    await _saveProfileData();
  }

  // **Update Location**
  Future<void> updateLocation() async {
    try {
      isLoading.value = true;
      Position position = await _determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placemark = placemarks.first;
      String newLocation = '${placemark.locality}, ${placemark.country}';

      location.value = newLocation;
      await _saveProfileData();
      Get.snackbar('Location', 'Location updated to $newLocation');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // **Open Location in Google Maps**
  void openLocationInGoogleMaps() async {
    String query = location.value.replaceAll(' ', '+');
    final Uri url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar('Error', 'Could not open Google Maps');
    }
  }

  // **Update Profile Image**
  Future<void> updateProfileImage(File image) async {
    profileImage.value = image;
    await _saveProfileData();
  }

  // Method to pick an image and save it
  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        await updateProfileImage(File(pickedFile.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Show image picker options (camera or gallery)
  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () async {
                Get.back();
                await pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Get.back();
                await pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Logout dan pastikan data profil tetap disimpan
Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Hapus hanya data yang berkaitan dengan sesi login
  await prefs.remove('token');  // Misalnya, hapus token sesi
  
  // Data profil tetap disimpan (tidak dihapus)
  await _saveProfileData();

  // Arahkan pengguna ke halaman signup setelah logout
  Get.offAllNamed('/signup');
}


  // **Determine the user's position**
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled');
      throw 'Location services are disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Location permission denied forever');
        throw 'Location permission denied forever';
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // **Start listening to user's voice for name**
Future<void> startListeningForName() async {
  // Meminta izin mikrofon terlebih dahulu
  PermissionStatus status = await Permission.microphone.request();

  if (status.isGranted) {
    // Jika izin mikrofon diberikan
    if (!isListening.value) {
      isListening.value = true;
      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(onResult: (result) {
          name.value = result.recognizedWords;
        });
      } else {
        Get.snackbar('Error', 'Speech recognition not available');
      }
    } else {
      _speech.stop();
      isListening.value = false;
    }
  } else if (status.isDenied) {
    // Jika izin mikrofon ditolak, tampilkan snackbar
    Get.snackbar('Permission Denied', 'Microphone access is required for speech recognition');
  } else if (status.isPermanentlyDenied) {
    // Jika izin ditolak secara permanen (perlu diarahkan ke pengaturan)
    openAppSettings();
  }
}
}
