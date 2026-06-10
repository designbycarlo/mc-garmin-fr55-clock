# MinimalistFace — Garmin Connect IQ Watch Face

<img src="https://drive.google.com/uc?export=view&id=1A2K4fPpbk81l8ISiNbTCtaAmdaix-71G" width="250" alt="MinimalistFace Preview">

A clean, dark high-contrast minimalist watch face tailored for Garmin memory-in-pixel (MIP) displays.

## What it shows
- **Ultra-Large Time (HH:MM):** Rendered using a prominent 75pt Archivo custom typography layer.
- **Date String:** Highly scannable layout featuring localized Day of Week, Day, and Month.
- **Battery Status:** Numerical battery life indicator paired with a clean, low-profile linear progress bar.
- **Ambient Sleep Mode:** A complete screen black-out optimization when entering low-power mode (wrist down), maximizing battery endurance.

## Codespaces Setup
To develop in GitHub Codespaces:
1. **Install Java:** `sudo apt update && sudo apt install -y default-jre`
2. **Install Monkey C Extension:** Search for "Monkey C" in the VS Code Extensions view and install it.
3. **Download SDK:** 
   - Use the `Monkey C: SDK Manager` command from the Command Palette (`Ctrl+Shift+P`).
   - **Manual Installation:** If the GUI manager fails to render, extract the SDK manager manually:
     ```bash
     mkdir -p ~/bin/garmin
     unzip connectiq-sdk-manager-linux.zip -d ~/bin/garmin
     ```
4. **Compile:**
   ```bash
   monkeyc -f monkey.jungle -o bin/MinimalistFace.prg -d fr55 -y developer_key.der
   ```

*Note: The Simulator requires a GUI environment. To run it, use a Dev Container with "Desktop" support or forward your X11 socket.*

## Setup

### Requirements
- [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/) v4.0+ (System 4)
- VS Code + [Monkey C extension](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c)

### Fonts & Resources
This project relies on a custom typography bundle. Ensure you have the asset file configured in your project resource path:
* File destination: `resources/fonts/Archivo_75pt.fnt` (and its companion `.png` texture glyph sheet)
* Reference ID: mapped inside `resources.xml` under `<font id="BigFont" ... />`

### Build & Run
```bash
# Simulate on Forerunner 55
connectiq
monkeyc -f monkey.jungle -o bin/MinimalistFace.prg -d fr55 -y developer_key.der
monkeydoapp -d fr55 -f bin/MinimalistFace.prg