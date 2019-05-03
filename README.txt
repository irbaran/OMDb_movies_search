OMDb Movies Search 

The project was developed using Cygwin 64bits (GNU and Open Source tools).
Main libraries using in development: curl and rapidjson 
Database used: API RESTful OMDb (http://www.omdbapi.com/)

Included files in GitHub repository:
- movies.cpp
- movies_cygwin.exe
- movies_UnitTest_BashLinux.sh
- README.txt


Project compilation line (from Cygwin prompt):
g++ -v movies.cpp -o movies_cygwin.exe -lcurl

Project unit test call (from Cygwin prompt):
./movies_UnitTest_BashLinux.sh

Expected results for unit test run:
--------------------------------------------------
Unit Test Results:
--------------------------------------------------
Number of tests                       : 98
Number of tests successfully executed : 98
Number of tests executed with errors  : 0
Unit Test elapsed 36 seconds.


