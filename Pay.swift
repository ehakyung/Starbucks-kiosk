//
//  Pay.swift
//  Kiosk
//
//  Created by 이하경 on 2023/04/17.
//

import Foundation

class Pay{
    let cart: Cart
    var hereOrTogo: String?
    //[(category, menu, price, hotOrIced, size, option, number)]
    var cartInfo: [(String?, String?, Int?, String?, String?, [String:Int]?, Int?)]
    var totalPrice: Int?
    
    init(cart: Cart){
        self.cart = cart
        self.hereOrTogo = nil
        self.cartInfo = []
        self.totalPrice = nil
    }
    
    func getCartInfo(){
        self.hereOrTogo = self.cart.hereOrTogo
        self.cartInfo = self.cart.orderList
    }
    
    func sum(){
        self.getCartInfo()
        self.totalPrice = 0
        for index in 0..<self.cartInfo.count{
            self.totalPrice! += self.cartInfo[index].2!
        }
        print("💬 The total amount is \(self.totalPrice!) won.")
        self.pay()
    }
    
    func pay(){
    loop1: while true{
            print("💬 How would you like to pay?")
            print("1. By credit card | 2. By Cash")
            let input1: String? = readLine()
            
            if input1 == "1"{
                print("💬 When you insert your card, the payment will be processed.")
                print("💬 \(self.totalPrice!) won has been paid.")
                self.printReceipt()
                self.cart.order.hereOrTogo = nil
                self.cart.hereOrTogo = nil
                self.cart.order.start()
                break loop1
                
            } else if input1 == "2"{
                print("💬 Put the cash in the slot.")
                var tmpInsert: Int? = 0
            loop2: while true{
                    
                    let input2: String? = readLine()
                    tmpInsert! += Int(input2!)!
                
                    if tmpInsert! > self.totalPrice!{
                        print("💬 It has been paid. Here's your change \(tmpInsert!-self.totalPrice!) won.")
                        self.printReceipt()
                        self.cart.order.hereOrTogo = nil
                        self.cart.hereOrTogo = nil
                        self.cart.order.start()
                        break loop1
                        
                    } else if tmpInsert! == self.totalPrice!{
                        print("💬 It has been paid.")
                        self.printReceipt()
                        self.cart.order.hereOrTogo = nil
                        self.cart.hereOrTogo = nil
                        self.cart.order.start()
                        break loop1
                        
                    } else if tmpInsert! < self.totalPrice!{
                        print("💬 Not enough money. Insert \(self.totalPrice!-tmpInsert!) won more.")
                    }
                }
            } else {
                print("⚠️ Please input selectable numbers.")
            }
        }
    }
    
    func printReceipt(){
        print("============================================================")
        print("                        RECEIPT")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string)
        print("")
        
        print("[\(self.hereOrTogo!)]")
        print("")
        
        for index in 0..<self.cartInfo.count{
            if self.cartInfo[index].0 == "Food"{
                print("\(index+1). \(self.cartInfo[index].1!) \(self.cartInfo[index].6!)ea (\(self.cartInfo[index].2!)won)")
                
                print("⤷ Option: ", terminator: "")
                
                for (_, value) in self.cartInfo[index].5!{
                    if value == 1 {
                        print("heated")
                    } else {
                        print("")
                    }
                }
                
            } else {
                print("\(index+1). \(self.cartInfo[index].3!) \(self.cartInfo[index].1!) \(self.cartInfo[index].6!)ea (\(self.cartInfo[index].2!)won)")
                
                print("⤷ Option: ", terminator: "")
                
                for (key, value) in self.cartInfo[index].5!{
                    if value != 0 {
                        print("\(value) \(key) ", terminator: "")
                    }
                }
                print("")
            }
        }
        print("")
        print("Total : \(self.totalPrice!)won")
        print("============================================================")
    }
}



