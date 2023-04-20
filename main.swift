//
//  main.swift
//  Kiosk
//
//  Created by 이하경 on 2023/04/10.
//

import Foundation

class Order{

    let data: Data
    var cart: Cart?
    
    var hereOrTogo: String?
    var category: String?
    var type: String?
    var menu: String?
    var price: Int?
    var hotOrIced: String?
    var size: String?
    var option: [String:Int]?
    var number: Int?
    
    init(){
        self.data = Data()
        self.cart = nil
        
        self.hereOrTogo = nil
        self.category = nil
        self.type = nil
        self.menu = nil
        self.price = nil
        self.size = nil
        self.option = nil
        self.number = nil
    }
    
    func start(){
        print("💚 WELCOME TO STARBUCKS 💚")
        self.getHereOrTogo()
    }
    
    func printText(_ param: String){
        switch param{
        case "menu1":
            print("(0. Back, 99. Go First, 100. Show Cart)")
        case "menu2":
            print("(0. Back, 100. Show Cart)")
        case "menu3":
            print("(0. Back)")
        case "error":
            print("⚠️ Please input selectable numbers.")
        default:
            print("")
        }
    }
    
    func printArray(_ array: [String], _ param: String){
        for index in 0..<array.count{
            print("\(index+1). \(array[index])", terminator: " | ")
        }
        self.printText(param)
    }
    
    func printDic(_ dic: [String:Int], _ array: [String], _ param: String){
        for index in 0..<array.count{
            print("\(index+1). \(array[index]) (\(dic[array[index]]!) won)")
        }
        self.printText(param)
    }
    
