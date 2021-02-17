# BCA to YNAB converter v1.0
This ruby script converts the CSV file from Bank Central Asia (BCA) to a file able to be imported by You Need a Budget (YNAB) app.
Created by sarahsau (itsme@sarahsausan.com) in 2020; Forked from wesmcouch (wesmcouch@gmail.com).

## Download the BCA e-statement and put it in the script directory
1. Login to klikBCA
2. Go to Account Information > Account Statement
3. Select the period of transactions that you want to import to YNAB   
4. Click *Statement Download*, that will download the statement file in csv format.
5. Put the file in the script directory

Note: v1.0 assumes that all the downloaded transactions occured within the same year.
If you want to import transactions that occured in different year (e.g. 20 Dec 2019 - 5 Jan 2020), split the statement download into multiple files according to the year.

## Install Ruby
If you haven't gotten Ruby installed, please do so.

## In your console, navigate to the script directory , then run the following command
```
 ynab_BCA_converter.rb [statement_from_klikBCA].csv [converted_file_name].csv year_of_the_statement
```
[statement_from_klikBCA] is the file name of the statement you downloaded from klikBCA.
Put it in the directory you're in for simpler access.

[converted_file_name] is the file name for the conversion result.
By default the file name is *converted_result.csv*. It will be written in the directory you're in.

<year_of_the_statement> is the year the transactions occured.

Example:

```
ynab_BCA_converter.rb JOHNDOE19062024.csv result.csv 2020
```

## Import the result to YNAB
The resulting CSV will be generated in the directory. When you import to YNAB, select DD/MM/YYYY as the date format.
