# g_analysis-package-final-version
The package needed to fit arm_data to arm (also known as accz)

Uses the model for the physical pendulum and the Matlab lsqcurvefit function to fit and calculate the fit parameters and chisquare goodness of fit
The standard deviation I used was from Exp5 (control). The value shows up in the final_g_analysis script at the end as std = 0.0123.

The fitter will automatically cut the data to a minimum.

Also note that the initial position I refer to is not the initial point at which the pendulum is let go, but instead is an aribitrary minimum of the arm_data the user choosed.

To see this package in action, simply download all the files into your MATLAB folder and run the final_g_analysis script.
Enter the length of the pendulum as 1283mm when the script asks for that input, as the was the length of the pendulum from which the arm_data_short.mat was from.


# HOW TO USE

PART 1 file naming
In order to use this package, the user has to name the matlab files names and variables names to match the code.

You should have
1) Actual data spreadsheet
2) Control data spreadsheet

From the Rpi, one should be able to extract a csv file much like the INT_EXP6 file in the package.
From here one needs to make three .mat files
1) arm_data_unprocessed
2) arm_data_control
3) distance_data

First import the csv from your experiment
to make arm_data_unprocessed, pull the 9DOF time from the file and rename it td, and then pull the acc_z and rename it arm_data, then convert both to arrays using the table2array( ) command in the console (enter td = table2array(td), same for arm_data). Also make sure to delete the first entry from both arrays as the first entry is the labeling cell in the spreadsheet (done with td(1) = [], and arm_data(1) = []).

Then enter td = td'  and  arm_data = arm_data' to make them horizontal arrays, you should have something like this in your workspace
arm_data  1x34270 double
td        1x34270 double

then type save('arm_data_unprocessed') into the console and you should have a file that loads that td and arm_data when you load 'arm_data_unprocessed'

Now clear your workspace so that it has no varaibles in it (type "clear" in console)

To make arm_data_control 
import your control data csv
Repeat the same process as before, import 9DOF time and name it "td" then use table2array( ) on it
This time after importing acc_z from the spreadsheet, name it "arm_data_control" instead
make sure the arrays are horizontal arrays
then save the file via save('arm_data_control') in the console

clear you workspace again


Now to make distance_data file
From your actual data spreadsheet, again import 9DOF time and save it as td and use td = table2array(td)
then import the d(mm) column from the spreadsheet and save it as d_data and use table2array( ) command on it
make sure both are horizontal arrays
and that the first entry is not NaN, if it is, delete it
save('distance_data')

clear you workspace again by typing clear into the console.



PART 2 using the software
making sure you have the three matlab files from PART 1, proceed to fit the data by typing "[p] = Final_g_analysis(30,100)" 
the 30,100 here can be other numbers, this is just an example
it means cut the data beginning at the 30-th minimum and ending at the 30+100-th minimum (100 here is the amount of minimums you want to contain)
Enter the length of the pendulum in mm
type true or false if you want to fit the rolling average of the data or not
now just wait for around 40 seconds or so
the console should print the g B C and vertical shift S value
the chi2 value and chi2perdof and the least square residual
 
you should also a p array which is a list of 8 numbers, this tells you the g B C S and best fit initial conditions

the reading order for p is
g B S vx0 vy0 z0 vz0 C

