# BCA to YNAB converter v2.0
This ruby script converts the CSV file from Indonesian banks to a file able to be imported by You Need a Budget (YNAB) app. Currently supporting:
- Bank Central Asia (BCA)
- Bank Negara Indonesia (BNI)

## 1. Install Ruby version 2.6.0 or newer
Follow instructions in https://www.ruby-lang.org/en/downloads/. Make sure Ruby is properly installed by sending `ruby -v`in your terminal - it should returns the installed version of Ruby.

## 2. Download this script, then put your bank statements in the same folder.
 See [statement download instructions](#statement-download-instructions) below.

## 3. In your Terminal (Linux), Bash shell (Mac), or PowerShell (Windows)...

Navigate to the script directory (`cd [directory]`), then run the following command:

**For BCA**
```
 ruby indo2ynab.rb BCA [statement_from_klikBCA].csv [converted_file_name].csv year_of_the_statement
```
Example:
```
ruby indo2ynab.rb BCA JOHNDOE19062024.csv result.csv 2020

```

**For BNI**

```
 ruby indo2ynab.rb BNI [statement_from_BNI].pdf [converted_file_name].csv
```
Example:
```
ruby indo2ynab.rb BNI JOHNDOE19062024.csv result.csv

```

## 4. Import the result to YNAB
The resulting CSV will be generated in the directory.
When you import to YNAB, select DD/MM/YYYY as the date format.


# Statement Download Instructions

BCA:
1. Login to klikBCA
2. Go to Account Information > Account Statement
3. Select the period of transactions that you want to import to YNAB   
4. Click *Statement Download*, that will download the statement file in csv format.

BNI:
1. Login to BNI Internet Banking
2. Go to Rekening > Mutasi Tabungan dan Giro
3. Select your account and put your query criteria, then select *Histori Transaksi*  
4. Download to a PDF file
