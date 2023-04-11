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
    
    init(){
        self.data = Data()
        self.hereOrTogo = nil
        self.category = nil
        self.type = nil
        self.menu = nil
    }
    
    func start(){
        print("💚 WELCOME TO STARBUCKS 💚")
        self.getHereOrTogo()
    }
    
    func getHereOrTogo(){
//        enum HereOrTogo: String{
//            case here = "1"
//            case togo = "2"
//        }

        while self.hereOrTogo == nil{
            print("💬 For Here Or Togo?")
            print("1. here | 2. togo")
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
//        print(self.hereOrTogo!) //검사용
        
        self.getCategory()
    }
    
    func getCategory(){
        while self.category == nil{
            print("💬 What do you want to order?")
            print("1. Drink | 2. Food | 3. MD(merchandise) (0. Back)")
            let input: String? = readLine()
            
            if input == "0"{
                self.hereOrTogo = nil
                self.getHereOrTogo()
            } else if input == "1" || input == "2" || input == "3"{
                self.category = self.data.category[Int(input!)!-1]
                print("💬 You chose \(self.category!).")
                self.getType()
            }else {
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
            print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | (0.Back)")
            let input: String? = readLine()
            
            
            if Int(input!) == 0{
                self.category = nil
                self.getCategory()
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
                }
            }
            for (key, _) in tmpDic{
                tmpArray.append(key)
            }
            
            for index in 0..<tmpArray.count-1{
                print("\(index+1). \(tmpArray[index])", terminator: " | ")
            }
            print("\(tmpArray.count). \(tmpArray[tmpArray.count-1]) | (0.Back)")
            let input: String? = readLine()
            
            if Int(input!) == 0{
                self.type = nil
                self.getType()
            } else if Int(input!)! >= 1 && Int(input!)! <= tmpArray.count{
                self.menu = tmpArray[Int(input!)!-1]
                print("💬 You chose \(self.menu!).")
                self.getOption()
            } else {
                print("⚠️ Please choose between 0 and \(tmpArray.count).")
            }
//            print(self.menu) //검사용
        }
    }
    
    func getOption(){
        
    }

}



let order = Order()
order.start()

