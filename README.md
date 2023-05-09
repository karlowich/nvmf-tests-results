# Testing and Results 
## from Streamlining the NVMe-oF data path

This repository contains the scripts used for testing and the results of said testing.
**Make sure to read each script before running it, as some scripts require modifications to work properly.**

### Setup
To use the scripts in this repository start by creating a new folder, and then run the script `build.sh** inside it.
This will set up the libraries required for testing.

### Tests
Once the libraries are set up and installed, you can proceed to run the tests.
**Again, make sure to read the scripts before running them.**


The folder `target` contains the scripts used for setting up the NVMe-oF target.
The folder `tests` contains the scripts for running the actual fio tests.

### Results
The results from when I ran the tests can be seen in the file `results.csv`.
The left most column describes the name of the test and which scripts were used for the results.

### Perf
The scripts used to generate the flamegraphs can be found in the folder `perf`.
To generate your own flamegraph follow these steps:
- Run a script from the `perf` folder
- Clone the flamegraph repository: `git clone https://github.com/brendangregg/FlameGraph`
- Copy the output of the first step into the `FlameGraph` folder: `cp perf.data FlameGraph`
- Change directory to the `FlameGraph` folder: `cd FlameGraph`
- Generate the flamegraph: `perf script | ./stackcollapse-perf.pl |./flamegraph.pl > perf.svg`
- View the `.svg` file in your browser etc.
