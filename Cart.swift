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
    //(category, menu, price, hotOrIced, size, option, number)
    var orderInfo: (String?, String?, Int?, String?, String?, [String:Int]?, Int?)
    var orderList: [(String?, String?, Int?, String?, String?, [String:Int]?, Int?)]
    
    var breakIndex: Int?
    
    init(order: Order){
    //=======================================================================================[Property]
        self.order = order
        self.pay = nil
        
        self.hereOrTogo = nil
        self.orderInfo = (nil, nil, nil, nil, nil, nil, nil)
        self.orderList = []
        
        self.breakIndex = nil
    }
    //===================================================================================[Method (sub)]
    func printOrderList(){
        for index in 0..<self.orderList.count{
            print("\(index+1). \(self.orderList[index].1!)", terminator: " | ")
        }
        self.order.printText("menu3")
    }
    func getOrderInfo(){
        
        self.orderInfo = (self.order.category, self.order.menu, self.order.price, self.order.hotOrIced, self.order.size, self.order.option, self.order.number)
        
        self.orderList.append(self.orderInfo)
    }
    //===================================================================================[Method (main)]
    func showOrderList(){
        
        print("-------------------------------------------------------[\(self.hereOrTogo!)]")
        if self.orderList.count != 0{ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・카트에 담긴 주문 있는 경우
            for index in 0..<self.orderList.count{
                if self.orderList[index].0 == "Food"{ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・분류가 food인 경우
                    print("\(self.orderList[index].1!) \(self.orderList[index].4!) size *\(self.orderList[index].6!)")
                    print("⤷ Option: ", terminator: "")
                    for (_, value) in self.orderList[index].5!{
                        if value == 1 {
                            print("heated")
                        } else {
                            print("")
                        }
                    }
                    print("⤷ Price: \(self.orderList[index].2!) won")
                    
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・분류가 drink인 경우
                    print("\(self.orderList[index].3!) \(self.orderList[index].1!) \(self.orderList[index].4!) size *\(self.orderList[index].6!)")
                    print("⤷ Option: ", terminator: "")
                    for (key, value) in self.orderList[index].5!{
                        if value != 0 {
                            print("\(value) \(key) ", terminator: "")
                        }
                    }
                    print("")
                    print("⤷ Price: \(self.orderList[index].2!) won")
                }
                print("--------------------------------------------------------------")
            }
            
        } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・카트에 담긴 주문 없는 경우
            print("⚠️ You haven't ordered yet.")
            print("--------------------------------------------------------------")
        }
    }
    
    func showCart(){
        
        while true{
            self.breakIndex = 0
            self.showOrderList()
            print("1. Back | 2. Pay")
            
            if let input: Int = Int(readLine()!){
                switch input {
                case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 뒤로(주문페이지로) 돌아가기
                    break
                case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・2: 결제하기
                    if self.orderList.count != 0{ //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・카트에 담긴 주문 있는 경우
                        self.breakIndex = 1
                        self.confirmOrderList()
                        break
                    } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・카트에 담긴 주문 없는 경우
                        print("⚠️ There's no order to pay.")
                        break
                    }
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~2 외
                    self.order.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.order.printText("error")
            }
        }
    }
    
    func confirmOrderList(){

        loop1: while true{
            print("💬 Would you like to change your order list?(Only delete or change number)")
            print("1. Yes | 2. No(Pay) | (0. Order more)")
            
            if let input1: Int = Int(readLine()!){
                switch input1 {
                case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 주문 수정하기
                loop2: while true {
                    print("💬 Delete or Change number?")
                    print("1. Delete | 2. Change number | (0. Back)")
                    
                    if let input2: Int = Int(readLine()!){
                        switch input2 {
                        case 1: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 삭제
                            self.deleteOrder()
                            break loop1
                        case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・2: 수량변경
                            self.changeNumberOfOrder()
                            break loop1
                        case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                            break loop2
                        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~2 외
                            self.order.printText("error")
                        }
                    } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                        self.order.printText("error")
                    }
                }
                case 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・2: 결제하기
                    self.pay = Pay(cart: self)
                    self.pay?.sum()
                    break loop1
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    self.order.getCategory()
                    break loop1
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~2 외
                    self.order.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.order.printText("error")
            }
        }
    }
    
    func deleteOrder(){
        
        loop1: while true{
            print("💬 Which order do you want to delete?")
            self.printOrderList()
            
            if let input1: Int = Int(readLine()!){
                switch input1 {
                case 1...self.orderList.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: 삭제할 주문
                loop2: while true{
                    print("💬 Are you sure you want to delete?")
                    print("1. Yes | 2. No")
                    
                    if let input2: Int = Int(readLine()!){
                        switch input2 {
                        case 1, 2: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1: 삭제 확정 / 2: 삭제 취소
                            if input2 == 1{
                                self.orderList.remove(at: input1-1)
                            }
                            self.showOrderList()
                            self.confirmOrderList()
                            break loop1
                        default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~2 외
                            self.order.printText("error")
                        }
                    } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                        self.order.printText("error")
                    }
                }
                case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                    self.showOrderList()
                    self.confirmOrderList()
                    break loop1
                default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~ 외
                    self.order.printText("error")
                }
            } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                self.order.printText("error")
            }
        }
    }
    
    func changeNumberOfOrder(){
    loop1: while true{
        print("💬 Which order do you want to change?")
        self.printOrderList()
        
        if let input1: Int = Int(readLine()!){
            switch input1 {
            case 1...self.orderList.count: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: 수량변경할 주문
            loop2: while true{
                print("💬 How many would you like to order?(You can order under 10.)")
                if let input2: Int = Int(readLine()!){
                    switch input2 {
                    case 1...9: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・1~: 변경 후 수량
                        self.orderList[input1-1].6 = input2
                        self.showOrderList()
                        self.confirmOrderList()
                        break loop1
                    default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)1~9 외
                        self.order.printText("error")
                    }
                } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
                    self.order.printText("error")
                }
            }
            case 0: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・0: 이전단계
                self.showOrderList()
                self.confirmOrderList()
                break loop1
            default: //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)0~ 외
                self.order.printText("error")
            }
        } else { //・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・(예외)Int 변환불가
            self.order.printText("error")
        }
        }
    }
}
