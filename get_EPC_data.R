# get_EPC_data - data functions used in the plotting scripts
#
# this function downloads zip file
download_EPC_data <- function(furl,dest_file){
        download.file(furl,destfile=dest_file,method="curl");
}

# this function checks to see that zip file is present and/or unzips if needed
check_EPC_data <- function(furl,dest_file,data_file){
        # check for previously created zip data file, if not there, download and unzip
        if (!file.exists(dest_file)){
                download_EPC_data(furl,dest_file)
                unzip(dest_file)
        } else {
                # also check for unzipped data files, if not present unzip 
                if (!file.exists(data_file)) {
                        unzip(dest_file);
                }
        }
}

# This functions subsets for the desired dates
#
# Need to have the following package installed 
# http://cran.r-project.org/web/packages/sqldf/index.html
# see http://cran.r-project.org/web/packages/sqldf/sqldf.pdf
#
# load the sqldf library 
library(sqldf)
# subset for the desired date
subset_EPC_data <- function(x){
        # Use read.csv.sql - Read File Filtered by SQL
        data <- read.csv.sql(x, 
                sql = 'select * from file where Date == "1/2/2007" OR Date == "2/2/2007"', 
                header = TRUE, 
                sep = ";")
        closeAllConnections()
        return(data)
}