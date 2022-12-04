from simple_term_menu import TerminalMenu
import shutil
import subprocess
import argparse

def main():
    parser = argparse.ArgumentParser(description="Zip file/dir to type")
    # without - or --, filename will just default to first value in cli, if you need many positional args then use nargs="+"
    parser.add_argument('path', nargs="+" ,help="filename/dir to zip")
    path = parser.parse_args().path
    filename = [filename.split("/")[-1] for filename in path]

    print("[{0}] - Compression Method:".format(", ".join(filename)))

    options = ["7z", "tar.gz", "tar.xz", "zip"]
    terminal_menu = TerminalMenu(options)
    menu_entry_index = terminal_menu.show()
    print("Compression Method: {0}".format(options[menu_entry_index]))
    compress_file_name = input("Compressed file name:").split(".",1)[0]

    if options[menu_entry_index] == "zip":
        if shutil.which("unzip") is None:
            print("Installing unzip from Pacman")
            try:
                subprocess.check_call("sudo pacman -S unzip".split())
            except subprocess.CalledProcessError as e:
                print("Error Occured")
        subprocess.check_call("zip -r {0}.zip {1}".format(compress_file_name, " ".join(path)).split()) 
    elif options[menu_entry_index] == "tar.gz":
       subprocess.check_call("tar -czvf {0}.tar.gz {1}".format(compress_file_name, " ".join(path)).split()) 
    elif options[menu_entry_index] == "tar.xz":
       subprocess.check_call("tar -cJf {0}.tar.xz {1}".format(compress_file_name, " ".join(path)).split()) 
    elif options[menu_entry_index] == "7z":
        if shutil.which("7z") is None:
            print("Installing p7zip from Pacman")
            try:
                subprocess.check_call("sudo pacman -S p7zip".split())
            except subprocess.CalledProcessError as e:
                print("Error Occured")
        subprocess.check_call("7z a {0}.7z {1}".format(compress_file_name, " ".join(path)).split()) 
    else:
        print("Error")

if __name__ == "__main__":
    main()
