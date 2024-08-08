1. Redirection

Every program we run on command line has 3 data streams:
- STDIN (0) - Standard input (data provided to the program)
- STDOUT (1) - Standard output (what program prints, by default on the terminal)
- SRDERR (2) - Standard error (what error messages program prints, either in terminal   or a log file)

Examples:

cat file1.txt >output_from_cat.txt

cat file1.txt 1>output_from_cat.txt  (we specify the number of stream, 1 for STDOUT)

cat file1.txt 2>errors.txt

cat file1.txt 1>output_from_cat.txt 2>errors.txt #we redirect to different files

cat file1.txt &>output_from_cat.txt  (redirect both outputs to same file)


> - rewrites file or creates it if it does not exist
>> - append to file

2. Piping

A pipe sends data from one program to another (STDOUT into STDIN)

cat file.txt | wc -l (wc -l <file.txt)

cat file.txt | head -5 | tail -3 | wc -l
# open contents of file.txt -> read only the first 5 lines -> read the last 3 lines -> count the lines remaining
