
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
Stay tuned for more scripts in this toolkit! 🎉

---

## License

This project is licensed under the MIT License—see the LICENSE file for details.
