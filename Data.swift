//
//  Data.swift
//  Kiosk
//
//  Created by 이하경 on 2023/04/10.
//

import Foundation

class Data{
    
    let hereOrTogo: [String]
    let category: [String]
//    let menu: [String]
    
    let categoryArray: [[String]]
    
    let drink: [String]
    let food: [String]
    
    let drinkAndFood: [String]
    
    let md: [String]
    
    let refreshers: [String:Int]
    let coldBrew: [String:Int]
    let blondeCoffee: [String:Int]
    let espresso: [String:Int]
    let decafCoffee: [String:Int]
    let frappuccino: [String:Int]
    let blended: [String:Int]
    let fizzio: [String:Int]
    let teavana: [String:Int]
    let brewedCoffee: [String:Int]
    let others: [String:Int]
    let rtd: [String:Int]
    
    let bread: [String:Int]
    let cakeMiniDessert: [String:Int]
    let sandwichSalad: [String:Int]
    let hotFood: [String:Int]
    let fruitYogurt: [String:Int]
    let snack: [String:Int]
    let iceCream: [String:Int]

    let drinkAndFoodArray: [[String:Int]]

   
    var icedOnlyMenu: [String]
    let hotOnlyMenu: [String]
    let hotOrIced: [String]
    let sizeOfHot: [String]
    let sizeOfIced: [String]
    let sizeOfEspresso: [String]
    let espressoSizedMenu: [String]
    
    let optionOfHotDrink: [String:Int]
    let optionOfIcedDrink: [String:Int]
    let optionOfBreadAndSandwich: [String:Int]
    
