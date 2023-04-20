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
    //=======================================================================================[Property]
        self.cart = cart
        self.hereOrTogo = nil
        self.cartInfo = []
        self.totalPrice = nil
    }
    //===================================================================================[Method (sub)]
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
    //===================================================================================[Method (main)]
    func pay(){
    loop1: while true{
        print("💬 How would you like to pay?")
        print("1. By credit card | 2. By Cash")
        if let input: Int = Int(readLine()!){
            switch input{
            case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 카드 결제
                print("💬 When you insert your card, the payment will be processed.")
                print("💬 \(self.totalPrice!) won has been paid.")
                self.printReceipt()
                (self.cart.order.hereOrTogo, self.cart.hereOrTogo) = (nil, nil)
                self.cart.order.start()
                break loop1
            case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・2: 현금 결제
                print("💬 Put the cash in the slot.")
                var tmpInsert: Int? = 0
            loop2: while true{
                if let input2: Int = Int(readLine()!){
                    tmpInsert! += input2
                    switch tmpInsert! {
                    case let it where it > self.totalPrice! || it == self.totalPrice!://・・・결제금액 투입된 경우
                        if it > self.totalPrice!{
                            print("💬 It has been paid. Here's your change \(tmpInsert!-self.totalPrice!) won.")
                        } else {
                            print("💬 It has been paid.")
                        }
                        self.printReceipt()
                        (self.cart.order.hereOrTogo, self.cart.hereOrTogo) = (nil, nil)
                        self.cart.order.start()
                        break loop1
                    case let it where it < self.totalPrice!: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・결제금액보다 적게 투입된 경우
                        print("💬 Not enough money. Insert \(self.totalPrice!-tmpInsert!) won more.")
                    default:
                        self.cart.order.printText("error")
                    }
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                    self.cart.order.printText("error")
                }
                }
            default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~2 외
                self.cart.order.printText("error")
            }
        } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
            self.cart.order.printText("error")
        }
        }
    }
    
    func printReceipt(){
        print("============================================================")
        print("                        RECEIPT")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string) //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・결제 일시
        print("")
        
        print("[\(self.hereOrTogo!)]") //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・포장 여부
        print("")
        
        for index in 0..<self.cartInfo.count{ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・주문 내역
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
        print("Total : \(self.totalPrice!)won") //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・총 금액
        print("============================================================")
    }
}



