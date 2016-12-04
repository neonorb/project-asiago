#!/bin/bash

TIME=30

#echo "" > mish.benchmark-cache

cat <<EOF > /tmp/c.c
#include <iostream>
int main() {
    while(true) {
        std::cout << "*";
    }
    return 0;
}
EOF
g++ /tmp/c.c -o /tmp/c
chmod +x /tmp/c
timeout $TIME /tmp/c > /tmp/c.out
echo "C control: $(wc -c /tmp/c.out | awk '{print $1;}')" #>> mish.benchmark-cache
echo "" #>> mish.benchmark.cache

cat <<EOF > /tmp/Java.java
public class Java {
    public static void main(String[] args) {
        while(true) {
            System.out.print("*");
        }
    }
}
EOF
javac -cp /tmp /tmp/Java.java
timeout $TIME java -cp /tmp Java > /tmp/java.out
echo "Java control: $(wc -c /tmp/java.out | awk '{print $1;}')" #>> mish.benchmark-cache
echo "" #>> mish.benchmark.cache

timeout $TIME python3 -c "while True:print('*', end=\"\")" > /tmp/py.out
echo "Python control: $(wc -c /tmp/py.out | awk '{print $1;}')" #>> mish.benchmark-cache
echo "" #>> mish.benchmark.cache

for c in $(seq 0 1 0)
do
    make clean
    CACHE_LENGTH=$c make mish-linux
    timeout $TIME ../mish-linux/build/mish -c "while(true){__print('*')}" > /tmp/mish.out
    echo "$c $(wc -c /tmp/mish.out | awk '{print $1;}')" #>> mish.benchmark-cache
done
