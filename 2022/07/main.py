import re

def handle(line):
    pass

class Dir:

    def __init__(self, name, parent):
        self.name = name
        self.parent = parent
        self.directories = {}
        self.files = {}

    def cwd(self):
        if self.parent:
            return self.parent.cwd() + "/" + self.name
        else:
            return self.name

    def size(self):
        x = sum([d.size() for (_, d) in self.directories.items()])
        y = sum([s for (_, s) in self.files.items()])
        return x + y

    def solve1(self):
        sizes = [d.solve1() for (_, d) in self.directories.items()]
        size = self.size()
        if size > 100000:
            size = 0

        return sum(sizes) + size

    def solve2(self, totalSize):
        sizes = [d.solve2(totalSize) for (_, d) in self.directories.items()]
        size = self.size()
        if totalSize - self.size() > 40000000:
            size = float('inf')

        return min([size] + sizes)

root = None
cwd = None

for line in open("input", "r").readlines():
    a = re.search(r"\$ cd ([^\s]+)", line)
    if a:
        name = a.group(1)
        if name == "/":
            root = Dir("/", None)
            cwd = root
        elif name == "..":
            cwd = cwd.parent
        else:
            child = Dir(name, cwd)
            cwd.directories[name] = child
            cwd = child
        continue

    b = re.search(r"\$ ls", line)
    if b:
        continue

    c = re.search(r"dir ([^\s]+)", line)
    if c:
        # directory which exists but isn't traversed is not interesting for this problem
        continue

    d = re.search(r"([0-9]+) ([^\s]+)", line)
    if d:
        size = d.group(1)
        name = d.group(2)
        cwd.files[name] = int(size)
        continue

    print(None)

print(root.solve1())
print(root.solve2(root.size()))
