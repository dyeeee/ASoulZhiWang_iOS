//
//  DetailView.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/13.
//

import SwiftUI

struct DetailView: View {
    
    @State var reponse:CheckResponse
    @State var source = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header:Text("输入内容")){
                Text("\(source)")
                }
                
                
                Section(header:Text("查重结果")){
                Text("总文字复制占比：\(String(format: "%.2f",reponse.responseData.rate) )%")
                }
                
            Section(header:Text("相似文章")){
                ForEach(reponse.responseData.related) {
                    relatedItem in
                    
                    let singleDetail = relatedItem.array[1] as! detailModel
                    let singleRate = relatedItem.array[0] as! Float
                    let singleLink = relatedItem.array[2] as! String
                    
                    let content = singleDetail.content
                    
                    VStack(alignment:.leading){
                        
                        HStack{
                            Text("id: \(singleDetail.m_name)")
                            Spacer()
                            Image(systemName: "hand.thumbsup.fill")
                            Text("\(singleDetail.like_num)")
                        }.font(.subheadline)
                        .foregroundColor(Color(.systemGray))
                        
                        VStack(alignment:.leading){
                            Text("\(content)")
                                
                        }.padding([.top
                                   ,.bottom], 1)
                        
                        HStack {
                            Text("相似率: \(String(format: "%.2f",singleRate) )%")
                            Spacer()
                            Text("查看原文")
                        }.font(.subheadline)
                        .foregroundColor(Color(.systemGray2))
                    }
                    
                   
                    
                }.zIndex(3)
                
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("文本复制检测报告结果(枝网)")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    

    
    static var previews: some View {
        let jsonString = """
            {
                "code":0,
                "message":"",
                "data":{
                    "rate":0.1145141919780,
                    "start_time":1624237336,
                    "end_time":1624238336,
                    "related":
                    [
                                 [
                                    1.0,
                                    {
                                        "content": "内容1",
                                        "ctime": 1606452746,
                                        "like_num": 3,
                                        "m_name": "病名为向晚",
                                        "mid": 610280758,
                                        "oid": 462160368203664988,
                                        "rpid": 3751510417,
                                        "type_id": 17
                                    },
                                    "https://t.bilibili.com/462160368203664988/#reply3751510417"
                                ],
                                [
                                    1.0,
                                    {
                                        "content": "内容2",
                                        "ctime": 1606647729,
                                        "like_num": 0,
                                        "m_name": "骡旋突进黑島丶",
                                        "mid": 91515578,
                                        "oid": 463018665884683799,
                                        "rpid": 3760486052,
                                        "type_id": 17
                                    },
                                    "https://t.bilibili.com/463018665884683799/#reply3760486052"
                                ]
                            ]
                }
            }
            
            """
        
        let data = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        let decodedResult = try! decoder.decode(CheckResponse.self, from: data)
       
        
        
        return DetailView(reponse: decodedResult)
    }
}