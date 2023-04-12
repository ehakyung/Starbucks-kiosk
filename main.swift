//
//  main.swift
//  Kiosk
//
//  Created by 이하경 on 2023/04/10.
//

import Foundation

class Order{

    var data: Data
    var hereOrTogo: String?
    var category: String?
    var type: String?
    var menu: String?
    var hotOrIced: String?
    var size: String?
    var option: [String:Int]?
    
    init(){
        self.data = Data()
        self.hereOrTogo = nil
        self.category = nil
        self.type = nil
        self.menu = nil
        self.size = nil
        self.option = nil
    }
    
    func start(){
        
        print("💚 WELCOME TO STARBUCKS 💚")
        self.getHereOrTogo()
    }
    
    func getHereOrTogo(){
        
        while self.hereOrTogo == nil{
            print("💬 For Here Or Togo?")
            for index in 0..<self.data.hereOrTogo.count-1{
                print("\(index+1). \(self.data.hereOrTogo[index])", terminator: " | ")
            }
            print("\(self.data.hereOrTogo.count). \(self.data.hereOrTogo[self.data.hereOrTogo.count-1])")
            let input: String? = readLine()
            
            if input == "1"{
                print("💬 You chose to eat-in.")
                self.hereOrTogo = self.data.hereOrTogo[0]
                
            } else if input == "2"{
                print("💬 You chose to take away.")
                self.hereOrTogo = self.data.hereOrTogo[1]
                
            } else {
                print("⚠️ Please choose between 0 and 2.")
            }
        }
//        print(self.hereOrTogo) //검사용
        self.getCategory()
    }
    
    func getCategory(){
        
        while self.category == nil{
            print("💬 What do you want to order?")
            for index in 0..<self.data.category.count-1{
                print("\(index+1). \(self.data.category[index])", terminator: " | ")
            }
            print("\(self.data.category.count). \(self.data.category[self.data.category.count-1]) | (0. Back)")
            let input: String? = readLine()
            
            if input == "0"{
                self.hereOrTogo = nil
                self.getHereOrTogo()
                break
                
            } else if input == "1" || input == "2" || input == "3"{
                self.category = self.data.category[Int(input!)!-1]
                print("💬 You chose \(self.category!).")
                self.getType()
                
            } else {
                print("⚠️ Please choose between 0 and 3.")
            }
//            print(self.category) //검사용
        }
    }
    
    func getType(){
        
        while self.type == nil{
            print("💬 What type of \(self.category!) do you want to order?")
            var tmpArray: [String] = []
            for index in 0..<self.data.category.count{
                if self.category == self.data.category[index]{
                    tmpArray = self.data.categoryArray[index]
                }
            }
            
            for index in 0..<tmpArray.count-1{
                print("\(index+1). \(tmpArray[index])", terminator: " | ")
            }
            print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | (0. Back)")
            let input: String? = readLine()
            
            if Int(input!) == 0{
                self.category = nil
                self.getCategory()
                break
                
            } else if Int(input!)! >= 1 && Int(input!)! <= tmpArray.count{
                self.type = tmpArray[Int(input!)!-1]
                print("💬 You chose \(self.type!).")
                self.getMenu()
                
            } else {
                print("⚠️ Please choose between 0 and \(tmpArray.count).")
            }
//            print(self.type) //검사용
        }
    }
    
    func getMenu(){
        
        while self.menu == nil{
            print("💬 Which \(self.type!) do you want?")
            var tmpDic: [String:Int] = [:]
            var tmpArray: [String] = []
            for index in 0..<self.data.drinkAndFood.count{
                if self.type == self.data.drinkAndFood[index]{
                    tmpDic = self.data.drinkAndFoodArray[index]
                    tmpArray = tmpDic.keys.sorted()
                    
                    for index in 0..<tmpArray.count-1{
                        print("\(index+1). \(tmpArray[index])", terminator: " | ")
                    }
                    print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | (0. Back)")
                    let input: String? = readLine()
                    
                    if Int(input!) == 0{
                        self.type = nil
                        self.getType()
                        break
                        
                    } else if Int(input!)! >= 1 && Int(input!)! <= tmpArray.count{
                        self.menu = tmpArray[Int(input!)!-1]
                        print("💬 You chose \(self.menu!).")
                        self.getHotOrIce()
                        
                    } else {
                        print("⚠️ Please choose between 0 and \(tmpArray.count).")
                    }
                    //            print(self.menu) //검사용
                }
            }
        }
    }
        
