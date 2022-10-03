import warnings
warnings.simplefilter("ignore", category=PendingDeprecationWarning)
warnings.simplefilter("ignore", category=DeprecationWarning)
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import colors

np.printoptions(precision=3)
np.random.default_rng(1234567)
# Draw samples from the Laplace or double exponential distribution with specified location (or mean) and scale (decay).
# https://numpy.org/doc/stable/reference/random/generated/numpy.random.Generator.laplace.html
dist = np.random.default_rng().laplace(loc=15, scale=3, size=5000)

# Compute the arithmetic mean along the specified axis.
am = np.mean(dist)
# Compute the weighted average along the specified axis.
wm = np.average(dist)
# Compute the standard deviation along the specified axis.
std = np.std(dist)

# Compute the q-th quantile of the data along the specified axis.
# https://numpy.org/doc/stable/reference/generated/numpy.quantile.html
q99 = np.quantile(dist, 0.99)
# Compute the q-th percentile of the data along the specified axis.
# https://numpy.org/doc/stable/reference/generated/numpy.percentile.html
p85 = np.percentile(dist, 85)

# Display outputs
print(dist[:5])
print("99th quantile: ", q99)
print("85th percentile", p85)
print("Arithmetic mean: ",am)
print("Weighted mean: ",wm)
print("Standard Deviation: ", std)

# Compute the histogram of a dataset.
# https://numpy.org/doc/stable/reference/generated/numpy.histogram.html
hist, bin_edges = np.histogram(dist, density=True)
print("Histogram values: ",hist[:20])
print("Histogram bin edges: ",bin_edges[:20])

# matplotlib.axes.Axes.hist
# Compute and plot a histogram.
# This method uses numpy.histogram
N, bins, patches = plt.hist(dist, bins=30, density=True)
# Colors the histogram
fracs = N / N.max()
norm = colors.Normalize(fracs.min(), fracs.max())
for thisfrac, thispatch in zip(fracs, patches):
    color = plt.cm.viridis(norm(thisfrac))
    thispatch.set_facecolor(color)
# Format the graph
plt.grid(axis='y', alpha=0.75)
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram')
plt.show()
