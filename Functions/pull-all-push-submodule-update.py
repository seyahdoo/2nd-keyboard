import subprocess
import os
from typing import List

nothing_to_commit_msg = "nothing to commit, working tree clean"


class ConsoleColors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def strip(l):
    return list(filter(None, l))


def run(cmd: List[str]) -> str:
    command_string: str = os.getcwd()
    command_string += "\\"
    for i in cmd:
        command_string += i
        command_string += " "
    print(f"{ConsoleColors.WARNING}{command_string}{ConsoleColors.ENDC}")
    result_str: str = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode('utf-8')
    print(result_str)
    return result_str


def smart_pull_repo(repo_path: str):
    wd = os.getcwd()
    os.chdir(repo_path)

    # if change in repo, push to stash
    result_str = run(['git', 'status', '--ignore-submodules=all'])
    changes_exist = nothing_to_commit_msg not in result_str
    if changes_exist:
        run(['git', 'add', '.'])
        run(['git', 'stash'])

    # pull changes on repo
    run(['git', 'fetch'])
    run(['git', 'checkout', 'master'])
    run(['git', 'pull'])

    # get submodules
    result_str = run(['git', 'submodule'])
    submodules = strip(result_str.split('\n'))
    submodules = [strip(i.split(' '))[1] for i in submodules]

    # for each submodule
    for submodule in submodules:
        submodule_path = os.path.join(repo_path, submodule)
        smart_pull_repo(submodule_path)

    # commit submodule updates
    run(['git', 'add', '.'])
    run(['git', 'commit', '-m', 'submodule update'])

    # push submodule updates
    run(['git', 'push'])

    # if change in mother repo, pop from stash
    if changes_exist:
        run(['git', 'stash', 'pop'])

    # DONE
    os.chdir(wd)
    return


def main():
    path = os.getcwd()
    for repo in os.listdir(path):
        repo_path = os.path.join(path, repo)
        smart_pull_repo(repo_path)
    return


if __name__ == "__main__":
    main()
