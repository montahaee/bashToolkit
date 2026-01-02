
Welcome to the **BashToolkit** repository! This repository is a treasure trove of useful bash scripts designed to automate various tasks. Each script in this repository is explained in the detail below.

---
## 📝 General Usage for All Scripts

For all the scripts in this toolkit, follow these steps:

**1.** Save the script anywhere on your local machine, **but** It’s recommended to save the script on your local machine
in a common directory designated for all scripts. This helps avoid discrepancies in the paths specified in your 
configuration files.<br>
**2.** Run `chmod +x scriptname` to make it executable.<br>
**3.** Run `chmod 755 scriptname` to protect the script file (make it only readable, writable and executable for yourself as owner).

Replace `scriptname` with the actual name of your script.

---

## 📄 Script 1: Git Status in Tabular Format

This script displays the output of `git status` in a tabular format with dates and different colors for each part. It's
a handy tool for visualizing the status of your git repository in a more structured and colorful way.

### 🚀 Usage:

**1.** [General](#-general-usage-for-all-scripts) steps<br>
**2.** Add it as a git alias using `git config --global alias.tabstatus '!/path/to/script'`.

Now, you can use the script by running `git tabstatus`.

---

## 📄 Script 2: Open File Extensions (OFWE)

The second on in our toolkit, `OFWE` (an abbreviation for **O**pen  **F**iels **W**ith **E**xtension), is intended to 
open files with specific extension. It provides options to apply the opening to all directories 
(i.e., parent and children) or only the parent directory as described and shown in the next section. 

### 🚀 Usage:

**1.** [General](#-general-usage-for-all-scripts) steps<br>
**2.** Open your `~/.bashrc` file in a text editor and copy the following at the end of the file:<br>

`🔵 export PATH=🔴$PATH:/path/to/your`

Now, you can use the script by running `OFWE /path/to/desired/directory/ [-a/-p] current_extension`.

---

## 📄 Script 3: Change File Extensions (SEXT)

The third script in our toolkit, `SEXT` (an abbreviation for **S**cript for **EXT**ension change), is designed to 
change the extension of files in a specified directory. It provides options to apply the changes to all directories 
(i.e., parent and children) or only the parent directory as described and shown in the next section. 

### 🚀 Usage:


The preparation for running is similar to the [last](#-usage-1) one

Now, The script is enabled to run by `SEXT /path/to/desired/directory/ [-a/-p] current_extension,desired_extension`.

---

## 📄 Script 4: Handle Kept-Back Packages (UKB)

The fourth script in our toolkit, `UKB` (for **U**pgrade **K**ept**B**ack package), is designed to handle kept-back packages that often occur after an Ubuntu upgrade. It provides an interactive way to upgrade these packages. Please note, sometimes the upgrade of the kept-back package can affect your system. Therefore, use this script very carefully, considering the compatibility of other packages in your system.

### 🚀 Usage:

The preparation for running is similar to the [second](#-usage-1) one


You can now run the script by hitting `ukb`.



---

## 📄 Script 5: Wheelhouse Python Packages (WHPYP)
Having separate virtual environments for each project does mean that the same packages may be installed multiple times on your system, once for each environment. This can take up more disk space, as each environment maintains its own copy of the installed packages.

However, the advantages of this approach often outweigh the additional disk space usage:

- **Isolation**: 
Each project has its own set of dependencies, which prevents conflicts between projects that may require different versions of the same package.

- **Reproducibility**:
It’s easier to share and collaborate on projects with others when the environment can be replicated exactly, including all dependencies.

- **Testing**:
You can test new package versions in one project without affecting other projects.

The fiveth script in our toolkit, `WHPYP` (for **W**eelhouse **PY**thon **P**ackage), is a good approach to managing Python package dependencies across multiple projects. It uses a wheelhouse, a directory where Python wheel files are stored, to manage package installations. Here’s how it works:

1. The `update_wheelhouse` function updates the wheel package and then updates all packages in the wheelhouse. This ensures that you have the latest versions of all packages.

2. The `install_all_from_wheelhouse` function installs all packages from the wheelhouse into a project's virtual environment. This ensures that each project has its own isolated set of dependencies.

### 🚀 Usage:

The preparation for running is similar to the usageof the [second](#-usage-1) script.


You can now run the script by hitting `whpyp /path/to/venv_project`.

Remember to run this script every time you start a new project or when you want to update the packages in your existing projects.

please note that this script assumes that all your projects can work with the latest versions of their dependencies.
In the case of the requirement of specific versions, you would call this second script 'whpypr' with the path to the virtual environment
and the requirements file as arguments. For example:

`whpypr /path/to/venv path/to/requirements.txt`

This way, each project can specify its own dependencies, including the required versions, in its requirements file. 
The script will then create or update the virtual environment with these specific versions. This approach maintains 
the benefits of isolation and reproducibility while also allowing for specific package versions.

---
## 📄 Script 6: SCIM — Scan Image Manager

`SCIM` is a small CLI utility for scanning documents via SANE (`scanimage`) and converting pages into PDF/JPEG/PNG. It supports color or grayscale, per-page scanning, interactive multi-page scanning and combining pages into a single output file (e.g. multi-page PDF).

> **Preparation for SCIM** — run this before using SCIM.

### 🖨️ Scanner Setup & Preparation (Ubuntu)

This section explains how to activate and verify a scanner on Ubuntu before using **SCIM** (Scan Image Manager).

Ubuntu uses **SANE** (*Scanner Access Now Easy*) as its scanning backend. In most cases, scanners work automatically once the correct backend or driver is installed.

---

### 🔍 6.1 Check if Ubuntu Already Detects Your Scanner

Open a terminal and run:

```
scanimage -L
```

If your scanner is detected, you’ll see something like:

```
device `epson2:...` is a Epson flatbed scanner
```

If nothing appears, continue with the steps below.

### 🖨️ What this command does

`scanimage -L` asks SANE:

> "List all scanners you can detect."

If SANE is installed correctly, this command works on **all Linux distributions**, not just Ubuntu.

---

### 🧰 6.2 Install Basic Scanner Support (SANE)

Ubuntu usually ships with SANE preinstalled, but to ensure everything is present:

```
sudo apt update
sudo apt install sane sane-utils simple-scan
```

* **SANE** – backend that communicates with the scanner
* **sane-utils** – CLI tools like `scanimage`
* **Simple Scan** – default Ubuntu GUI scanning app

### Other Distributions

**Fedora**

```
sudo dnf install sane-backends
```

**Arch / Manjaro**

```
sudo pacman -S sane
```

**openSUSE**

```
sudo zypper install sane-backends
```

---

### 🖨️ 6.3 HP Scanners (Very Common)

HP devices require **HPLIP** (HP Linux Imaging and Printing):

```
sudo apt install hplip hplip-gui
```

Then run:

```
hp-setup
```

This installs drivers and enables scanning support for HP multifunction devices.

---

### 🧩 6.4 Epson Scanners

Epson often provides proprietary `.deb` drivers. On newer Ubuntu versions (e.g. 24.04), some older installers fail because they expect `libsane`.

### Workaround

```
sudo apt install libsane1
```

If available, prefer Epson’s **updated** driver packages compatible with your Ubuntu version.

---

### 🌐 6.5 Network Scanners

For scanners available over the network:

```
sudo nano /etc/sane.d/net.conf
```

Add the scanner’s IP address (one per line), then restart SANE:

```
sudo systemctl restart saned
```

---

### 📷 6.6 Scan Using a GUI (Optional)

Ubuntu offers multiple scanning applications:

* **Simple Scan** – default, easy to use
* **Skanlite** – KDE alternative
* **XSane** – advanced controls

Launch Simple Scan:

```
simple-scan
```

---

### 🧪 6.7 Test the Scanner

To verify that scanning works at a low level:

```
scanimage --test
```

If no errors are returned, your scanner is ready.

---

### ✅ Next Step: Use SCIM

Once your scanner is detected and working, you can safely use **SCIM** for:

* single-page scans
* multi-page interactive scans
* combined PDFs
* JPEG / PNG output
* color or grayscale scanning

Refer to the **SCIM Usage** section below for detailed command examples.

---

### SCIM — Requirements

Make sure these are installed:

```bash
sudo apt install sane-utils imagemagick   # imagemagick provides `convert`
# optionally: sudo apt install img2pdf  (faster PDF assembly alternative)
```

### SCIM CLI syntax

```
scim <output-name> <format> [-g] <resolution> [quality]
```

* `<output-name>` — base name for output (no extension)
* `<format>` — `pdf` | `jpeg` | `png`
* `-g` — grayscale mode (optional; default is color)
* `<resolution>` — DPI (e.g. `300`)
* `[quality]` — JPEG quality (required for `pdf`, optional/ignored for single `jpeg`/`png`)

### Examples

```bash
# Multi-page interactive PDF (300 dpi, JPEG compression quality 60)
scim scanTest pdf 300 60
scim scanTest pdf -g 300 60   # grayscale

# Single or multi-page JPEG (300 dpi)
scim scanTest jpeg 300
scim scanTest jpeg -g 300

# Single or multi-page PNG (300 dpi)
scim scanTest png 300
scim scanTest png -g 300
```

### Behavior

* The script prompts for each scanned page (press Enter to scan next page; respond `n` to finish).
* For `pdf`: all pages are combined into `output-name.pdf` using JPEG compression at the supplied quality.
* For `jpeg`/`png`: a single-page scan produces `output-name.jpeg` or `output-name.png`. If multiple pages are scanned, the script creates `output-name-001.jpeg`, `output-name-002.jpeg`, … (or `.png`).
* The script creates temporary TIFFs for each scanned page, then converts/combines and **cleans up** the temp files on exit.
* The script prevents accidental overwrites by refusing to write if the target filename already exists.


---
Stay tuned for more scripts in this toolkit! 🎉

---

## License

This project is licensed under the MIT License—see the LICENSE file for details.
