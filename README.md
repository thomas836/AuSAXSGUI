Analyzing X-ray scattering interferometry data 

Materials
	Data set including scattering profiles form:
	Gold nanocrystal sample
	Double labelled sample
	Orthogonal single labelled samples (two individual scattering traces)
	Unlabelled sample
	Sample Buffer

	Computer (Minimum requirements: Any Intel or AMD x86-64 processor, 2.5 GB Disk space, 2 GB RAM)
	Matlab license
	Au-SAXS GUI (link to repository)

A step-by-step guide on how to obtain the scattering interference pattern IAu-Au including an example set of data (see exemplary Files) is given below.



Data preparation

1.	If not done automatically by software packages at the beamline reduce 2D scattering matrix obtained from the detector by radial averaging to a one-dimensional scattering
	profile. The output should be a matrix with two columns one featuring the scattering momentum q and another column with the corresponding scattering intensity. Usually a third column with the variance or standard deviation in measured scattering profiles is also provided by the beamline. It is important to pay attention to the definition of scattering momentum q as there are two different ones. In this protocol q is given by 4pi*sin(omega/lambda), where  is the X-ray wavelength and  is half the scattering angle. Moreover, q can be in units of Å^-1 and nm^-1 whereas q is in Å^-1 in this protocol. 

2.	Before starting the custom written au_saxs_gui.m GUI and loading the data, create one file for each exposure and per sample type with nomenclature equal to the test files 
	‘*_i.dat’ where * is any name for the sample and i the ith exposure i.e. ranging from 01 to 10 for 10 exposures per molecule (‘AB_01.dat’, ‘AB_02.dat’, ‘AB_03.dat’, …, for double labelled samples). Design the file such that the scattering momentum vector occupies the first column, the corresponding recorded scattering intensity the second column and the variance/standard deviation the third column all separated by a single blank (see example files for comparison).

3.	Initialize the GUI by executing the ‘au_saxs_gui.m’ script. For proper execution the files ‘au_saxs_gui.m’, ‘au_saxs_gui.fig’ and the folder ‘subroutines’ have to be stored 
	in the same directory to allow the main script to find the required subroutines.

Data initialization

4.	Enter the full path into the field ‘Data path’.

5.	Optional: Manipulate the scattering momentum by setting the lower (qmin) and the upper (qmax) limit for the scattering angle. The default input is the 35th data point of 
	the initial data up to data point 500, however this strongly depends on the settings of the beamline and the type of sample.

6.	Optional: Untick the ‘Data is in q’ box to switch the scattering momentum vector to S (2sin(omega/lambda) in Å^-1).
	Note: The scattering momentum vector is set to q per default (4pi*sin(omega/lambda), in Å^-1). 

7.	Optional: Modify the number of samples (default is 5 for one full set of samples) if required.

8.	Optional: Change the number of exposures (default is 10 as described in the protocol) the number of files read per sample.

9.	Press ‘Ok’ to initialize the script. After doing so new buttons and a table will appear on the left side of the window.

10.	Enter all sample names in the first column of the table.

11.	Enter the corresponding buffer in the second column.

12.	Enter the determined sample concentration (in µM) in the third column

13.	Optional: Enter save names for all samples in the fourth column.

14.	Load the data files by pressing the ‘Load data files’ button. After successfully doing so, a window indicating ‘All data was successfully imported!’ will be displayed. In 
	case a file couldn’t be found or a wrong sample name was entered a warning will be generated pointing to the false position. Moreover, if the concentration wasn’t entered properly a similar error message will be produced.


Data testing

15.	Optional: Inspect the scattering profiles for all samples either by plotting all exposures per sample as individual traces into one figure per sample or by plotting the 
	averaged profile over all exposures.
16.	Optional: Overlay these plots by pressing the ‘Plot sample data’ first and the ‘Plot mean data’ second.

17.	Optional: Plot the averaged buffer for each sample using the ‘Plot buffer’ button. Optional: In case to many MATLAB figures are open, close all except for the main GUI by 
	pressing the ‘Close Figures’ button.

18.	Optional: Save the scattering data for all loaded samples as ‘savename_scattering_data.mat’ files using ‘Save data’.



Maximum entropy fitting

19.	Set the options by specifying the sample positions according to the row number in the table, i.e. Gold sample position = 1, A-label sample position = 2, B-label sample 
	position = 3, Double-label sample position = 4 and Unlabeled sample position = 5.

20.	Optional: Change the number of runs for the maximum entropy fit (default is 10). The output is one high-resolution distance distribution per run. Average the distributions 
	over all runs to obtain the final distribution. Lower the number to shorten the required computational time for test purposes.

21.	Optional: Change the minimization function option to extract the gold-gold interference pattern IAu-Au (default is 5 ranging from 1 to 7, see Troubleshooting for more 
	details)

22.	Start the maximum entropy fit pressing ‘Max Entropy fit’. A progress bar in the lower left corner of the main GUI will display the progress and vanish as soon as the 
	calculations are finished. Three new figures showing the gold nanocrystal radius distribution, the gold-gold scattering interference signal IAu-Au and the final distance distribution determined via the maximum entropy fit will appear.

23.	Enter a save name for the distance distribution (Save Max Entropy Data, right side). This file has one column per maximum entropy run (10 as default) and a 1 Å spaced 
	distance distribution ranging from 1 Å up to 200 Å. 

24.	After setting the name, press ‘Save data’ (Save Max Entropy Data, right side) a file in the format of ‘savename_Distance_Distribution.mat’ will be saved in your current 
	folder.
	Optional: Save the gold nanocrystal radius distribution and/or the Au-Au interference pattern IAu-Au checking the individual boxes.
