import UIKit

var greeting = "Hello, playground"
func fizzBuzz(_ input: Int) -> String{
    if input % 3 == 0 && input % 5 == 0{
        return "Fizz Buzz"
    }else if input % 3 == 0 {
        return "Fizz"
    }else if input % 5 == 0 {
        return "Buzz"
    }
    else{
        return "\(input)"
    }
}

 print (fizzBuzz(3))
print (fizzBuzz(5))
print (fizzBuzz(15))
print (fizzBuzz(16))
