import numpy as np
import h5py
import os
from subprocess import call
import sys

def average_hdf5_data(listOfFiles, output, keys_to_average=None):

	if keys_to_average is None:
		keys_to_average = ['Ftot', 'Ftot_unpol', 'Mdot', 'Ladv', 'nuLnu', 'nuLnu_unpol', 'pol', 'tau', 'unpol']

	if os.path.exists(output):
		print(f" - cannot create output file, already exists: {output}")
		sys.exit(-1)

	#Open files, sum data, divide by number of files later.
	count = 0
	data = {}
	for ifname in listOfFiles:
		print(f" - loading {ifname}")
		hfp = h5py.File(ifname, 'r')
		for key in hfp.keys():
			if key not in keys_to_average:
				continue
			tdata = np.array(hfp[key])
			if key not in data:
				data[key] = np.zeros_like(tdata)
			data[key] += tdata
		hfp.close()
		count += 1

	#Copy most of the file from the first one in the list.
	print(f" - writing output file {output}")
	call(['cp', listOfFiles[0], output])

	#Then, replace the averaged keys with their average values.
	ohfp = h5py.File(output, 'r+')
	for key in keys_to_average:
		if key in ohfp:
			del ohfp[key]
	for key in data:
		ohfp[key] = data[key] / count
	ohfp.close()

if __name__ == "__main__":
	ofname = sys.argv[1]
	ifnames = sys.argv[2:]
	average_hdf5_data(ifnames, ofname)
