# ShadowBridge

A silent mobile control bridge running in the shadows.

---

## 📱 Requirements

- Android device  
- Termux app  
- Termux:API app  

> ⚠️ Make sure to grant **all permissions** to the Termux:API app.

---

## ⚙️ Installation Guide

1. Install **Termux** and **Termux:API** from Play Store / F-Droid  
2. Open **Termux**  
3. Run the following commands **one by one**:

```bash
termux-setup-storage
pkg update
pkg upgrade -y
pkg install git -y
pkg install python -y
pkg install termux-api -y
pkg install cloudflared -y
pip install colorama
