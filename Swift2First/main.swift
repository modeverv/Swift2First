//
//  main.swift
//  Swift2First
//
//
// https://github.com/hatena/Hatena-Textbook/blob/master/swift-programming-language.md
import Foundation

do {
    let name = "Ste"
    var age = 56
    var age2 : Int = 32
    print("\(age) \(name)")
    var phone :Optional<String> = nil
    var phone2:String? = nil

    // Optional - Optional binding
    phone = "aaa"
    if phone != nil {
        print(phone)
    }
    if let p = phone {
        print(p)
    }
    // Optional Chaining nilはBoolのfalseじゃないの。
    // ?? 演算子
    if phone?.hasPrefix("a") ?? false {
        print(phone)
    }
}

do {
    // Tuple
    let ste = ("Ste",56)
    let (name,age) = ste
    print(ste.0)

    let steeve = (name:"Steeve",age:56)
    print(steeve.name)
}

do {
    // Array
    let fishes = ["aaa","bbbb"]
    print(fishes[0]);//xcode 補完ちょっとバカ
    for fish in fishes {
        print(fish)
    }
    var dogs:[String] = []
    dogs.append("aaa");

}

do {
    // Set
    let fishes : Set<String> = ["aaa","bbbb"]
    if fishes.contains("aaa") {
        print("contain")
    }
}

do {
    // Dictionary
    // sizeOfFishes["Mackerel"] のようにキーを用いてアクセスできる。このとき返ってくるのは Int? 型であり、キーが存在しない場合の値は nil である。
    var size_ : [ String : String ] = [:]
    size_["hoge"] = "fuga"
    size_["hogehoge"] = "fuga"
    if let n = size_["hoge"] {
        print(n)
    }
    // Optional - binding
    if let n = size_["hoge2"] {
        print(n)
    }else{
        print("not contain")
    }
    for key in size_.keys {
        print(size_[key])
        // => Optional - binding必要
    }
    // tupleで取り出すのがよいのか。
    for (key,value) in size_ {
        print("\(key) - \(value)")
    }
}

do {
    // Where
    for i in 0..<3 where i % 2 == 0 {
        print(i)
    }
}

do {
    let numbers: [Int?] = [0, nil, 3, 4, nil]
    // ?でnilの時は何もおきない
    for case let i? in numbers {
        print(i)
    }
}

do {
    let number = 1
    // これちょっと気持ち悪いな。
    if case 0..<3 = number {
        print(number)
    }

    // なぜ ifだけでややこしい
    let condition = true
    let aNumber: Int? = 3
    let anotherNumber: Int? = 7
    // Optional bindingしているの？
    if condition, let a = aNumber, let b = anotherNumber where a < b {
        print(a + b)
    }
    if let a = aNumber, let b = anotherNumber where a < b {
        print(a + b)
    }
    if true,let a = aNumber, let b = anotherNumber where a < b {
        print(a + b)
    }
}

do {
    // Functions 
    // 呼び出し時には引数にラベルをつける。ただし第一引数にはラベルをつけない
    func multiply(number first: Int, by second: Int) -> Int {
        return first * second
    }
    print(multiply(number: 3, by: 5))
}

do {
    // var
    func increment(var number: Int) -> Int {
        return ++number
    }
    increment(6)
}

do {
    // inout -> Intいらない -> Voidで明示的に
    func increment(inout number: Int) -> Void {
        ++number
    }
    var number = 7
    // 参照渡し Cっぽい
    increment(&number) // => 8
}

do {
    // Default value
    func refrain(string: String, count: UInt=1) -> String {
        var result: [String] = []
        for i in 0..<count {
            result.append(i == 0 ? string : string.lowercaseString)
        }
        return result.joinWithSeparator(", ")
    }

    refrain("Let it be", count: 3)
    
    refrain("Love")
}

do {
    // 可変長引数
    // 型名に続いて ... と書くと可変長の引数を受けられるようになる。実装中においては Array として取り扱うことができる。
    func sum(numbers: Int...) -> Int {
        return numbers.reduce(0, combine: +)
    }
    sum(1, 4, 7)
}

do {
    // 関数はファーストクラス
    func multiply(number first: Int, by second: Int) -> Int {
        return first * second
    }

    var calculation: (Int, Int) -> Int

    calculation = multiply
    // ()でcall
    let twentyOne = calculation(3, 7)
}

do {
    // 高階関数
    func multiply(number: Int, by: Int) -> Int { return number * by }
    func add(number: Int, to: Int) -> Int { return number + to }

    func calculation(kind: String) -> (Int, Int) -> Int {
        switch kind {
        case "add":
            return add
        case "multiply":
            return multiply
        default:
            fatalError("Unsupported")
        }
    }
    
    calculation("add")(1, 4)
}

