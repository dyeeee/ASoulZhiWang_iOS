//
//  HandleDate.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/14.
//

import Foundation

func timeStampToString(timeStamp:Int, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
    let date:Date = Date.init(timeIntervalSince1970: TimeInterval(timeStamp))
    let formatter = DateFormatter.init()
    if dateFormat == nil {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }else{
        formatter.dateFormat = dateFormat
    }
    return formatter.string(from: date as Date)
}

func currentDateString() -> String {
    let now:Date =  Date()
    let dateFormatter = DateFormatter()
    //设置时间格式（这里的dateFormatter对象在上一段代码中创建）
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //调用string方法进行转换
    return dateFormatter.string(from: now)
}
