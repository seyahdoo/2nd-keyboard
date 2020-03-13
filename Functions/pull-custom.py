
import os
path = "C:\\CODE_SEGMANT\\"
for folder in os.listdir(path):
    folder_path = os.path.join(path, folder)
    print("doing for")
    print(folder_path)
    os.system("git -C {} -c diff.mnemonicprefix=false -c core.quotepath=false submodule update --init --recursive --remote --merge".format(folder_path))