do {
    // 関数のネスト
    func calculation(kind: String) -> (Int, Int) -> Int {
        func multiply(number: Int, by: Int) -> Int { return number * by }
        func add(number: Int, to: Int) -> Int { return number + to }

        switch kind {
        case "add":
            return add
        case "multiply":
            return multiply
        default:
            fatalError("Unsupported")
        }
    }
    
    calculation("add")(1, 4)
}

do {
    // guard
    let contact = [ "name" : "Steve Jobs", "mail" : "steve@apple.com" ]

    func recipient(contact: [String: String]) -> String? {
        guard let name = contact["name"], let mail = contact["mail"] else {
            return nil
        }
        // スコープname,mailはここまでスコープ来る
        return "\(name) <\(mail)>"
    }
}

do {
    // CLosures
    func doubling(number: Int) -> Int {
        return 2 * number
    }

    let values = [0, 1, 2, 3, 4, 5]
    // mapは非破壊的　変数で受け取らないとだめっぽ
    var v = values.map(doubling)
    // ＝＞が　クロージャで
    var v2 = values.map({ (number: Int) -> Int in
        return 2 * number
    })
    // 省略クロージャ達
    var v3 = values.map({ number in 2 * number })
    var v4 = values.map({ 2 * $0 })
    var v5 = values.map { 2 * $0 }
}

do {
    // キャプチャ
    // ちょっと理解に苦しみますね。使わないようにしよ
    // 面白いけど。
    func counter() -> () -> Int {
        var count = 0
        let closure = {
            return ++count
        }
        return closure
    }

    let c = counter()
    c()
    c()
}

do {
    // enum
    enum ArithmeticOperation {
        case Add
        case Substract
        case Multiply
        case Divide
    }
    // enum with associate value
    enum Diagram {
        case Line(Double)
        case Rectangle(Double, Double)
        case Circle(Double)
    }

    func calculateArea(diagram: Diagram) -> Double {
        let area: Double
        switch diagram {
        case .Line(_):
            area = 0.0
        case let .Rectangle(width, height):
            area = width * height
        case .Circle(let radius):
            area = radius * radius * M_PI
        }
        return area
    }
    
    calculateArea(.Circle(3.0))
}

do {
    // struct
    struct Body {
        let height: Double
        let mass: Double
    }

    let myBody = Body(height: 129.3, mass: 129.3)

    func calculateBodyMassIndex(body: Body) -> Double {
        let meterHeight = body.height / 100.0
        return body.mass / (meterHeight * meterHeight)
    }
    
    calculateBodyMassIndex(myBody)
}
// だいぶC言語残っているな。。。

do {
    // class
    class Lot {
        var remains: [String]

        init(_ elements: String...) {
            self.remains = elements
        }

        func choose() -> String? {
            if remains.isEmpty {
                return nil
            }
            let randomIndex = Int(arc4random_uniform(UInt32(remains.count)))
            return remains.removeAtIndex(randomIndex)
        }
    }

    func pickFromLot(lot: Lot, count: Int) -> [String] {
        var result: [String] = []
        // 警告ない例にしてほしいところ
        for _ in (0..<count) {
           lot.choose().map { result.append($0) }
        }
        return result
    }
    // new とかいらない
    let lot = Lot("Swift", "Objective-C", "Java", "Scala", "Perl", "Ruby")
    pickFromLot(lot, count: 3)
    print(lot.remains)
}

do {
    //ここで、二つのインスタンスが互いを参照し合うなどといった際に、永遠に参照カウントが0にならないということが起き得る。これを循環参照という。循環参照が起きるとメモリリークするので、一方を弱い参照（参照カウントに影響しない参照）にしてやる必要が出てくる。
    class Dog {
    }

    weak var dog: Dog?
    dog = Dog()
}

do {
    // クロージャのweak
    class Dog{}
    let dog = Dog()
    // キャプチャしている
    let callDog = { [weak dog] (message: String) -> String in
        return "\(dog!), \(message)."
    }
    
    callDog("stay")
}

do {
    // Computed Properties
    // Computed プロパティでは他の情報から計算可能な値をプロパティとして提供できる。
    struct Circle {
        var radius: Double = 0.0

        var area: Double {
            get {
                return radius * radius * M_PI
            }
            set (newArea) {
                radius = newArea
            }
        }
    }
    var circle = Circle()
    print(circle.radius)
    circle.area = 1.0
    print(circle.area)
}

