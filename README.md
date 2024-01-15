
Welcome to the **BashToolkit** repository! This repository is a treasure trove of useful bash scripts designed to automate various tasks. Each script in this repository is explained in the detail below.

---
## 📝 General Usage for All Scripts

For all the scripts in this toolkit, follow these steps:

**1.** Save the script anywhere on your local machine, **but** It’s recommended to save the script on your local machine
in a common directory designated for all scripts. This helps avoid discrepancies in the paths specified in your 
configuration files.<br>
**2.** Run `chmod +x scriptname` to make it executable.<br>
**3.** Run `chmod 500 scriptname` to protect the script file (make it only readable).

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
## License

This project is licensed under the MIT License—see the LICENSE file for details.
