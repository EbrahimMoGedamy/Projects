import UIKit
import Foundation

func summitionNumbers(n1: Int , n2 : Int) -> Int{
    return n1 + n2
}

var sum = summitionNumbers
//sum(10, 10)
sum(10, 10)

//MARK:- Shapes OF Closure
//: ###  Shape:1
//var numSummitionClosure : (Int , Int) -> Int = { (n1: Int , n2 : Int) in
//    return n1 + n2
//}

//: ###  Shape:2
//var numSummitionClosure = { (n1: Int , n2 : Int) in
//    return n1 + n2
//}

//: ###  Shape:3
var numSummitionClosure : (Int , Int) -> Int = { $0 + $1}
numSummitionClosure(1,2)


//MARK:- Closure With String

func callString () -> String{
    return  "Hello , Hema"
}

//MARK:- Shape OF Closure With String
//: ###  Shape:1
//var callStringWithClosure1  : () -> String = { () in
//      "Hello , Hema"
//}
//: ###  Shape:2
//let callStringWithClosure  : () -> String = { () in
//    return "Hello , Hema"
//}
//: ###  Shape:3
var callStringWithClosure  : (_ name : String) -> String = { "Hello ,\($0)" }
//print(callStringWithClosure("Ebrahim"))

//MARK:- Return Closure
//: ### Return Closure Indirectly

func returnClosureIndirectly() -> ((Int ,Int) -> Int){
    return numSummitionClosure
}
//: ### For Displaying Values
//: ### method : 1
//print(returnClosureIndirectly()(10, 10))
//: ### OR
//: ### method : 2
let returnedClosure = returnClosureIndirectly()
//print(returnedClosure(10, 10))

//: ### Return Closure Directly
func returnClosureDirectly() -> ((Int ,Int) -> Int){
//    return { (num1, num2 ) in num1 + num2 }
    return { $0 + $1 }
}

let returnedClosureDirectly = returnClosureDirectly()
//print(returnedClosureDirectly(10,14))

//: ### Pass Closure Block like : { $0 + $1 }

func insertClosureBlock(closureBlock : (_ name : String) -> String ){
    print(closureBlock("Mo"))
}
//: ### Pass Closure Indirectly
//insertClosureBlock(closureBlock: callStringWithClosure)

//: ### Pass Closure Directly
//insertClosureBlock(closureBlock: {_ in return "Assad"})
//insertClosureBlock(closureBlock: { _ in "Aad"})


//print(Array(1...50).filter{ $0 % 2 == 0})

//MARK:-- ## lazy init with Closure ##

struct Human{
    init() {
        print("is old creating")
    }
}
//: creat object with closure
let human = { () -> Human in
    let human = Human()
    return human
}()

human
//print(createdHuman)

//: creat UIView Programatically

let view1 = { () -> UIView in
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    return view
}

let view2 = { () -> UIView in
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    return view
}

//:  Lazy Var
class IntenseMathProblem{
    lazy var colplexNum = {
        2*2
    }()
}
let res = IntenseMathProblem()
res.colplexNum
//let res = IntenseMathProblem.colplexNum
//print(res)

//: Capture List
var a = 0
var b = 0

let closure = {
    print("\(a) \(b)")
}
//closure()

//:Capture List

var i = 0
var captureList : [()->()] = []
for _ in 1...5{
    captureList.append {
        print("value : \(i) ")
    }
    i += 1
}

//captureList[2]()// @ all times will be equal 5 , so to solve this use 👇

var j = 0
var captureListCopy : [()->()] = []

for _ in 1...5{
    captureListCopy.append { [num = j] in
        print("value of J : \(num) ")
    }
    j += 1
}
//captureListCopy[0]() // value of J : 0
//captureListCopy[1]() // value of J : 1
//captureListCopy[2]() // value of J : 2
//captureListCopy[3]() // value of J : 3


// characteristics of capture list
/// 1- not ref type
var k = 0
var l = 0

var captureArray : () -> () = {[k,l] in
    print(k,l)
}
//captureArray() // 0 0
 k = 10
 l = 10
//captureArray() // 0 0

// characteristics of closure
/// 1- ref type
var c = 0
var d = 0
let smartClosure : ()->() = {() in
    print(c,d)
}
//smartClosure() // 0 0
c = 9
d = 9
//smartClosure() // 9 9

//: Trailing Closure
// Problem -> A closure is too long to pass through a function

func trailingClosure(num : Int , closur : () -> ()){
    print("you have entered \(num)")
    closur()
}

let hell0 = {
    print("hell0")
}

//// Pass Closure Indirectly
//trailingClosure(num: 100, closur: hell0)

//// Pass Closure Directly
//trailingClosure(num: 1000) {
//    print("hello from passing closure Directly")
//}


func trailingClosuree(num : Int , closur : (Int) -> Int){
    let newNum = closur(num)
    print(newNum)
}
//trailingClosuree(num: 23) { (n) -> Int in
//    n + n
//}
//trailingClosuree(num: 23) { (n) in
//    n + n
//}
//trailingClosuree(num: 23) {$0 + $0}
 
//: Completion Handler  Definition : do something when something has been done
let handlerBlock : (Bool) -> () = { isSuccess in
    if isSuccess{
        print("download has been done")
    }
}
let handlerBlocke : (Bool) -> () = {
    if $0{
        print("download has been done")
    }
}
handlerBlock(true)

func downloadFile( completion : (Bool) -> ()){
    for _ in 1...3{
        print("downloading")
    }
    handlerBlock(true)
}
/// Pass Closure Indirectly
//downloadFile(completion: handlerBlock)

/// Pass Closure Directly
downloadFile {
    if $0{
        print("download has been done")
    }
}

let handlerArr : ([String])-> () = { (arr) in
    for i in arr {
        print("Done Working , \(i)")
    }
    print("download has been done")
}
//handlerArr(["ggg","ggg","ggg","ggg"])

func downloadImage(downloadedImg : ([String])-> ()){
    for _ in 1...4 {
        print("still downloading ⬇️,⬇️,⬇️")
    }
    downloadedImg(["img1","img2","img3","img4"])
}

downloadImage(downloadedImg: handlerArr)