do {
    // Property Observers
    // willSet や didSet ブロックを書くことで、プロパティの値の変化の前後に何らかの処理を行うことができる。
    // つかわね。
    struct Dam {
        let limit = 100.0
        var waterLevel = 0.0 {
            willSet {
                print("\(newValue - waterLevel) will change")
            }
            didSet {
                if waterLevel > limit {
                    print("Bursted")
                    waterLevel = limit
                }
                print("\(waterLevel - oldValue) did change")
            }
        }
    }
    
    var dam = Dam()
    dam.waterLevel = 120
}

do {
    class Printer {
        var numberOfCopies = 1
        // self
        func put(string: String) {
            for _ in (0..<self.numberOfCopies) {
                print(string)
            }
        }
    }

    let printer = Printer()
    printer.put("Word")
}

do {
    struct StepCounter {
        var count: Int = 0
        // mutating
        mutating func step() -> Void {
            count++
        }
    }

    var counter = StepCounter()
    counter.step()
    print(counter.count)
}


/*
print("Hello, World!\nほげ")

let name = "Steave"
var age :Int = 56;
print(name)
print(age)
print("hoge \(name)")

// optional
var phonenumber:String? = nil
phonenumber = "aaaa"
if phonenumber != nil && 1 == 1 {
    print(phonenumber!)
}
// phonenumber?1はnilでない時は値になる。
// nilの場合は何もおきない。値があるときのみメソッドが呼び出される
// ??は左辺がnilの場合右辺を返す
if phonenumber?.hasPrefix("aa") ?? false {
    print(phonenumber!)
}
// （少なくとも１つのスクリプトの範囲で）同じ変数名は使えない
var phonenumber2:String! = "090-22220-2222"
print("phone \(phonenumber2)")

/* Tuple */
// 配列みたいなもの？？違う。タプルだ
let st = ("Steave",56)
let (name1,age2) = st
print(st.0)


//ラベル付き
let ste = (name:"Steave",age:56)
print(ste.age)

/* Array */
let fishes = ["hog","fuga"]
print(fishes[0]);

for fish in fishes {
    print(fish)
}

//var dogs:[String] = []
var dogs: Array<String> = [] // こちらでも良さそう
// 最初は何書いているか明示するためにArray使ったほうが良いかな
dogs.append("aa");
dogs.append("bb");
for dog in dogs {
    print(dog)
}

/* Set */
let fishes2 :Set<String> = ["aaa","bbb","aaa"]
for fish in fishes2 {
    print(fish)
}

/* Dictionary */
// hashキター
var sizeAndFishes = [
    "aaaa" : 50,
    "bbbb" : 55,
]
// key-valueで取り出すtuple
// 尚、文字列の連結は+でできる模様
for (fish,size) in sizeAndFishes {
    print("\(fish) : " + "\(size)")
}

// C-likeな== != +=とかは行ける模様
var aaa = 1
aaa *= 10
print(aaa);

// ３項演算子も使える模様
print(aaa == 10 ? "fuga" : "hoge")

// コレはPythonとかではあるのかな??演算子
var optionalInt : Int?
let someValue = optionalInt ?? 0

// Optional型が新しいね。

// ...演算子　..<演算子 Range<Int>型
var dotE = 1...3
var dotE2 = 1..<3
for i in dotE {
    print(i)
}
// jsのような糞スコープではなさそう
for i in dotE2 {
    print(i);
}

// switchかなり賢い
// Uint=とかするとダメだけどIDEがエラーを検知してくれるので安心
// きっと正規表現も使えるのだろう。使えるといいな
// 明示的なbreakいらない。逆に言うと流しswitchは使えない。
// fallshroughというのもある。柔軟
let theNumber :UInt = 42
switch theNumber {
case 0..<5:
    print("Single digit")
    // 基本はbreakいらない
case 5..<10:
    print("Single digit")
    break // 明示的なbreakも可能
case 10..<50:
    //case 51..<100:こういうのは書けない模様
    print("Double digit")
    fallthrough
default:
    print("Very large")
}

/* for in */
// whereを利用
for i in 0..<3 where i % 2 == 0 {
    print(i)
}
// ?でマッチ　
//ちとキモい
let numbers: [Int?] = [0, nil, 3, 4, nil]
for case let i? in numbers {
    print(i)
}

/* for */
// continue breakも使える模様
for var i = 0,l = 10 ;i<l;i++ {
    print(i)
}

/* while */
// swift スペース重要
var ix = 0;
while ix < 3 {
    print(ix);ix++;
}

