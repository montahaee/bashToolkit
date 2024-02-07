
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

Stay tuned for more scripts in this toolkit! 🎉

---

## License

This project is licensed under the MIT License—see the LICENSE file for details.
