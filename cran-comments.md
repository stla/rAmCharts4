This is a resubmission. The previous one has been archived. I removed the line 
'LazyData: true' from the DESCRIPTION file. It seems this was the cause of the 
error. I tried `devtools::check_win_devel()` but this does not seem to work.


## Test environments

* ubuntu 18.04, R 3.6.3


## R CMD check results

OK
