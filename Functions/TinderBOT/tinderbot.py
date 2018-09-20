import os
import time
import random
import re
import atexit

def sendSystemCommand(command):
    os.system('{} > tmp'.format(command))
    return open('tmp', 'r').read()


def returnDevices():
    Devices = sendSystemCommand('adb devices')
    return re.findall('\n(\w+)', str(Devices))


def currentApps(device):
    return sendSystemCommand('adb -s {} shell dumpsys activity'.format(device))


def ForceClose(udid, app):
    sendSystemCommand('adb -s {} shell am force-stop {}'.format(udid, app))


def startApp(device, app):
    sendSystemCommand('adb -s {} shell monkey -p {} -c android.intent.category.LAUNCHER 1'.format(device, app))


def randomBounds(like):
    coords = tuple([100,250,660,800])
    StartYBound = str(random.randint(coords[1], coords[3]))
    StartXBound = str(float(random.randint(coords[0], coords[2])) / 5)
    EndXBound = str(coords[2] - int((float(random.randint(coords[0], coords[2])) / 5)))
    EndYBound = str(random.randint(coords[1], coords[3]))
    if like == True:
        return (StartXBound, StartYBound, EndXBound, EndYBound)
    else:
        return (EndXBound, StartYBound, StartXBound, EndYBound)


def deleteTmp():
    if os.path.exists("tmp"):
        os.remove("tmp")

atexit.register(deleteTmp)		

if __name__ == "__main__":
    for device in returnDevices():
        startApp(device, 'com.tinder')
        time.sleep(5)
        os.system('adb -s {} shell input tap 304 92'.format(device))
        time.sleep(1)
        while 'com.tinder' in currentApps(device):
            bounds = randomBounds(True)
            os.system('adb -s {} shell input swipe {}'.format(device, ' '.join(bounds)))
            time.sleep(random.uniform(0, 0.2))

