import shutil
import argparse
import subprocess

def main():
    parser = argparse.ArgumentParser(description="Unzip any type of files")
    parser.add_argument('filename', help="filename to unzip")
    path = parser.parse_args().filename
    filename = path.split("/")[-1].split(".",1)
    if len(filename)<2:
        print("Incorrect file type")
        return
    elif filename[1] == 'zip':
        if shutil.which("unzip") is None:
            try:
                subprocess.check_call("sudo pacman -S unzip".split())
            except subprocess.CalledProcessError as e:
                print("Error Occured")
        command = "unzip -qq {0}".format(path)
        try:
            subprocess.check_call(command.split())
        except subprocess.CalledProcessError as e:
            print("Error Occured")
    elif filename[1] == 'tar.gz':
        command = "tar -xf {0}".format(path)
        try:
            subprocess.check_call(command.split())
        except subprocess.CalledProcessError as e:
            print("Error Occured")
    elif filename[1] == 'tar.xz':
        command = "tar -xf {0}".format(path)
        try:
            subprocess.check_call(command.split())
        except subprocess.CalledProcessError as e:
            print("Error Occured")
    elif filename[1] == '7z':
        if shutil.which("7z") is None:
            try:
                subprocess.check_call("sudo pacman -S p7zip".split())
            except subprocess.CalledProcessError as e:
                print("Error Occured")
        command = "7z x {0}".format(path)
        try:
            subprocess.check_call(command.split())
        except subprocess.CalledProcessError as e:
            print("Error Occured")
    else:
        print("Unknown compression type")

if __name__ == "__main__":
    main()

