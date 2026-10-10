# 🎙️ Dicta Linux - Smart Bilingual Speech-to-Text & Voice Typing for Linux

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux%20(X11%20%26%20GNOME)-orange.svg)]()
[![Python](https://img.shields.io/badge/Python-3.8%2B-green.svg)]()
[![Languages](https://img.shields.io/badge/Supports-Arabic%20%7C%20English%20%7C%20Mixed-purple.svg)]()

A fast, lightweight, and modern voice typing and Speech-to-Text (STT) dictation tool for Linux. Press **`Alt + D`**, speak naturally in **Arabic, English, or mixed (code-switching)**, press **`Alt + D`** again, and watch your spoken words get transcribed and **automatically typed directly into whatever app you are using**!

---

## ✨ Key Features

- ⚡ **Global Voice Typing Shortcut (`Alt + D`):** 
  - Hit `Alt + D` ➔ Recording starts with a desktop notification.
  - Speak your thoughts.
  - Hit `Alt + D` again ➔ Audio stops, transcribes, and **instantly auto-pastes into your active text box**!
- 🌐 **Mixed Arabic & English Support (Bilingual / Code-Switching):**
  - Seamlessly transcribes sentences containing mixed Arabic and English tech terms (e.g. *"أنا عايز أعمل push للـ branch على GitHub"* or *"create new function in Python"*).
- 🚀 **Hybrid Dual Engine:**
  - **Cloud Engine:** Fast, high-accuracy Google Speech Recognition API (zero CPU, real-time).
  - **Offline Local Engine:** Automatic offline fallback via OpenAI Whisper (`whisper.cpp`).
- 🖥️ **CLI & File Transcription:**
  - Transcribe any WAV/MP3 audio file to text with `dicta -f speech.wav`.
  - Save transcripts directly to a file with `dicta -f interview.wav -o transcript.txt`.
- 🔔 **Visual Feedback:** Instant desktop notifications showing the recording state, progress, and recognized text preview.

---

## 📦 Dependencies

| Dependency | Purpose |
| :--- | :--- |
| **`python3`** | Core orchestration and API streaming logic |
| **`ffmpeg`** / **`flac`** | Low-latency audio capture and high-quality FLAC encoding |
| **`copyq`** / **`xclip`** | Automatic in-place pasting into the focused window |
| **`libnotify`** / `notify-send` | Desktop recording and transcription notifications |

---

## 🛠️ Installation

### 1-Line Quick Install

```bash
git clone https://github.com/domz-1/dicta-linux.git
cd dicta-linux
make install
```

*(The installer auto-detects your distribution, installs dependencies, places binaries in `~/.local/bin`, and registers the global `Alt + D` shortcut).*

---

### Manual Installation per Distribution

#### 🐧 Ubuntu / Debian / Linux Mint:
```bash
sudo apt update
sudo apt install -y python3 ffmpeg flac xclip copyq zenity libnotify-bin
git clone https://github.com/domz-1/dicta-linux.git
cd dicta-linux
./install.sh
```

#### 🐧 Arch Linux / Manjaro:
```bash
sudo pacman -S --noconfirm python ffmpeg flac xclip copyq zenity libnotify
git clone https://github.com/domz-1/dicta-linux.git
cd dicta-linux
./install.sh
```

#### 🐧 Fedora / RHEL:
```bash
sudo dnf install -y python3 ffmpeg flac xclip copyq zenity libnotify
git clone https://github.com/domz-1/dicta-linux.git
cd dicta-linux
./install.sh
```

---

## 🕹️ Usage & Examples

### 1. Voice Typing Anywhere (The Magic Shortcut)
1. Place your text cursor inside **any text field** (Chrome, VS Code, Slack, Telegram, Discord, Terminal).
2. Press **`Alt + D`** (a notification *"🎙️ Recording Started"* will appear).
3. Speak normally in Arabic, English, or mixed.
4. Press **`Alt + D`** again.
5. Your speech will be transcribed and pasted immediately into the active field!

### 2. Command Line Interface (CLI)

```bash
# Toggle dictation recording
dicta

# Transcribe an existing audio file
dicta -f meeting_recording.wav

# Transcribe and save to a text file
dicta -f voice_note.wav -o note.txt

# Specify language explicitly (e.g. English only or Arabic only)
dicta -l en-US -f podcast.wav
dicta -l ar-EG -f voice.wav

# Stop recording if running
dicta --stop
```

---

## 🗑️ Uninstallation

```bash
cd dicta-linux
make uninstall
```

---

## 👨‍💻 Author & Credits

Created with ❤️ by **Adham** ([@domz-1](https://github.com/domz-1)).

If you find Dicta helpful, please star ⭐️ the repository on GitHub!
