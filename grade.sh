CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

file=`find ./student-submission -name "ListExamples.java"`
echo $file

if [[ -f $file ]]
then 
    echo "Checking file: " $file
else
    exit 1;
fi


cp ./student-submission/ListExamples.java ./grading-area/
cp ./TestListExamples.java ./grading-area/
cp -r ./lib ./grading-area/



cd ./grading-area/

javac -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" *.java 2> error_output.txt
java -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples > result.txt

line=`grep "Tests run:" result.txt`
if [ -z "$line" ]
then
 score=100
 else
 False=${line:25:1}
 Total=${line:11:1}
 score=$(($(($Total-$False))*100/$Total))
 fi
 echo "Your score: " $score;