    init(){
        self.hereOrTogo = ["Here", "To-go"]
        self.category = ["Drink", "Food", "MD(merchandise)"]

        self.drink = ["Refreshers", "Cold Brew", "Blonde Coffee", "Espresso", "Decaf Coffee", "Frappuccino", "Blended", "Fizzio", "Teavana", "Brewed Coffee", "Others", "RTD"]
        self.food = ["Bread", "Cake&Mini Dessert", "Sandwich&Salad", "Hot Food", "Fruit&Yogurt", "Snack", "Ice Cream"]
        
        self.drinkAndFood = self.drink + self.food
        
        self.md = ["Mug&Glass", "Tumbler", "ACC", "Brewing Item", "Whole Bean", "VIA", "Capsule", "Packaged Tea", "Syrup"]
        
        self.categoryArray = [self.drink, self.food, self.md]

        self.refreshers = ["Strawberry Acai with Lemonade Refresher":5900,
                           "Pink Drink with Strawberry Acai Refresher":5900] //iced only(all)
        self.coldBrew = ["Cold Brew with Oat":5800,
                         "Dolce Cold Brew":6000,
                         "Vanilla Cream Cold Brew":5800,
                         "Cold Brew":4900,
                         "Nitro Vanilla Cream":6100,
                         "Nitro Cold Brew":6000,
                         "Jeju Forest Cold Brew":6800,
                         "Signature The Black Cold Brew":19600,
                         "Jeju Citrus Honey Cold Brew":7200] //iced only(all)
        self.blondeCoffee = ["Iced Brown Sugar Oat Shaken Espresso":5900, //iced only
                             "Blonde Vanilla Double Shot Macchiato":5900,
                             "Blonde Starbucks Dolce Latte":5900,
                             "Blonde Caffe Latte":5000,
                             "Blonde Caffe Americano":4500,
                             "The Green Mugwort Cream Latte":7000]
        self.espresso = ["Choux Cream Latte":6300,
                         "Vanilla Flat White":5900, //hot only
                         "Starbucks Dolce Latte":5900,
                         "Caffe Mocha":5500,
                         "Caffe Americano":4500,
                         "Caffe Latte":5000,
                         "Cappuccino":5000,
                         "Caramel Macchiato":5900,
                         "White Chocolate Mocha":5900,
                         "Coffee Starbucks Double Shot":5100, //iced only
                         "Vanilla Starbucks Double Shot":5100, //iced only
                         "Hazelnut Starbucks Double Shot":5100, //iced only
                         "Espresso":4000, //hot only
                         "Espresso Macchiato":4000, //hot only
                         "Espresso Con Panna":4200] //hot only
        self.decafCoffee = ["Decaf Starbucks Dolce Latte":6200,
                            "Decaf Caramel Macchiato":6200,
                            "Decaf Caffe Latte":5300,
                            "Decaf Caffe Americano":4800,
                            "Half Decaf Starbucks Dolce Latte":6200,
                            "Half Decaf Caramel Macchiato":6200,
                            "Half Decaf Caffe Latte":5300,
                            "Half Decaf Caffe Americano":4800]
        self.frappuccino = ["Double Espresso Chip Frappuccino":6300,
                            "Malcha Cream Frappuccino from Jeju Organic Farm":6300,
                            "Java Chip Frappuccino":6300,
                            "Chocolate Cream Chip Frappuccino":6000,
                            "White Chocolate Mocha Frappuccino":6000,
                            "Caramel Frappiccino":5900,
                            "Espresso Frappuccino":5500,
                            "Vanilla Cream Frappuccino":5100,
                            "Jeju Black Sesame Cream Frappuccino":7500,
                            "Jeju Mugwort Cream Frappuccino":7500,
                            "White Tiger Fraoppuccino":6500] //iced only(all)
        self.blended = ["Basil Lemon Sherbet Blended":6500,
                        "Mint Chocolate Chip Blended":6300,
                        "Strawberry Delight Yogurt Blended":6300,
                        "Mango Banana Blended":6300,
                        "Mango Passion Tea Blended":5400,
                        "Red Power Smash Blended":6500,
                        "The Green Mugwort Blended":7200,
                        "Jeju Malcha&Apple Mango Blended":7500,
                        "Jeju Golden Tangerine Blended":7500] //iced only(all)
        self.fizzio = ["Yuja Passion Starbucks Fizzio":5900,
                       "Cool Lime Starbucks Fizzio":5900,
                       "Black Tea Lemonade Starbucks Fizzio":5400,
                       "Passion Tango Tea Lemonade Starbucks Fizzio":5400] //iced only(all)
        self.teavana = ["Pink Flower Youthberry Tea":6100, //iced only
                        "Earl Grey Vanilla Tea Latte":6100,
                        "Malcha Latte from Jeju Organic Farm":6100,
                        "Yuja Mint Tea":5900,
                        "Dolce Black Milk Tea":5900,
                        "Grapefruit Honey Black Tea":5700,
                        "Chai Tea Latte":5500,
                        "Blooming Fruit Y-Tea":8500,
                        "Malcha Tea-Einspanner":6500,
                        "Malcha Shot Affogato":7000, //iced only, size fixed
                        "Honey Earl Grey Milk Tea":6900,
                        "Jeju Organic Green Tea":5300,
                        "English Breakfast Brewed Tea":4500,
                        "Earl Grey Brewed Ted":4500,
                        "Youthberry Brewed Tea":4500,
                        "Hibiscus Blend Brewed Tea":4500,
                        "Mint Blend Brewed Tea":4500,
                        "Chamomile Blend Brewed Tea":4500,
                        "Jeju Golden Tangerine Passion Tea":7200,
                        "Red Power Passion Tea":5900]
        self.brewedCoffee = ["Brewed Coffee":4200, //hot only
                             "Iced Coffee":4500, //iced only
                             "Byuldabang Blend POC":5000,
                             "Byuldabang Blend CMX":5000]
        self.others = ["Spring Strawberry Milk":6900, //iced only
                       "Vanilla Affogato":5900, //iced only
                       "Chocolate Affocato":5900, //iced only
                       "Java Chip Vanilla Affogato":6600, //iced only
                       "Java Chip Chocolate Affogato":6600, //iced only
                       "Signature Chocolate":5700,
                       "Steamed Milk":4100, //hot only
                       "Milk":4100, //iced only
                       "Jeju Black Sesame Latte":7200,
                       "Fluffy Panda Chocolate":6500,
                       "Red Power Smasher":6500, //iced only
                       "Starbuck Slammer":6500] //iced only
        self.rtd = ["Applemango Coconut":4500,
                    "Hallabong Coconut":4500,
                    "Fill The Yellow":4500,
                    "Fill The Red":4500,
                    "Fill The Green":4500,
                    "Organic Orange Juice":4500,
                    "Star Ruby Grapefruit Sweet":4100,
                    "Pink Dragon Fruit Lemonade":4300,
                    "Strawberry Yogurt":4100,
                    "Newly Harvested Apple Juice":4000,
                    "Strawberry Juice":3800,
                    "Mango Juice":4500,
                    "Kale&Apple Juice":4000,
                    "Hallabong Juice":4300,
                    "Blueberry Yogurt":3900,
                    "Evian Water":2500,
                    "Perrier Lime":3300,
                    "Organic Sparkling Apple Juice":4800,
                    "Samdasoo Water":950] //size fixed(all)

        self.bread = ["Potato Onion Cream Cheese Bagel":5900,
                      "Nutty Croissant":4900,
                      "Sweet Pumpkin Chestnut Bread":4500,
                      "Honey Triple Cheese Croissant":6900,
                      "Tiramisu Cream Danish":5500,
                      "AOP Butter Pain Au Chocolat":5100,
                      "Honey Cheese Walnut Bread":6900,
                      "Apple Turnover":4600,
                      "Apple Turnover&Organic Ice Cream":7500,
                      "Onion Cream Basil Roll":5800,
                      "Peanut Cream Cinnamon Roll":5800,
                      "AOP Butter Croissant":4900,
                      "Pumpkin Cream Cheese Bread":4800,
                      "Gourmet Butter Pretzel":5500,
                      "Mascarpone Cream Montblanc":7900,
                      "Salted Caramel Palmier Carre":6500,
                      "Basil Tomato Cream Cheese Bagel":5300,
                      "Blueberry Bagel":3000,
                      "Cheese Bagel": 3000,
                      "Classic Scone":3300,
                      "Mini Classic Scone":4000,
                      "Sweet Milk Bread":4300,
                      "Cheese and Honey Mini Bites Bread":4700,
                      "Heart Pie":3200,
                      "Mini Leaf Pie":3900,
                      "Smoked Sausage Bread":4500,
                      "Spicy Sausage Bulgogi Bake":4800,
                      "Peanut Mugwort Rice Cake Scone":5200,
                      "Oreum Cheese Cake Pastry":5900,
                      "Jeju Columnar joint Pie":4700,
                      "Olle Mini Croissant":4900,
                      "Black Mountain Croissant":4700,
                      "Cream Cheese Brioche Bostock":4900,
                      "Red Bean Butter Scone":4300,
                      "Cheongdam Ginger Cake":4800,
                      "English Butter Scone":3800,
                      "Quattro Cheese Scone":4600,
                      "Pain au chocolat":4200,
                      "Cheddar Jalapeno Ciabatta":4200,
                      "Bacon Cheese Twist":4800]
        self.cakeMiniDessert = ["Basque Cheese Cake":7900,
                                "Earl Grey Chocolate Cake":6500,
                                "Sweet Potato Cream Cake":5900,
                                "Choux Cream Baumkuchen":6900,
                                "Fresh Cream Castella":4500,
                                "Mascarpone Tiramisu Cake":5900,
                                "Tiramisu Roll Cake":5900,
                                "7 Layer Ganache Cake":5700,
                                "The Chocolate Fresh Cream Cake":5900,
                                "Blueberry Cookie Cheese Cake":6900,
                                "Cloud Cheese Cake":5500,
                                "Red Velvel Cream Cheese Cake":5500,
                                "Love's Chocolate Macaron":3200,
                                "Love's Strawberry Macaron":3200,
                                "Vanilla Macaron":2700,
                                "Blueberry Macaron":2700,
                                "Camembert Cheese Financier":3300,
                                "Chocolate Financier":3300,
                                "Stick Egg Tart":4200,
                                "Hallabong Cream Cake":7500,
                                "Peanut Butter Cheese Cake":6500,
                                "Peanut Madeleine":3900,
                                "Hallabong Madeleine":3900,
                                "Green Tea Cream Roll Cake":7500,
                                "Peanut Cream Roll Cake":7500,
                                "Jeju Carrot Basalt Cake":6800,
                                "Jeju Cactus Chocolate Cake":7200,
                                "Raspberry Chocolate Cake":5900,
                                "Lemon Basil Cream Cake":6900,
                                "Crunch Ganache Layer Cake":7900,
                                "Classic Tiramisu":7900,
                                "Oh Honey Cake":7400,
                                "Oh Green Piece":7400,
                                "Chengdam Custard&Mascarpone Cake":9600,
                                "Cheongdam Lemon Tart":6400,
                                "Ugly Cheese Cake":3800,
                                "Earl Grey Milk Cake":6400,
                                "Red bean&Butter Cake":8900,
                                "Mont Blanc Cheese Cake":8900,
                                "Blueberry Cheese Cake":8900,
                                "Burnt Cheese Cake":7500,
                                "Walnut Chocolate Fudge Cake":8900,
                                "Apple Pie&Organic Ice Cream":9500]
        self.sandwichSalad = ["Chicken Tomoto Cheese Sandwich":7800,
                              "Chicken Classic Sandwich":6900,
                              "Cheese Port Cutlet Sandwich":6200,
                              "BELT Sandwich":5900,
                              "Jambon Bagel Sandwich":6300,
                              "Cobb&White Salad Meal Box":6500,
                              "Bacon Cheese Toast":4900,
                              "Ham&Rucola Olive Sandwich":6200,
                              "Triple Cheese Croque Monsieur":5200,
                              "Barbeque Chicken Cheese Ciabatta":5800,
                              "Breakfast English Muffin":4200,
                              "Egg Egg Sandwich":4400,
                              "Cranberry Chicken Cheese Sandwich":4500,
                              "Sweet&Pumpkin Egg Sandwich":4900,
                              "Jeju Carrot Sandwich":8500,
                              "Jeju Pulled Pork Sandwich":8900,
                              "Jeju Green Tea Bacon Cheese Bagel":6200,
                              "Chicken Pesto Sandwich&Soup Set":14000,
                              "Bacon Avocado Sandwich&Salad Set":9800,
                              "Chicken Pesto Sandwich&Salad Set":9800,
                              "Have A Marvelous HAM Sandwich":8300,
                              "Chicken Avocado Sandwich":7500,
                              "Bacon Avocado Sandwich":9800,
                              "Melted Three-Cheese Sandwich":8600,
                              "Chicken Pesto Sandwich":9800,
                              "Spicy Chicken Bacon Wrap":7400,
                              "Mortadela Ham&Cheese Sandwich":7900,
                              "Triple Cheese Croque Madame Brunch Set":12900,
                              "Ham&Rucola Croissant Sandwich":7900,
                              "Jambon Beurre Sandwich":8500,
                              "Fig Ricotta Open Sandwich":7500,
                              "Brioche Brunch Set":13500]
        self.hotFood = ["Tomato Rose Soup":4200,
                        "Sweet Pumpkin Soup":4200,
                        "Truffle Mushroom Soup":4200]
        self.fruitYogurt = ["Grapefruit Handy Jelly":2800,
                            "Organic Greek Yogurt Plain":4200,
                            "Organic Protein Greek Yogurt&Granola":5900,
                            "A Fresh Cup A day, Red":2600,
                            "Premium Banana":1500,
                            "Hallabong Handy Jelly":2800,
                            "Apple Handy Jelly":2800,
                            "New Milk Pudding":3300,
                            "New Chocolate Pudding":3300,
                            "Frozen Dried Fruit":2900]
        self.snack = ["Curtis Kulig Love's Caramel Gold":19900,
                      "Curtis Kulig Love's Caramel Pink":19900,
                      "Curtis Kulig Love's Jelly Pink":15900,
                      "Curtis Kulig Love's Jelly Red":15900,
                      "Castella Rusk":3900,
                      "Real Sweet Potato":3800,
                      "Black Soy Bean&Five Grain Crunch":3400,
                      "Real Tofu Chip":3400,
                      "Simply Gum":4500,
                      "Curtis Kulig Love's chocolate Red":12000,
                      "Curtis Kulig Love's chocolate Pink":12000,
                      "Probiotics Yellow Food Shake":2700,
                      "Collagen Red Food Shake":2700,
                      "Protein Black Food Shake":2700,
                      "Rice Castella":9500,
                      "Double Cheese Bagel Chip":2700,
                      "Rice Chips with Blueberry Jam":2700,
                      "Caramel Waffle":2300,
                      "Dark Chocolate Cowboy Cookie":2800,
                      "White Chocolate Cowboy Cookie":2800,
                      "Chunk Chocolate Cookie Set":15900,
                      "Xylitol Candy Crystal Mint":3300,
                      "Sea Friends Candy":4500,
                      "Almond Toffee Candy":3500,
                      "Logo Coin Milk Chocolate Silver":4800,
                      "Logo Coin Milk Chocolate Gold":4800,
                      "Nuts&Blueberry":2000,
                      "Steamed Chestnut":3300,
                      "Chocolate Walnut Dome Cookie":3500,
                      "Cube Rice Castella":3300,
                      "Reserve Chocolate Set":9900,
                      "Basalt Rusk":3800,
                      "Jeju Oreum Chocolate Set":18500,
                      "Smile Cookie Chocolate":4200,
                      "Smile Cookie Raspberry":4200]
        self.iceCream = ["Organic Ice Cream Vanilla":2900,
                         "Organic Ice Cream Chocolate":2900,
                         "Organic Ice Cream Vanilla topped with Java Chip":3600,
                         "Organic Ice Cream Chocolate topped with Java Chip":3600]
        
        self.drinkAndFoodArray = [self.refreshers, self.coldBrew, self.blondeCoffee, self.espresso, self.decafCoffee, self.frappuccino, self.blended, self.fizzio, self.teavana, self.brewedCoffee, self.others, self.rtd, self.bread, self.cakeMiniDessert, self.sandwichSalad, self.hotFood, self.fruitYogurt, self.snack, self.iceCream]
        
   
        
        self.icedOnlyMenu = ["Iced Brown Sugar Oat Shaken Espresso", "Coffee Starbucks Double Shot", "Vanilla Starbucks Double Shot", "Hazelnut Starbucks Double Shot", "Pink Flower Youthberry Tea", "Malcha Shot Affogato", "Iced Coffee", "Spring Strawberry Milk", "Vanilla Affogato", "Chocolate Affocato", "Java Chip Vanilla Affogato", "Java Chip Chocolate Affogato", "Milk", "Red Power Smasher", "Starbuck Slammer"]
        

//        for (key, _) in self.refreshers{
//            self.icedOnlyMenu.append(key)
//        }
//        for (key, _) in self.coldBrew{
//            self.icedOnlyMenu.append(key)
//        }
//        for (key, _) in self.frappuccino{
//            self.icedOnlyMenu.append(key)
//        }
//        for (key, _) in self.blended{
//            self.icedOnlyMenu.append(key)
//        }
//        for (key, _) in self.fizzio{
//            self.icedOnlyMenu.append(key)
//        }
        self.icedOnlyMenu += self.refreshers.keys
        self.icedOnlyMenu += self.coldBrew.keys
        self.icedOnlyMenu += self.frappuccino.keys
        self.icedOnlyMenu += self.blended.keys
        self.icedOnlyMenu += self.fizzio.keys
        
        self.hotOnlyMenu = ["Vanilla Flat White", "Espresso", "Espresso Macchiato", "Espresso Con Panna", "Brewed Coffee", "Steamed Milk"]
        
        self.hotOrIced = ["Hot", "Iced"]
        
        self.sizeOfHot = ["Short", "Tall", "Grande", "Venti"]
        self.sizeOfIced = ["Tall", "Grande", "Venti"]
        self.sizeOfEspresso = ["Solo", "Doppio"]
        
        self.espressoSizedMenu = ["Espresso", "Espresso Macchiato", "Espresso Con Panna"]
        
        self.optionOfHotDrink = ["addEspresso":600, "addSyrup":600, "withWhip":600, "withDrizzle":600]
        self.optionOfIcedDrink = ["addEspresso":600, "addSyrup":600, "moreIce":0, "withWhip":600, "withDrizzle":600]
        self.optionOfBreadAndSandwich = ["warm":0]
//        enum HereOrTogo: String{
//            case here = "1"
//            case togo = "2"
//        let category = ["Drink", "Food", "MD"]
//        let drink = ["Coffee", "Beverge", "Blending Tea", "Flatccino", "Shake/Ade", "Ice Flakes", "RTD", "Season Drink" ]
//        let food = ["Bread", "Dessert", "Deli", "RTE", "Season Food"
//        ]

    }
}
