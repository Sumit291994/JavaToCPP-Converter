validate:
	lex classes.l
	yacc -d classes.y
	gcc -o valid y.tab.c

convert: validate
	lex convert.l
	gcc -o convert lex.yy.c -ll

check:
	./valid < Classes/class.java >> validity.txt
check1:
	./valid < Classes/class1.java >> validity.txt
check2:
	./valid < Classes/class2.java >> validity.txt
check3:
	./valid < Classes/class3.java >> validity.txt
check4:
	./valid < Classes/class4.java >> validity.txt
check5:
	./valid < Classes/class5.java >> validity.txt 
check6:
	./valid < Classes/class6.java >> validity.txt 
check7:
	./valid < Classes/class7.java >> validity.txt 
check8:
	./valid < Classes/class8.java >> validity.txt 


run:
	./convert < Classes/class.java > Classes/output.cpp
run1:
	./convert < Classes/class1.java > Classes/output1.cpp
run2:
	./convert < Classes/class2.java > Classes/output2.cpp
run3:
	./convert < Classes/class3.java > Classes/output3.cpp
run4:
	./convert < Classes/class4.java > Classes/output4.cpp
run5:
	./convert < Classes/class5.java > Classes/output5.cpp
run6:
	./convert < Classes/class6.java > Classes/output6.cpp
run7:
	./convert < Classes/class7.java > Classes/output7.cpp
run8:
	./convert < Classes/class8.java > Classes/output8.cpp

runtest:
	@read -p "Enter Class Name : " module; \
	echo $$module;


