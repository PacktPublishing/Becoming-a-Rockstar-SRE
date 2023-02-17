import warnings
warnings.simplefilter("ignore", category=PendingDeprecationWarning)
warnings.simplefilter("ignore", category=DeprecationWarning)
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import colors
import csv
import sys
import datetime

# Global variables
date_time = 0
datetime_str = ""
dist = []

# Read CSV file passed as the first argument
with open(sys.argv[1], mode='r') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
            line_count += 1
        date_time = datetime.datetime.fromtimestamp(int(row["timestamp"]))
        datetime_str = date_time.strftime("%Y - %m - %d  %H : %M : %S")
        print(f'\tAt {date_time}: Configuration item: {row["configuration_item"]} - Metric: {row["metric"]} - Value: {row["value"]} {row["unit"]}.')
        # Append the metric value to the dist array
        dist.append(int(row["value"]))
        line_count += 1
    print(f'Processed {line_count} lines.')

# Display the distribution
print("Distribution: ", dist)
# Calculate the percentile of read sample
P = 50
percentile = np.percentile(dist, P)
print(P,"-th Percentile: ", percentile)
# Compute the histogram and plot it
N, bins, patches = plt.hist(dist, bins=20)
# Colors the histogram
fracs = N / N.max()
norm = colors.Normalize(fracs.min(), fracs.max())
for thisfrac, thispatch in zip(fracs, patches):
    color = plt.cm.viridis(norm(thisfrac))
    thispatch.set_facecolor(color)
# Format the graph
plt.grid(axis='y', alpha=0.75)
plt.xlabel(row["metric"]+ ' in ' + row["unit"])
plt.ylabel('Frequency in occurrences')
plt.title(row["configuration_item"])
plt.show()