    func getHotOrIce(){
        
        while self.hotOrIced == nil{
            if self.data.hotOnlyMenu.contains(self.menu!){
                self.hotOrIced = "Hot"
                print("💬 \(self.menu!) is served only Hot")
                self.getSize()
                
            } else if self.data.icedOnlyMenu.contains(self.menu!){
                self.hotOrIced = "Iced"
                print("💬 \(self.menu!) is served only Iced")
                self.getSize()
                
            } else if self.data.rtd.keys.contains(self.menu!){
                self.hotOrIced = "None"
                print("💬 \(self.menu!) is served chilled.")
                self.getSize()
                
            } else if self.data.food.contains(self.type!){
                self.hotOrIced = "None"
                print("💬 \(self.menu!) has no choice for temperature.")
                self.getSize()
                
            } else {
                print("💬 Would you like your \(self.menu!) served Hot or Iced?")
                
                let tmpArray: [String] = self.data.hotOrIced
                for index in 0..<tmpArray.count-1{
                    print("\(index+1). \(tmpArray[index])", terminator: " | ")
                }
                print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | (0. Back)")
                let input: String? = readLine()
                
                if Int(input!) == 0{
                    self.menu = nil
                    self.getMenu()
                    break
                    
                } else if Int(input!)! >= 1 && Int(input!)! <= tmpArray.count{
                    self.hotOrIced = tmpArray[Int(input!)!-1]
                    print("💬 Your \(self.menu!) will be served \(self.hotOrIced!).")
                    self.getSize()
                    
                } else {
                    print("⚠️ Please choose between 0 and \(tmpArray.count).")
                }
            }
        }
    }
            
            
    func getSize(){
        
        while self.size == nil{
            var tmpArray: [String] = []
            
            if self.data.espressoSizedMenu.contains(self.menu!){
                tmpArray = self.data.sizeOfEspresso
            } else if self.data.rtd.keys.contains(self.menu!) || self.menu! == "Malcha Shot Affogato" || self.data.food.contains(self.type!){
                self.size = "None"
                print("💬 \(self.menu!) has no choice for size.")
                self.getOption()
                break
                
            } else if self.hotOrIced! == "Hot"{
                tmpArray = self.data.sizeOfHot
                
            } else {
                tmpArray = self.data.sizeOfIced
            }
            print("💬 What size \(self.menu!) would you like?")
            
            for index in 0..<tmpArray.count-1{
                print("\(index+1). \(tmpArray[index])", terminator: " | ")
            }
            print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | (0. Back)")
            let input: String? = readLine()
            
            if Int(input!) == 0{
                self.menu = nil
                self.getMenu()
                break
                
            } else if Int(input!)! >= 1 && Int(input!)! <= tmpArray.count{
                self.size = tmpArray[Int(input!)!-1]
                print("💬 You chose \(self.size!) size.")
                self.getOption()
                
            } else {
                print("⚠️ Please choose between 0 and \(tmpArray.count).")
            }
            //            print(self.size) //검사용
        }
    }
            
    func getOption(){
    loop1: while true{
        if self.data.drink.contains(self.type!){
            var tmpArray: [String] = []
            
            if self.hotOrIced == "Hot"{
                tmpArray = self.data.optionOfHotDrink.keys.sorted()
                self.option = ["addEspresso":0, "addSyrup":0, "withWhip":0, "withDrizzle":0]
                
            } else if self.hotOrIced == "Iced"{
                tmpArray = self.data.optionOfIcedDrink.keys.sorted()
                self.option = ["addEspresso":0, "addSyrup":0, "moreIce":0, "withWhip":0, "withDrizzle":0]
                
            } else {
                self.option = ["None":0]
                //변수 모으기, 계산하기
                break loop1
            }
            
        loop2: while true{
            print("💬 Which option would you like to add to your \(self.menu!)?")
            for index in 0..<tmpArray.count-1{
                print("\(index+1). \(tmpArray[index])", terminator: " | ")
            }
            print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | \(tmpArray.count+1). No Option | (0. Back)")
            let input1: String? = readLine()
            
            if Int(input1!) == 0{
                self.size = nil
                self.getSize()
                break loop1
                
            } else if Int(input1!) == tmpArray.count+1{
                break loop1
                
            } else if self.hotOrIced == "Iced" && Int(input1!) == 3{
                self.option?.updateValue(1, forKey: "moreIce")
                
            loop3: while true{
                print("💬 More ice is served. Do you want more option?")
                print("1. Yes | 2. No")
                let input2: String? = readLine()
                
                if Int(input2!) == 1{
                    break loop3
                    
                } else if Int(input2!) == 2{
                    break loop1
                    
                } else {
                    print("⚠️ Please choose between 0 and 2.")
                }
            }
                
            } else {
                
            loop4: while true{
                print("💬 How many? You can add 1 to 9 times.")
                let input3: String? = readLine()
                
                if Int(input3!)! >= 1 && Int(input3!)! <= 9{
                    self.option?.updateValue(Int(input3!)!, forKey: tmpArray[tmpArray.count-1])
                    print("💬 \(Int(input3!)!) times \(tmpArray[Int(input1!)!-1]) is served. Do you want more option?")
                    print("1. Yes | 2. No")
                    let input4: String? = readLine()
                    
                    if Int(input4!) == 1{
                        break loop4
                        
                    } else if Int(input4!) == 2{
                        break loop1
                        
                    } else {
                        print("⚠️ Please choose between 0 and 2.")
                    }
                    
                } else {
                    print("⚠️ Please choose between 0 and 9.")
                }
                }
                
            }
        }
        } else if self.data.bread.keys.contains(self.menu!) || self.data.sandwichSalad.keys.contains(self.menu!){
            
        loop5: while true{
            print("💬 Do you want me to heat up your \(self.menu!)?")
            print("1. Yes | 2. No | (0. Back)")
            let input: String? = readLine()
            
            if Int(input!) == 0{
                self.size = nil
                self.getSize()
                break loop1
                
            } else if Int(input!)! == 1{
                self.option = ["warm":1]
                print("💬 Your \(self.size!) is served heated.")
                break loop1
                //변수 모으기, 계산하기
                
            } else if Int(input!)! == 2{
                self.option = ["warm":0]
                print("💬 Your \(self.size!) is served cold.")
                break loop1
                //변수 모으기, 계산하기
                
            } else {
                print("⚠️ Please choose between 0 and 2.")
            }
        }
        } else {
            
            self.option = ["None":0]
            print("💬 Your \(self.size!) has no choice for option.")
            break loop1
            //변수 모으기, 계산하기
        }
    }
    }
    
    func getNumber(){
    }
}
//==============================================================================
let order = Order()
order.start()

