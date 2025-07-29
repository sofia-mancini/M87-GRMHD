import glob
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import sys
sys.path.append("/work/pi_gkhanna_uri_edu/Sofia")
from QuickImageStats.quick_analysis import quick_analysis

h5_files = sorted(glob.glob("ipole_images-1/*.h5"))

data = []

for fn in h5_files:
    metrics = quick_analysis(fn, verbose=False)
    betas = metrics['betas']
    b1 = abs(betas[1])
    b2 = abs(betas[2])
    b3 = abs(betas[3])
    b4 = abs(betas[4])
    b5 = abs(betas[5])
    beta_sum = np.sum(np.abs(betas))

    data.append({
        'filename' : fn,
        'b1' : b1,
        'b2' : b2,
        'b3' : b3,
        'b4' : b4,
        'b5' : b5,
        'b2/b1' : b2/b1 if b1 != 0 else np.nan,
        'b2/sum_betas' : b2/beta_sum if beta_sum != 0 else np.nan,
        'm_net' : metrics['m_net'],
        'm_avg' : metrics['m_avg'],
        'v_net' : metrics['v_net'],
        'v_avg' : metrics['v_avg']
    })

df = pd.DataFrame(data)

df.to_csv("metrics_values.csv", index=False)