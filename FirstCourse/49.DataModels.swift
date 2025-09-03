//
//  49.DataModels.swift
//  FirstCourse
//
//  Created by Алан Парастаев on 02.09.2025.
//

import SwiftUI
/*
 ForEach(users, id\.self) - id\.self создает для айдишник для для всех элемнтов users
 
 UUID().uuidString - создает рандомный и уникальный стринговый айди каждый раз при созданиии нового пользователя модели UserModels
 */

 //MARK: 1) ✅ Создаем модель для пользователей с их данными
struct UserModels: Identifiable {
    let id: String = UUID().uuidString
    let displayName: String
    let userName: String
    let followersCount: Int
    let isVerified: Bool
}

struct DataModelsBootcamp: View {
    //MARK:  2) ✅ Создаем @State var users массив данных [UserModels] и далее присваиваем пустой массив [], далее в пустой массаив [] добавляем инициализацию UserModels( пишем в пустом мааасиве UserModels и открываем скобки и инициальзатор автоматически вставит все вводные данные из модели )
    @State var users: [UserModels] = [
        UserModels(displayName: "Nick", userName: "nick123", followersCount: 100, isVerified: true),
        UserModels(displayName: "Emily", userName: "itsemily1995", followersCount: 55, isVerified: false),
        UserModels(displayName: "Samanta", userName: "ninjaSam", followersCount: 355, isVerified: true),
        UserModels(displayName: "Chris", userName: "chris1999", followersCount: 245, isVerified: false)
    ]
        
    
    //MARK: В цыкле ForEach мы не испольщуем id так как наша модель UserModels соотвецтвует классу моделей Identifiable(с айдишный вид модели)
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    HStack(spacing: 15.0) {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(user.displayName)
                                .font(.headline)
                            Text("@\(user.userName)")
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        if user.isVerified {
                          Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        }
                        
                        VStack {
                            Text("\(user.followersCount)")
                                .font(.headline)
                            Text("Followers")
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }
                    }
                    .padding(.vertical ,10)
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    DataModelsBootcamp()
}
