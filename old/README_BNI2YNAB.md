# BNI to YNAB converter v1.0
This ruby script converts PDF file from Bank Negara Indonesia (BNI) to a CSV file able to be imported by You Need a Budget (YNAB) app.
Created by sarahsau (itsme@sarahsausan.com) in 2020; Forked from kei178.

## Download the BNI PDF statement and put it in the script directory
1. Login to BNI Internet Banking
2. Go to Rekening > Mutasi Tabungan dan Giro
3. Select your account and put your query criteria, then select *Histori Transaksi*  
4. Download to a PDF file
5. Put the file in the script directory

## Install Ruby
If you haven't gotten Ruby installed, please do so.

## In your console, navigate to the script directory, then run the following command:
```
 ynab_BNI_converter.rb [statement_from_BNI].pdf [converted_file_name].csv
```
[statement_from_BNI] is the file name of the statement you downloaded from BNI.
Put it in the directory you're in for simpler access.

[converted_file_name] is the file name for the conversion result.
By default the file name is *BNI_converted_result.csv*. It will be written in the directory you're in.

Example:
```
ynab_BNI_converter.rb JOHNDOE19062024.pdf result.csv
```

## Import the result to YNAB
The resulting CSV will be generated in the directory.
When you import to YNAB, select DD/MM/YYYY as the date format.
