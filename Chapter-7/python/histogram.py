import warnings
warnings.simplefilter("ignore", category=PendingDeprecationWarning)
warnings.simplefilter("ignore", category=DeprecationWarning)
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import colors

np.printoptions(precision=3)
np.random.default_rng(1234567)
dist = np.random.default_rng().laplace(loc=15, scale=3, size=5000)

q99 = np.quantile(dist, 0.99)
p85 = np.percentile(dist, 85)
m = np.median(dist)
std = np.std(dist)

print(dist[:5])
print("99th quantile: ", q99)
print("85th percentile", p85)
print("Median: ",m)
print("Standard Deviation: ", std)

hist, bin_edges = np.histogram(dist, density=True)

print(hist[:20])
print(bin_edges[:20])

N, bins, patches = plt.hist(dist, bins=30, density=True)
fracs = N / N.max()
norm = colors.Normalize(fracs.min(), fracs.max())
for thisfrac, thispatch in zip(fracs, patches):
    color = plt.cm.viridis(norm(thisfrac))
    thispatch.set_facecolor(color)
plt.grid(axis='y', alpha=0.75)
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram')
plt.show()
