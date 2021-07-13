//
//  HomeView.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/13.
//

import SwiftUI

struct HomeView: View {
    
    
    
    func run_API(){

        // prepare json data
        let inputText: [String: Any] = ["text": "\(inputText)"]

        let sendData = try? JSONSerialization.data(withJSONObject: inputText)

        // create post request
        let url = URL(string: "https://asoulcnki.asia/v1/api/check")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = sendData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if let data = data {
              do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(CheckResponse.self, from: data)
                self.responseForView = decodedResponse
                self.showSheet = true
//                DispatchQueue.main.async {
//                    self.response = decodedResponse
//                    self.testTag = true
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5){
//
//                        self.showSheet = true
//
//                    }
//                 }
              } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
              }
              return
            }
        }

        task.resume()
    }
    
    @State var inputText:String = "输入查重的小作文，不少于10个字o"
    @State var alert:Bool = false
    @State var showSheet = false
    @State var responseForView:CheckResponse
    
    
    var body: some View {
        NavigationView {
            ScrollView{
            VStack() {
                
                VStack {
                    
                   TextEditor(text: $inputText)
                     .frame(height:150, alignment: .center)
                     .lineSpacing(5)
                     .disableAutocorrection(true)
                     .padding(5)
                     .font(.custom("Helvetica Neue", size: 13))
                     .overlay(
                             RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(.systemPink), lineWidth: 2)
                             )
                    .onTapGesture {
                        if(inputText == "输入查重的小作文，不少于10个字o"){
                            inputText = ""
                        }
                    }
                    
                }
                .padding()
                
                HStack {
                    Button(action: {
                        
                        if (inputText.count < 10 ) {
                            self.alert = true
                        }
                        run_API()
                       
                        //self.showSheet = true
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 150, height: 30, alignment: .center)
                            Text("立即查重捏🤤")
                                .foregroundColor(Color(.white))
                        }.frame(width: 150, height: 30, alignment: .center)
                    })
                    
                    Button(action: {
                        inputText = "输入查重的小作文，不少于10个字o"
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 80, height: 30)
                            HStack {
                                Text("清空")
                                Image(systemName: "pencil.and.outline")
                                   
                            } .foregroundColor(Color(.white))
                        }.frame(width: 80, height: 30)
                        
                    })
                    
                }.padding(.bottom, 10)
            
                
                Divider()
                

                
                VStack(alignment: .leading){
                    Text("查重API: https://github.com/stream2000/ASoulCnki")
                    Text("Andorid端: https://github.com/jiangdashao/ASoulZhiWang")
                }.font(.caption)
                
                Divider()
                Text("A-SOUL简介 🥵")
                VStack(){
                    
                    Text("""
A-SOUL是乐华娱乐于2020年11月23日公开的其旗下首个虚拟偶像团体，由5名成员组成。\n
* A-SOUL主页链接：https://space.bilibili.com/703007996\n
* 珈乐：https://space.bilibili.com/351609538\n
* 乃琳：https://space.bilibili.com/672342685\n
* 贝拉：https://space.bilibili.com/672353429\n
* 向晚：https://space.bilibili.com/672346917\n
* 嘉然：https://space.bilibili.com/672328094\n
在未来学院中，五位性格迥异的少女，为了成为偶像这一共同目标走到一起，并且为之努力奋斗。
""")
                }.font(.caption)
                .padding(.all, 20)
                
                
            }
            }
            
            .sheet(isPresented: $showSheet, content: {
                DetailView(reponse: responseForView, source: inputText)
            })
            .alert(isPresented: $alert) {
                Alert(title: Text("字数太少惹"), dismissButton: .default(Text("知道了捏")))
            }
            .navigationTitle("ASoul小作文助手")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(responseForView: decodedResult)
    }
}
