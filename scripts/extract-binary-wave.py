import matplotlib.pyplot as plt

SIGNAL_LEN, SYMBOL_LEN = 34000, 200
FILE, SIGNAL_OFFSETS = "door-868_638MHz-2MSps-2MHz.raw", [1800, 856160, 1647990, 2502620, 3294230, 4148780, 6492690, 7346924, 8074610, 8865950, 9594836, 10323672]
# FILE, SIGNAL_OFFSETS = "camera-868_638MHz-2MSps-2MHz.raw", [1200, 832154, 1652890, 2453560, ]

with open(FILE, "rb") as f:
  signal = [b if b < 128 else b - 256 for b in f.read()]

for i, offset in enumerate(SIGNAL_OFFSETS):
  xs = range(offset, offset + SIGNAL_LEN, SYMBOL_LEN)
  plt.scatter(xs, [0 for _ in xs], c="red")
  bits = "".join(['1' if signal[x] > 0 else '0' for x in xs])
  print(f"Packet {str(i).ljust(2)} =", hex(int(bits, 2)))

plt.plot(signal)
plt.show()
