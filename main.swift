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
    //=======================================================================================[Property]
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
    //===================================================================================[Method (sub)]
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
    
    //===================================================================================[Method (main)]
    
    func start(){
        
        print("💚 WELCOME TO STARBUCKS 💚")
        self.getHereOrTogo()
    }
    
    func getHereOrTogo(){

        while self.hereOrTogo == nil{
            print("💬 For Here Or Togo?")
            self.printArray(self.data.hereOrTogo, "menu3")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1, 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: here, 2: togo
                    self.hereOrTogo = self.data.hereOrTogo[input-1]
                    self.cart = Cart(order: self)
                    self.cart?.hereOrTogo = self.hereOrTogo
                    print("💬 You chose \(self.hereOrTogo!).")
                    
                    self.getCategory()
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    self.start()
                    break
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~2 외
                    self.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
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
                case 1...self.data.category.count://・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: drink 또는 food
                    self.category = self.data.category[input-1]
                    print("💬 You chose \(self.category!).")
                    self.getType()
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    self.hereOrTogo = nil
                    self.getHereOrTogo()
                    break
                case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 100 외
                    self.printText("error")
                }
                
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.printText("error")
            }
        }
    }
    
    func getType(){
        
        var tmpArray: [String] = []
        for index in 0..<self.data.category.count{
            if self.category == self.data.category[index]{
                tmpArray = self.data.categoryArray[index]
            }
        }
        
        while self.type == nil{
            print("💬 What type of \(self.category!) do you want to order?")
            self.printArray(tmpArray, "menu1")
    
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...tmpArray.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: drink 또는 food 종류
                    self.type = tmpArray[input-1]
                    print("💬 You chose \(self.type!).")
                    self.getMenu()
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    self.category = nil
                    self.getCategory()
                    break
                case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                    (self.hereOrTogo, self.category) = (nil, nil)
                    self.getHereOrTogo()
                    break
                case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                    self.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.printText("error")
            }
        }
    }
    
    func getMenu(){
        
        var tmpDic: [String:Int] = [:]
        var tmpArray: [String] = []
        for index in 0..<self.data.drinkAndFood.count{
            if self.type! == self.data.drinkAndFood[index]{
                tmpDic = self.data.drinkAndFoodArray[index]
                tmpArray = tmpDic.keys.sorted()
            }
        }
        
        while self.menu == nil{
            print("💬 Which \(self.type!) do you want?")
            self.printDic(tmpDic, tmpArray, "menu1")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...tmpArray.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: 메뉴
                    self.menu = tmpArray[input-1]
                    self.price = tmpDic[tmpArray[input-1]]!
                    print("💬 You chose \(self.menu!).")
                    self.getHotOrIce()
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    self.type = nil
                    self.getType()
                    break
                case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                    (self.hereOrTogo, self.category, self.type) = (nil, nil, nil)
                    self.getHereOrTogo()
                    break
                case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                    self.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.printText("error")
            }
        }
    }
        
    func getHotOrIce(){

        switch self.type!{
        case let it where self.data.drink.contains(it): //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・분류가 drink일 때
            switch self.menu!{
            case let it where self.data.hotOnlyMenu.contains(it) || self.data.icedOnlyMenu.contains(it):
                if self.data.hotOnlyMenu.contains(it){ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・hot/iced 선택권 없는 경우 1
                    self.hotOrIced = "Hot"
                } else {
                    self.hotOrIced = "Iced"
                }
                print("💬 \(self.menu!) is served only \(self.hotOrIced!).")
                self.getSize()
            case let it where self.data.rtd.keys.contains(it): //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・hot/iced 선택권 없는 경우 2
                self.hotOrIced = "None"
                self.getSize()
            default:
                while self.hotOrIced == nil {
                    print("💬 Would you like your \(self.menu!) served Hot or Iced?")
                    self.printArray(self.data.hotOrIced, "menu1")
                    
                    if let input: Int = Int(readLine()!){
                        switch input {
                        case 1...self.data.hotOrIced.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: hot 또는 iced
                            self.hotOrIced = self.data.hotOrIced[input-1]
                            print("💬 Your \(self.menu!) will be served \(self.hotOrIced!).")
                            self.getSize()
                            break
                        case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                            (self.menu, self.price) = (nil, nil)
                            self.getMenu()
                            break
                        case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                            (self.hereOrTogo, self.category, self.type, self.menu, self.price) = (nil, nil, nil, nil, nil)
                            self.getHereOrTogo()
                            break
                        case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                            self.cart?.showCart()
                            if self.cart?.breakIndex == 1{
                                break
                            }
                        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                            self.printText("error")
                        }
                    } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                        self.printText("error")
                    }
                }
            }
        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・분류가 food일 때
            self.hotOrIced = "None"
            self.getSize()
            break
        }
    }
            
    func getSize(){
        var tmpArray: [String] = []
        let tmpDic: [String:Int] = self.data.priceOfsize
        
        switch self.type! {
        case let it where self.data.drink.contains(it): //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・분류가 drink일 때
            switch self.menu! {
            case let it where self.data.rtd.keys.contains(it) || self.data.noneSizedDrink.contains(it):
                self.size = "None" //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・크기 선택권 없는 경우
                self.getOption()
            case let it where self.data.espressoSizedMenu.contains(it): //・・・・・・・・・・・・・・에스프레소 사이즈만 가능한 경우
                tmpArray = self.data.sizeOfEspresso
            default:
                if self.hotOrIced! == "Hot"{ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・뜨거운 음료 사이즈만 가능한 경우
                    tmpArray = self.data.sizeOfHot
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・차가운 음료 사이즈만 가능한 경우
                    tmpArray = self.data.sizeOfIced
                }
            }
        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・분류가 food일 때
            self.size = "None"
            self.getOption()
        }
        
        while self.size == nil{
            print("💬 What size \(self.menu!) would you like?")
            self.printDic(tmpDic, tmpArray, "menu1")
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...tmpArray.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: 각 경우별 사이즈
                    self.size = tmpArray[input-1]
                    self.price! += tmpDic[tmpArray[input-1]]!
                    print("💬 You chose \(self.size!) size.")
                    self.getOption()
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    if self.data.hotOnlyMenu.contains(self.menu!) || self.data.icedOnlyMenu.contains(self.menu!) || self.hotOrIced == "None"{
                        (self.hotOrIced, self.menu, self.price) = (nil, nil, nil)
                        self.getMenu()
                        break
                    } else {
                        self.hotOrIced = nil
                        self.getHotOrIce()
                        break
                    }
                case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                    (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced) = (nil, nil, nil , nil, nil, nil)
                    self.getHereOrTogo()
                    break
                case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                    self.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.printText("error")
            }
        }
    }
            
    func getDrinkOption(){
        var tmpDic: [String:Int] = [:]
        var tmpArray: [String] = []
        
        switch self.hotOrIced! {
        case "Hot", "Iced": //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・hot 또는 iced인 음료의 경우
            if self.hotOrIced == "Hot"{
                tmpDic = self.data.optionOfHotDrink
                self.option = ["addEspresso":0, "addSyrup":0, "withWhip":0, "withDrizzle":0]
            } else {
                tmpDic = self.data.optionOfIcedDrink
                self.option = ["addEspresso":0, "addSyrup":0, "moreIce":0, "withWhip":0, "withDrizzle":0]
            }
            tmpArray = tmpDic.keys.sorted()
        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・병음료의 경우
            self.option = ["None":0]
            self.getNumber()
        }
        
    loop1: while self.option != ["None":0]{
        print("💬 Which option would you like to add to your \(self.menu!)?")
        self.printArray(tmpArray + ["No Option"], "menu1")
        
        if let input1: Int = Int(readLine()!){
            switch input1 {
            case 1...tmpArray.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: 각 옵션
                switch input1 {
                case 3: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・얼음 많이(선택 또는 미선택)
                    if self.hotOrIced == "Iced"{
                        self.option!.updateValue(1, forKey: "moreIce")
                        print("💬 More ice is served.")
                    } else {
                        fallthrough
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・그 외 옵션(횟수)
                loop2:while true{
                        print("💬 How many? You can add 1 to 9 times.")
                        if let input2: Int = Int(readLine()!){
                            switch input2 {
                            case 1...9: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~9: 추가 횟수
                                self.option!.updateValue(input2, forKey: tmpArray[input1-1])
                                self.price! += (tmpDic[tmpArray[input1-1]]!)*input2
                                print("💬 \(input2) times \(tmpArray[input1-1]) is served.")
                                break loop2
                            default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~9 외
                                self.printText("error")
                            }
                        } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                            self.printText("error")
                        }
                    }
                    
                }
            loop3:while true{
                print("💬 Do you want more option?")
                print("1. Yes | 2. No")
                
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 추가 옵션 있음
                        break loop3
                    case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・2: 추가 옵션 없음
                        self.getNumber()
                        break loop1
                    default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~2 외
                        self.printText("error")
                    }
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                    self.printText("error")
                }
                }
            case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
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
            case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option) = (nil, nil, nil, nil, nil , nil, nil, nil)
                self.getHereOrTogo()
                break
                
            case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                self.cart?.showCart()
                if self.cart?.breakIndex == 1{
                    break
                }
            default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                self.printText("error")
            }
        } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
            self.printText("error")
        }
    }
    }
    
    func getFoodOption(){
        switch self.menu! {
        case let it where self.data.bread.keys.contains(it) || self.data.sandwichSalad.keys.contains(it) :
            while self.option == nil{ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・빵, 샌드위치인 경우
                print("💬 Do you want me to heat up your \(self.menu!)?")
                print("1. Yes | 2. No | (0. Back, 99. Go First, 100. Show Cart)")
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 데우기
                        print("💬 Your \(self.menu!) is served heated.")
                        self.option = ["warm":1]
                        self.getNumber()
                    case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 데우지 않기
                        print("💬 Your \(self.menu!) is served cold.")
                        self.option = ["warm":0]
                        self.getNumber()
                    case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                        (self.menu, self.price, self.hotOrIced, self.size) = (nil, nil, nil, nil)
                        self.getMenu()
                        break
                    case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                        (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size) = (nil, nil, nil, nil , nil, nil, nil)
                        self.getHereOrTogo()
                        break
                    case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                        self.cart?.showCart()
                        if self.cart?.breakIndex == 1{
                            break
                        }
                    default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                        self.printText("error")
                    }
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                    self.printText("error")
                }
            }
        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・빵, 샌드위치 아닌 경우(데우기 옵션 없음)
            self.option = ["None":0]
            self.getNumber()
        }
    }
    
    func getOption(){
        switch self.type! {
        case let it where self.data.drink.contains(it):
            self.getDrinkOption()
        default:
            self.getFoodOption()
        }
    }
        
    func getNumber(){
        while self.number == nil{
            print("💬 How many would you like to order?")
            print("You can order under 10.", terminator: " ")
            self.printText("menu1")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1...9: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~9: 구매 수량
                    self.number = input
                    self.price! = self.price!*self.number!
                    print("\(input) \(self.menu!) will be served.")
                    self.confirmOrder()
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
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
                case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                    (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option) = (nil, nil, nil, nil, nil, nil, nil, nil)
                    self.getHereOrTogo()
                    break
                case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                    self.cart?.showCart()
                    if self.cart?.breakIndex == 1{
                        break
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                    self.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
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
            case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 카트에 넣기
                self.cart!.getOrderInfo()
                (self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option, self.number) = (nil, nil, nil, nil, nil, nil, nil, nil)
                
            loop2: while true{
                print("💬 Would you like to order more? Or pay?")
                print("1. Order More | 2. Pay")
                
                if let input: Int = Int(readLine()!){
                    switch input {
                    case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 추가 주문하기
                        self.getCategory()
                        break loop1
                    case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・2: 결제하기
                        self.cart!.showOrderList()
                        self.cart!.confirmOrderList()
                        break loop1
                    default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~2 외
                        self.printText("error")
                    }
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                    self.printText("error")
                }
                }
            case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                self.number = nil
                self.getNumber()
                break loop1
            case 99: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・99: 처음으로
                (self.hereOrTogo, self.category, self.type, self.menu, self.price, self.hotOrIced, self.size, self.option, self.number) = (nil, nil, nil, nil, nil, nil, nil, nil, nil)
                self.getHereOrTogo()
                break loop1
            case 100: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・100: 카트보기
                self.cart?.showCart()
                if self.cart!.breakIndex == 1{
                    break loop1
                }
            default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~, 99, 100 외
                self.printText("error")
            }
        } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
            self.printText("error")
        }
        }
    }
}
//============================================================================================[Program]
let order = Order()
order.start()

