# Balena PelusaCam 🚀
A containerized application for turning a **BeagleBone Black** running **BalenaOS** into a webcam device using the **Logitech HD Pro Webcam C920**, with video/audio uploads to **Azure Blob Storage**.

## Features
✅ Capture video and audio using `ffmpeg`  
✅ Stream video locally using `mjpg-streamer` (optional)  
✅ Upload recorded files to **Azure Blob Storage** using `azcopy`  
✅ Easy deployment with **Docker & BalenaOS**  

## Getting Started
### **Prerequisites**
- **BeagleBone Black** running **BalenaOS**
- **Logitech HD Pro Webcam C920** connected via USB
- **Azure Blob Storage** account and container setup
- **Docker & Git installed** on your local machine

### **Installation**
1. Clone this repository:  
   ```bash
   git clone https://github.com/yourusername/balena-pelusacam.git
   cd balena-pelusacam