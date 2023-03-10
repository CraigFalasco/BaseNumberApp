//
//  ContentView.swift
//  BaseNumbers
//
//  Created by Craig on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var number: String = ""
    @State var base: String = "2"
    @State var result: String = ""
    @State var intNum: Int = 0
    @State var intBase: Int = 0
    let errorMsg = "(must be numeric and up to 18 digits)"
    let baseValues =  [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
    
    var body: some View {

        ZStack {
            Color.pink
                .ignoresSafeArea()
            Form {
                
                Text("Convert decimal to any base")
                    .font(.title2)
                    .bold()
                
                Section(header: Text("YOUR NUMBER AND BASE")) {
                    
                    HStack {
                        Text("Number:")
                        TextField("", text: $number, prompt: Text("number up to 18 digits"))
                    }
                    
                    if checkNumber() || number.isEmpty {
                        Text("")
                    }
                    else {
                        Text(errorMsg)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    
                    HStack {
                        Picker("Base", selection: $base) {
                            ForEach(0..<baseValues.count, id: \.self) { index in
                                Text(String(baseValues[index])).tag(String(index + 2))
                            }
                        }
                    }
                    
                    if checkNumber() {
                        Button("SUBMIT") {
                            intNum = Int(number) ?? 1
                            intBase = Int(base) ?? 10
                            result = convertNumber(inNum: intNum, inBase: intBase)
                        }
                        .padding()
                        .background(Color(.red))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                
                Section(header: Text("RESULT")) {
                    Text("\(intNum) in base \(intBase) is:")
                        .bold()
                    Text(result.uppercased())
                        .bold()
                        .font(.title2)
                }
            }
            .padding()
            .cornerRadius(10)
        }
    }
    
    func convertNumber(inNum: Int, inBase: Int) -> String {
        
        let basePlaceValue: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        var newNumber = [String]()
        let divisor = inBase
        var dividend = inNum
        var quotient = 0
        var remainder = 0
        
        while (divisor <= dividend) {
            remainder = dividend % divisor
            quotient = dividend / divisor
            newNumber.append(basePlaceValue[remainder])
            dividend = quotient
        }
        
        newNumber.append(basePlaceValue[dividend])
        newNumber.reverse()
        
        return newNumber.joined()
    }
    
    func checkNumber() -> Bool {
        let arr = Array(number + base)
        var r = true
        arr.forEach { char in
            if char > "9" ||
                char < "0" {
                r = false
            }
        }
        if number.count > 18 ||
            number.count < 1 {
            r = false
        }
        return r
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
