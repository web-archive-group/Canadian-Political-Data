# To Create Gephi Files for Visualization

Gephi files require CSV, TSV, etc.-type files (you can specify the delimeter). The most important is the first line. In general, I use:

Source	Target	Weight	Time Interval

Source, Target, Weight (cap sensitive) will map automatically to those categories. Time Interval you will have to map over manually to a Gephi Time Series. To do so, in the data laboratory, on the 'edges' you can select 'merge columns.' Select the Time Interval category, move it over to the right column, and select the Time Interval option from the drop-down menu below. This will create a new column in Gephi format.

To create labels, on the 'node' table you should copy 'id' to the 'labels' category. 
