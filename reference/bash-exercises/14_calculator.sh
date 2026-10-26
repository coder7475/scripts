#!/bin/bash

add() {
    echo $(($1 + $2))
}

subtract() {
    echo $(($1 - $2))
}

multiply() {
    echo $(($1 * $2))
}

divide() {
    if [ $2 -eq 0 ]; then
        echo "Error: Division by zero"
        return 1
    fi
    echo $(($1 / $2))
}

echo "Enter first number: "
read num1
echo "Enter second number: "
read num2
echo "Enter operation (+, -, *, /): "
read op

case $op in
    +) result=$(add $num1 $num2);;
    -) result=$(subtract $num1 $num2);;
    *) result=$(multiply $num1 $num2);;
    /) result=$(divide $num1 $num2);;
    *) result="Error: Invalid operation";;
esac

echo "Result: $result"
