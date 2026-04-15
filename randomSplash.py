import random,os

folder = os.path.expanduser("~/terminalCustomSplash")
path = os.path.join(folder, "splashes.txt")

def readData():
    with open(path, "r") as f:
        data = f.read().split("\n")
    return data

def findSplash(data):
    for i in data:
        if i[0] == "#":
            data.remove(i)
            break
    return data

def choiceSplash(splashes):
    splash = random.choice(splashes)
    return splash

def saveData(data):
    risultatiPath = os.path.join(folder, "risultati.txt")
    with open(risultatiPath, "w") as f:
        f.write(data)

def main():
    data = readData()
    splashes = findSplash(data)
    splash = choiceSplash(splashes)
    saveData(splash)

if __name__ == "__main__":
    main()