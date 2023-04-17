//
//  Cart.swift
//  Kiosk
//
//  Created by 이하경 on 2023/04/10.
//

import Foundation

class Cart{
    let order: Order
    var pay: Pay?
    var hereOrTogo: String?
    //(category, menu, hotOrIced, size, option, number)
    var orderInfo: (String?, String?, Int?, String?, String?, [String:Int]?, Int?)
    var orderList: [(String?, String?, Int?, String?, String?, [String:Int]?, Int?)]
    var breakIndex: Int
    
    init(order: Order){
        self.order = order
        self.pay = nil
        self.hereOrTogo = nil
        self.orderInfo = (nil, nil, nil, nil, nil, nil, nil)
        self.orderList = []
        self.breakIndex = 0
    }
    
    func getOrderInfo(){
//        self.hereOrTogo = self.order.hereOrTogo
        self.orderInfo = (self.order.category, self.order.menu, self.order.price, self.order.hotOrIced, self.order.size, self.order.option, self.order.number)
        
        self.addToOrderList()
    }
    
    func addToOrderList(){
        self.orderList.append(self.orderInfo)
    }
    
    func showOrderList(){
        print("-------------------------------------------------------[\(self.hereOrTogo!)]")
//        print("[\(self.hereOrTogo!)]")
        
        if self.orderList.count != 0{
            for index in 0..<self.orderList.count{
                
                if self.orderList[index].0 == "Food"{
                    print("\(self.orderList[index].1!) \(self.orderList[index].4!) size *\(self.orderList[index].6!)")
                    print("⤷ Option: ", terminator: "")
                    
                    for (_, value) in self.orderList[index].5!{
                        if value == 1 {
                            print("heated")
                        } else {
                            print("")
                        }
                    }
                    print("⤷ Price: ₩\(self.orderList[index].2!)")
                    
                } else {
                    print("\(self.orderList[index].3!) \(self.orderList[index].1!) \(self.orderList[index].4!) size *\(self.orderList[index].6!)")
                    print("⤷ Option: ", terminator: "")
                    
                    for (key, value) in self.orderList[index].5!{
                        if value != 0 {
                            print("\(value) \(key) ", terminator: "")
                        }
                    }
                    print("")
                    
                    print("⤷ Price: ₩\(self.orderList[index].2!)")
                }
                print("--------------------------------------------------------------")
            }
        } else {
            print("⚠️ You haven't ordered yet.")
            print("--------------------------------------------------------------")
        }
       
    }
    
    func showCart(){
        while true{
            self.showOrderList()
            print("1. Back | 2. Pay")
            let input: String? = readLine()
            
            if input == "1"{
                break
            } else if input == "2"{
                if self.orderList.count != 0{
                    self.breakIndex = 1
                    self.confirmOrderList()
                    break
                } else {
                    print("⚠️ There's no order to pay.")
                    break
                }
            } else {
                print("⚠️ Please input selectable numbers.")
                
            }
        }
    }
    
    func confirmOrderList(){
//        self.showOrderList()
    loop1: while true{
            print("💬 Would you like to change your order list?(Only delete or change number)")
            print("1. Yes | 2. No(Pay) | (0. Order more)")
            let input1: String? = readLine()
            
            if input1 == "0"{
                self.order.getCategory()
                break loop1
                
            } else if input1 == "1"{
            loop2: while true{
                    print("💬 Delete or Change number?")
                    print("1. Delete | 2. Change number | (0. Back)")
                    let input2: String? = readLine()
                    
                    if input2 == "0"{
                        break loop2
                    } else if input2 == "1"{
                        self.deleteOrder()
                        break loop1
                    } else if input2 == "2"{
                        self.changeNumberOfOrder()
                        break loop1
                    } else {
                        print("⚠️ Please input selectable numbers.")
                    }
                }

            } else if input1 == "2"{
                print("계산하기")
                self.pay = Pay(cart: self)
                self.pay?.getCartInfo()
                break loop1
                
            } else {
                print("⚠️ Please input selectable numbers.")
            }
        }
      
    }
    
    func deleteOrder(){
    loop1: while true{
            print("💬 Which order do you want to delete?")
            for index in 0..<self.orderList.count-1{
                print("\(index+1). \(self.orderList[index].1!)", terminator: " | ")
            }
            print("\(self.orderList.count). \(self.orderList[self.orderList.count-1].1!) | (0. Back)")
            let input1: String? = readLine()
            
            if input1 == "0"{
                self.showOrderList()
                self.confirmOrderList()
                break loop1
                
            } else if Int(input1!)! >= 1 && Int(input1!)! <= self.orderList.count{
            loop2: while true{
                    print("💬 Are you sure you want to delete?")
                    print("1. Yes | 2. No")
                    let input2: String? = readLine()
                    
                    if input2 == "1"{
                        self.orderList.remove(at: Int(input1!)!-1)
                        self.showOrderList()
                        self.confirmOrderList()
                        break loop1
                        
                    } else if input2 == "2"{
                        self.showOrderList()
                        self.confirmOrderList()
                        break loop1
                    } else {
                        print("⚠️ Please input selectable numbers.")
                    }
                }
                
            } else {
                print("⚠️ Please input selectable numbers.")
            }
            
        }
        
    }
    
    func changeNumberOfOrder(){
    loop1: while true{
            print("💬 Which order do you want to change?")
            for index in 0..<self.orderList.count-1{
                print("\(index+1). \(self.orderList[index].1!)", terminator: " | ")
            }
            print("\(self.orderList.count). \(self.orderList[self.orderList.count-1].1!) | (0. Back)")
            let input1: String? = readLine()
            
            if input1 == "0"{
                self.showOrderList()
                self.confirmOrderList()
                break loop1
                
            } else if Int(input1!)! >= 1 && Int(input1!)! <= self.orderList.count{
            loop2: while true{
                    print("💬 How many would you like to order?(You can order under 10.)")
                    let input2: String? = readLine()
                    
                    if Int(input2!)! >= 1 || Int(input2!)! < 10 {
                        self.orderList[Int(input1!)!-1].6 = Int(input2!)!
                        self.showOrderList()
                        self.confirmOrderList()
                        break loop1
                        
//                    } else if input2 == "2"{
//                        self.showOrderList()
//                        self.confirmOrderList()
//                        break loop1
                    } else {
                        print("⚠️ Please input selectable numbers.")
                    }
                }
                
            } else {
                print("⚠️ Please input selectable numbers.")
            }
            
        }
        
    }
    
    func putCartInfo(){
        
    }
}
