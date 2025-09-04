//
//  50.ViewModel.swift
//  FirstCourse
//
//  Created by Алан Парастаев on 03.09.2025.
//

import SwiftUI

struct FruitModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}



class FruitViewModel: ObservableObject {
    
    @Published var fruitArray: [FruitModel] = []
    @Published var isLoading: Bool = false
    
    /* Этот init() активирует функцию getFruits(), как только мы укажем инициализацию этого класса в коде ниже FruitViewModel = .init() (проще говоря как только мы напишем инициализацию этого клааса, в любой структуре View отработает инициализация  getFruits()*/
    init() {
        getFruits()
    }
    
    func getFruits() {
        let fruit1 = FruitModel(name: "Banana", count: 1)
        let fruit2 = FruitModel(name: "Peach", count: 6)
        let fruit3 = FruitModel(name: "Orange", count: 10)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isLoading = false
            self.fruitArray.append(fruit1)
            self.fruitArray.append(fruit2)
            self.fruitArray.append(fruit3)
        }
    }
    
    func deleteFruit(at offsets: IndexSet) {
        fruitArray.remove(atOffsets: offsets)
    }
}

struct ViewModelBootcamp: View {
    /*
     @StateObject - с помошью его мы можем использовать данные из класса FruitViewModel в этой структуре(но класс должен быть наблюдаемым :ObservableObject и переменые в классе должны быть публичные @Published иначе мы не сможем получать из это го класса данные). Также нужно помнить и знать, для получения данных из класса, @StateObject мы используем в первой(главной) View струкитуре, а если хотим передавать данные из этого же класса в последующие  View струкитуры нужно использовать ObservableObject(наюлюжаемый обьект)
     */
    @StateObject var fruitViewModel: FruitViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                if fruitViewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(fruitViewModel.fruitArray) { fruit in
                        Text("\(fruit.name) - \(fruit.count)")
                    }
                    .onDelete(perform:fruitViewModel.deleteFruit)
                }
            }
            
            /*
             ToolbarItemGroup можно заменить на ToolbarItem, если у тебя только один элемент — это проще.
             */
            .navigationTitle("Fruits list")
            .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                EditButton()
                            }
                            
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                NavigationLink(destination:  RandomScreen(fruitViewModel: fruitViewModel)) {
                                    Image(systemName: "arrow.right")
                                        
                                }
                            }
                        }
           
        }
    }
    
}
    struct RandomScreen: View {
        
        @Environment(\.dismiss) var dismiss
        /*@ObservedObject позволит получить и пользоваться данными из родительской структуры ViewModelBootcamp , а она в свою очередь получает данные из наблюдаемого класса class FruitViewModel: ObservableObject*/
        @ObservedObject  var fruitViewModel: FruitViewModel
        
        var body: some View {
            ZStack {
                Color.green.ignoresSafeArea()
                
                Button {
                    dismiss()
                } label: {
                    Text("Random Screen")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }

                
               
            }
        }
    }
    
   


#Preview {
    ViewModelBootcamp()
   //RandomScreen()
}
