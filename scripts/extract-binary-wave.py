import matplotlib.pyplot as plt

SIGNAL_LEN, SYMBOL_LEN = 34000, 200
FILE, SIGNAL_OFFSETS = "door-868_638MHz-2MSps-2MHz.raw", [1800, 856160, 1647990, 2502620, 3294230, 4148780, 6492690, 7346924, 8074610, 8865950, 9594836, 10323672]
# FILE, SIGNAL_OFFSETS = "camera-868_638MHz-2MSps-2MHz.raw", [1200, 832154, 1652890, 2453560, ]

with open(FILE, "rb") as f:
  signal = [b if b < 128 else b - 256 for b in f.read()]

for i, offset in enumerate(SIGNAL_OFFSETS):
  bit_coords = range(offset, offset + SIGNAL_LEN, SYMBOL_LEN)
  bit_str = "".join(['1' if signal[i] > 0 else '0' for i in bit_coords])
  print(f"Packet {str(i).ljust(2)} =", hex(int(bit_str, 2)))
  plt.scatter(bit_coords, [0 for _ in bit_coords], c="red")

plt.plot(signal)
plt.show()
