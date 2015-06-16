for I in selenium-* ; do 
 cd $I; 
  ./build $1; 
 cd ../; 
done