    func getHereOrTogo(){
        self.cart = Cart(order: self)
        
        while self.hereOrTogo == nil{
            print("💬 For Here Or Togo?")
            self.printArray(self.data.hereOrTogo, "menu3")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1, 2:
                    self.hereOrTogo = self.data.hereOrTogo[input-1]
                    self.cart?.hereOrTogo = self.hereOrTogo
                    print("💬 You chose \(self.hereOrTogo!).")
                    
                    self.getCategory()
                case 0:
                    self.start()
                    break
                default:
                    self.printText("error")
                }
            } else {
                self.printText("error")
            }
        }
    }
    
    func getCategory(){
        while self.category == nil{
            print("💬 What do you want to order?")
            self.printArray(self.data.category, "menu2")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...self.data.category.count:
                    self.category = self.data.category[input-1]
                    print("💬 You chose \(self.category!).")
                    self.getType()
                case 0:
                    self.hereOrTogo = nil
                    self.getHereOrTogo()
                    break
                case 100:
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default:
                    self.printText("error")
                }
                
            } else {
                self.printText("error")
            }
        }
    }
    
    func getType(){
        while self.type == nil{
            var tmpArray: [String] = []
            for index in 0..<self.data.category.count{
                if self.category == self.data.category[index]{
                    tmpArray = self.data.categoryArray[index]
                }
            }
            
            print("💬 What type of \(self.category!) do you want to order?")
            self.printArray(tmpArray, "menu1")
    
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...tmpArray.count:
                    self.type = tmpArray[input-1]
                    print("💬 You chose \(self.type!).")
                    self.getMenu()
                case 0:
                    self.category = nil
                    self.getCategory()
                    break
                case 99:
                    (self.hereOrTogo, self.category) = (nil, nil)
                    self.getHereOrTogo()
                    break
                case 100:
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default:
                    self.printText("error")
                }
            } else {
                self.printText("error")
            }
        }
    }
    
    func getMenu(){
        while self.menu == nil{
            var tmpDic: [String:Int] = [:]
            var tmpArray: [String] = []
            for index in 0..<self.data.drinkAndFood.count{
                if self.type! == self.data.drinkAndFood[index]{
                    tmpDic = self.data.drinkAndFoodArray[index]
                    tmpArray = tmpDic.keys.sorted()
                }
            }
            
            print("💬 Which \(self.type!) do you want?")
            self.printDic(tmpDic, tmpArray, "menu1")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...tmpArray.count:
                    self.menu = tmpArray[input-1]
                    self.price = tmpDic[tmpArray[input-1]]!
                    print("💬 You chose \(self.menu!).")
                    self.getHotOrIce()
                case 0:
                    self.type = nil
                    self.getType()
                    break
                case 99:
                    (self.hereOrTogo, self.category, self.type) = (nil, nil, nil)
                    self.getHereOrTogo()
                    break
                case 100:
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default:
                    self.printText("error")
                }
            } else {
                self.printText("error")
            }
        }
    }
        
    func getHotOrIce(){
    loop1: while self.hotOrIced == nil{
        switch self.type!{
        case let it where self.data.drink.contains(it):
            switch self.menu!{
            case let it where self.data.hotOnlyMenu.contains(it) || self.data.icedOnlyMenu.contains(it):
                if self.data.hotOnlyMenu.contains(it){
                    self.hotOrIced = "Hot"
                } else {
                    self.hotOrIced = "Iced"
                }
                print("💬 \(self.menu!) is served only \(self.hotOrIced!).")
                self.getSize()
            case let it where self.data.rtd.keys.contains(it):
                self.hotOrIced = "None"
                self.getSize()
                break
            default:
            loop2:while true {
                print("💬 Would you like your \(self.menu!) served Hot or Iced?")
                self.printArray(self.data.hotOrIced, "menu1")
                
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1...self.data.hotOrIced.count:
                        self.hotOrIced = self.data.hotOrIced[input-1]
                        print("💬 Your \(self.menu!) will be served \(self.hotOrIced!).")
                        self.getSize()
                        break loop2
                    case 0:
                        (self.menu, self.price) = (nil, nil)
                        self.getMenu()
                        break loop1
                    case 99:
                        (self.hereOrTogo, self.category, self.type, self.menu, self.price) = (nil, nil, nil, nil, nil)
                        self.getHereOrTogo()
                        break loop1
                        
                    case 100:
                        self.cart?.showCart()
                        if self.cart?.breakIndex == 1{
                            break loop1
                        }
                    default:
                        self.printText("error")
                    }
                } else {
                    self.printText("error")
                }
                }
            }
        default:
            self.hotOrIced = "None"
            self.getSize()
            break
        }
        }
    }
            
    func getSize(){
        var tmpArray: [String] = []
        let tmpDic: [String:Int] = self.data.priceOfsize
        
        switch self.type! {
        case let it where self.data.drink.contains(it):
            switch self.menu! {
            case let it where self.data.rtd.keys.contains(it) || it == "Malcha Shot Affogato":
                self.size = "None"
                self.getOption()
            case let it where self.data.espressoSizedMenu.contains(it):
                tmpArray = self.data.sizeOfEspresso
            default:
                if self.hotOrIced! == "Hot"{
                    tmpArray = self.data.sizeOfHot
                } else {
                    tmpArray = self.data.sizeOfIced
                }
            }
        default:
            self.size = "None"
            self.getOption()
        }
        
        while self.size == nil{
            print("💬 What size \(self.menu!) would you like?")
            self.printDic(tmpDic, tmpArray, "menu1")
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...tmpArray.count:
                    self.size = tmpArray[input-1]
                    self.price! += tmpDic[tmpArray[input-1]]!
                    print("💬 You chose \(self.size!) size.")
                    self.getOption()
                    break
                case 0:
                    if self.data.hotOnlyMenu.contains(self.menu!) || self.data.icedOnlyMenu.contains(self.menu!) || self.hotOrIced == "None"{
                        (self.hotOrIced, self.menu, self.price) = (nil, nil, nil)
                        self.getMenu()
                        break
                    } else {
                        self.hotOrIced = nil
                        self.getHotOrIce()
                        break
                    }
                case 99:
                    (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced) = (nil, nil, nil , nil, nil, nil)
                    self.getHereOrTogo()
                    break
                case 100:
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default:
                    self.printText("error")
                }
            } else {
                self.printText("error")
            }
        }
    }
            
    func getDrinkOption(){
        var tmpDic: [String:Int] = [:]
        var tmpArray: [String] = []
        
        switch self.hotOrIced! {
        case "Hot", "Iced":
            if self.hotOrIced == "Hot"{
                tmpDic = self.data.optionOfHotDrink
                self.option = ["addEspresso":0, "addSyrup":0, "withWhip":0, "withDrizzle":0]
            } else {
                tmpDic = self.data.optionOfIcedDrink
                self.option = ["addEspresso":0, "addSyrup":0, "moreIce":0, "withWhip":0, "withDrizzle":0]
            }
            tmpArray = tmpDic.keys.sorted()
        default:
            self.option = ["None":0]
            self.getNumber()
        }
        
    loop1: while self.option != ["None":0]{
        print("💬 Which option would you like to add to your \(self.menu!)?")
        self.printArray(tmpArray + ["No Option"], "menu1")
        
        if let input1: Int = Int(readLine()!){
            switch input1 {
            case 1...tmpArray.count:
                switch input1 {
                case 3:
                    if self.hotOrIced == "Iced"{
                        self.option!.updateValue(1, forKey: "moreIce")
                        print("💬 More ice is served.")
                    } else {
                        fallthrough
                    }
                default:
                loop2:while true{
                        print("💬 How many? You can add 1 to 9 times.")
                        if let input2: Int = Int(readLine()!){
                            switch input2 {
                            case 1...9:
                                self.option!.updateValue(input2, forKey: tmpArray[input1-1])
                                self.price! += (tmpDic[tmpArray[input1-1]]!)*input2
                                print("💬 \(input2) times \(tmpArray[input1-1]) is served.")
                                break loop2
                            default:
                                self.printText("error")
                            }
                        } else {
                            self.printText("error")
                        }
                    }
                    
                }
            loop3:while true{
                print("💬 Do you want more option?")
                print("1. Yes | 2. No")
                
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1:
                        break loop3
                    case 2:
                        self.getNumber()
                        break loop1
                    default:
                        self.printText("error")
                    }
                } else {
                    self.printText("error")
                }
                }
            case 0:
                self.option = nil
                
                if self.size == "None"{
                    self.size = nil
                    if self.data.hotOnlyMenu.contains(self.menu!) || self.data.icedOnlyMenu.contains(self.menu!) || self.hotOrIced == "None"{
                        (self.hotOrIced, self.menu, self.price) = (nil, nil, nil)
                        self.getMenu()
                        break
                    } else {
                        self.hotOrIced = nil
                        self.getHotOrIce()
                        break
                    }
                } else {
                    self.size = nil
                    self.getSize()
                    break
                }
            case tmpArray.count+1:
                self.getNumber()
                break
            case 99:
                (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option) = (nil, nil, nil, nil, nil , nil, nil, nil)
                self.getHereOrTogo()
                break
                
            case 100:
                self.cart?.showCart()
                if self.cart?.breakIndex == 1{
                    break
                }
            default:
                self.printText("error")
            }
        } else {
            self.printText("error")
        }
    }
    }
    
    func getFoodOption(){
        switch self.menu! {
        case let it where self.data.bread.keys.contains(it) || self.data.sandwichSalad.keys.contains(it) :
            while true{
                print("💬 Do you want me to heat up your \(self.menu!)?")
                print("1. Yes | 2. No | (0. Back, 99. Go First, 100. Show Cart)")
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1:
                        print("💬 Your \(self.menu!) is served heated.")
                        self.option = ["warm":1]
                        self.getNumber()
                        break
                    case 2:
                        print("💬 Your \(self.menu!) is served cold.")
                        self.option = ["warm":0]
                        self.getNumber()
                        break
                    case 0:
                        (self.menu, self.price, self.hotOrIced, self.size) = (nil, nil, nil, nil)
                        self.getMenu()
                        break
                    case 99:
                        (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size) = (nil, nil, nil, nil , nil, nil, nil)
                        self.getHereOrTogo()
                        break
                    case 100:
                        self.cart?.showCart()
                        if self.cart?.breakIndex == 1{
                            break
                        }
                    default:
                        self.printText("error")
                    }
                } else {
                    self.printText("error")
                }
            }
        default:
            self.option = ["None":0]
            self.getNumber()
            break
        }
    }
    
    func getOption(){
        while self.option == nil {
            switch self.type! {
            case let it where self.data.drink.contains(it):
                self.getDrinkOption()
                break
            default:
                self.getFoodOption()
                break
            }
        }
    }
        
    func getNumber(){
        while self.number == nil{
            print("💬 How many would you like to order?")
            print("You can order under 10.", terminator: " ")
            self.printText("menu1")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...9:
                    self.number = input
                    self.price! = self.price!*self.number!
                    print("\(input) \(self.menu!) will be served.")
                    self.confirmOrder()
                case 0:
                    if self.option == ["None":0]{
                        self.option = nil
                        if self.size == "None"{
                            self.size = nil
                            if self.hotOrIced == "None"{
                                (self.hotOrIced, self.menu, self.price) = (nil, nil, nil)
                                self.getMenu()
                                break
                            } else {
                                self.hotOrIced = nil
                                self.getHotOrIce()
                                break
                            }
                        } else {
                            self.size = nil
                            self.getSize()
                            break
                        }
                    } else {
                        self.option = nil
                        self.getOption()
                        break
                    }
                case 99:
                    (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option) = (nil, nil, nil, nil, nil, nil, nil, nil)
                    self.getHereOrTogo()
                    break
                case 100:
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default:
                    self.printText("error")
                }
            } else {
                self.printText("error")
            }
        }
    }
    
    func confirmOrder(){
        
    loop1: while true{
        print("💬 Shall I put your order into cart?")
        print("1. Yes | (0. Back, 99. Go First, 100. Show Cart)")
        
        if let input: Int = Int(readLine()!){
            switch input {
            case 1:
                self.cart!.getOrderInfo()
                (self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option, self.number) = (nil, nil, nil, nil, nil, nil, nil, nil)
                
            loop2: while true{
                print("💬 Would you like to order more? Or pay?")
                print("1. Order More | 2. Pay")
                
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1:
                        self.getCategory()
                        break loop1
                    case 2:
                        self.cart!.showOrderList()
                        self.cart!.confirmOrderList()
                        break loop1
                    default:
                        self.printText("error")
                    }
                } else {
                    self.printText("error")
                }
                }
            case 0:
                self.number = nil
                self.getNumber()
                break loop1
            case 99:
                (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option, self.number) = (nil, nil, nil, nil, nil, nil, nil, nil, nil)
                self.getHereOrTogo()
                break loop1
            case 100:
                self.cart?.showCart()
                if self.cart!.breakIndex == 1{
                    break loop1
                }
            default:
                self.printText("error")
            }
        } else {
            self.printText("error")
        }
        }
    }
}
//==============================================================================
let order = Order()
order.start()