/* repeat while */
// do - whileですね
var iy = 0
repeat {
    print(iy)
    ++iy
} while iy < 3

// ちょっとついていけない感
let condition = true
let aNumber: Int? = 3
let anotherNumber: Int? = 7
if condition, let a = aNumber, let b = anotherNumber where a < b {
    print(a + b)
}

// Optional型が難物かも

/* スコープ */
// やっと出てきましたスコープ
// こういうGetting Startedだと便利
do {
    let name = "H"
    print(name)
}

/* 関数 */
func multiply(number: Int,by:Int) -> Int{
    return number * by
}
// func 関数名(引数名: 引数型, 引数名: 引数型) -> 返り値型 { 実装 } が基本的なフォーマットである。
// 呼び出し時には引数にラベルをつける。ただし第一引数にはラベルをつけない。
print(multiply(3, by:4)) // Objective-C-likeかな。しらんけど

// 内部引数名と外部引数名
func multiply2(number first: Int, by second: Int) -> Int {
    return first * second
}
multiply2(number: 3, by: 5)

// 引数は基本変更できないがvarで変更できる
// 更に内部引数名にするとラベル必須になるっぽい
do {
    func increment(var number n: Int) -> Int {
        return ++n
    }
    print(increment(number:6))
}
do {
    // inout 参照渡し
    // -> 戻り値いらない。書いてはダメ
    // &
    func increment(inout number: Int) {
        ++number
    }
    var number = 7
    print(increment(&number)) // => 8
    // swift機能豊富すぎやしませんかね。
    // 詰め込みすぎな気もする
}
// デフォルト値
do {
    func refrain(string: String, count: UInt = 5) -> String {
        var result: [String] = []
        for i in 0..<count {
            result.append(i == 0 ? string : string.lowercaseString)
        }
        return result.joinWithSeparator(", ")
    }

    print(refrain("Let it be", count: 3))
    
    print(refrain("Love"))
}

// 可変長引数
// 内部ではArray
do{
    func sum(numbers: Int...) -> Int {
        return numbers.reduce(0, combine: +) //キモいの出てきた
    }
    print(sum(1, 4, 7))
}

// 関数もファーストクラスオブジェクト的な
do {
    func multiply(number: Int, by: Int) -> Int { return number * by }
    func add(number: Int, to: Int) -> Int { return number + to }

    func calculation(kind: String) -> (Int, Int) -> Int {
        switch kind {
        case "add":
            return add
        case "multiply":
            return multiply
        default:
            fatalError("Unsupported")
        }
    }
    
    print(calculation("add")(1, 4))
}

// 関数のネスト
// だんだんややこしい。
do {
    func calculation(kind: String) -> (Int, Int) -> Int {
        func multiply(number: Int, by: Int) -> Int { return number * by }
        func add(number: Int, to: Int) -> Int { return number + to }

        switch kind {
        case "add":
            return add
        case "multiply":
            return multiply
        default:
            fatalError("Unsupported")
        }
    }
    
    print(calculation("multiply")(1, 4))
}

// 今のところOptionalがやばい

// enum / structあるよ。。。
// ちょっと厳しいな。頭メモリパンクしそうだよ。
// っていうかこのページ言語仕様全部出してませんかね。やり過ぎ感が。
// でも日本語リファレンスとしては使えるな。
// classに望みを。。。

// classに差し掛かっているがnew とか無いからキモいね。
// アクセス修飾子無いのかしら
do {
    class Lot {
        var remains: [String]

        init(_ elements: String...) {
            self.remains = elements
        }

        func choose() -> String? {
            if remains.isEmpty {
                return nil
            }
            let randomIndex = Int(arc4random_uniform(UInt32(remains.count)))
            return remains.removeAtIndex(randomIndex)
        }
    }

    func pickFromLot(lot: Lot?, count: Int) -> [String] {
        var result: [String] = []
        for _ in 0..<count {
            lot?.choose().map { result.append($0) }
        }
        return result
    }
    // new なし
    // weak鬼門か
    // Optional鬼門か
    // ?でしてやって　受け取る時も?にしてやって ?でアクセスしてやる必要がある
    weak var lot : Lot? = Lot("Swift", "Objective-C", "Java", "Scala", "Perl", "Ruby")
    pickFromLot(lot, count: 3)
    print(lot?.remains)
}

// lazy キーワードを付けることで遅延初期化できる。
do{
    class DataFormatter {
        var format: String = ""
    }

    class DataPrinter {
        lazy var formatter = DataFormatter()
        var data: [String] = []
    }
    
    let printer = DataPrinter()
}

*/

