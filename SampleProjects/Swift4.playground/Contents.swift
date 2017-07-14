//: Playground - noun: a place where people can play
import UIKit
import Foundation

#if swift(>=4.0)
print("Greater than 3.0")
#elseif swift(>=4.0)
print("4.0")
#endif
extension String {
    var banana : String {
        let shortName = String(characters.dropFirst(1))
        return "\(self) \(self) Bo B\(shortName) Banana Fana Fo F\(shortName)"
    }
}



//String
let str = """
Hi Avnish
How are you
I m fine
    hh
"""
print(str)
struct tt:Codable {
    var t:Int
}
struct Sample:Codable {
    
    var x:Int
    var y:Int
    var z:tt
}
let obb = tt(t: 45)
let a = Sample(x: 10, y: 20, z: obb)
//JSONEncoder Example
let encoder = JSONEncoder()
var encodedData = Data()
do {
    encodedData = try encoder.encode(a)
    print(String(data: encodedData, encoding: .utf8)!)
}catch {
    print(error)
}
//JSONDecoder Example
let decoder = JSONDecoder()
do{
    let decodedData = try decoder.decode(Sample.self, from: encodedData) as! Sample
    print(decodedData.x)
}catch{
    
}
//KeyPath Example
let keyPath = \Sample.z.t
let x = a[keyPath:keyPath]


