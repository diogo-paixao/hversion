# Houdini Version Selector (`hversion.ps1`)

A simple PowerShell script to browse and select from installed Houdini versions on Windows, and set one as the default application for `.hip`, `.hipnc`, and `.hiplc` project files.
Setup is persistent across machine restarts, and new software installs.

Just select your default version via Terminal (with proper admin permission), and your Houdini files will open with that selected Houdini version.


---

## 🎯 Features – v0.0.1

- ✅ Scans the default Houdini installation directory (`C:\Program Files\Side Effects Software`) for installed versions.
- ✅ Displays an interactive terminal menu to select a Houdini version using arrow keys.
- ✅ Sets the selected version's `houdini.exe` as the default for:
  - `.hip`
  - `.hipnc`
  - `.hiplc`
- ✅ Updates Windows file associations using `assoc` and `ftype`.

---

## 🖥️ Platform

- **Operating System:** Windows
- **Shell:** PowerShell
- **Tested On:** Windows 10/11 with multiple Houdini versions installed

---

## 🚀 Usage

1. **Launch PowerShell as Administrator.**  
   File associations require elevated permissions.

2. **Run the script:**

   ```powershell
   .\hversion.ps1
   Use the arrow keys to navigate the list of installed Houdini versions.
   ```

Use Up and Down arrows to navigate through installed Houdini versions.
Press Enter to select the version you want to associate with .hip, .hipnc, and .hiplc files.

And now you can just left-click on the .hip files you want to open and Houdini will launch with the selected version.

Press Escape to exit without making changes.


## 📁 Example Output in Terminal

When running the script:
```
Select Houdini version to set as default:

> Houdini 20.0.547
> Houdini 19.5.716
> Houdini 19.0.720
```

After version selection:

```
File associations updated for .hip, .hipnc, .hiplc to use:
C:\Program Files\Side Effects Software\Houdini 20.0.547\bin\houdini.exe
Houdini 20.0.547 selected as default version.

```

## 📌 Notes

Only versions installed in C:\Program Files\Side Effects Software and named in the format Houdini <version> are detected.

This script does not modify environment variables or PATH entries—only file associations.

## 📦 Version

v0.0.1 – Initial release with file association functionality and version selection with arrows via UI.
