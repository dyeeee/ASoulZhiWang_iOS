//
//  DataModel.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/13.
//

import Foundation

struct CheckResponse: Decodable {
    enum CodingKeys:String, CodingKey {
        case code
        case message
        case responseData = "data"
    }
    
    
    var code:Int
    var message:String
    var responseData:ResponseData
}

struct ResponseData: Decodable {
    var rate:Float
    var start_time:Int
    var end_time:Int
    var related: [relatedModel]
}

struct relatedModel: Decodable,Identifiable {
    var id = UUID()
    
    let array: [Any]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let rate = try container.decode(Float.self)
        let detail = try container.decode(detailModel.self)
        let link = try container.decode(String.self)
        array = [rate, detail, link]
    }
}

struct detailModel: Decodable{
    var content:String
    var ctime:Int
    var like_num:Int
    var m_name:String
    var mid:Int
    var oid: Int
    var rpid:Int
    var type_id:Int
}


/// - Test Data
let jsonString = """
    {
        "code":0,
        "message":"",
        "data":{
            "rate":0.0,
            "start_time":1624237336,
            "end_time":1624238336,
            "related":
            [
                         [
                            1.0,
                            {
                                "content": "如果看到测试内容，说明这是APP启动后首次查询的bug，请重新点击立即查询",
                                "ctime": 1606452746,
                                "like_num": 3,
                                "m_name": "测试用户1",
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
                                "content": "如果看到测试内容，说明这是APP启动后首次查询的bug，请重新点击立即查询",
                                "ctime": 1606647729,
                                "like_num": 0,
                                "m_name": "测试用户2",
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
