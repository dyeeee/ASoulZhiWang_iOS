//
//  CheckResultViewModel.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/14.
//

import Foundation
import SwiftUI

class CheckResultViewModel: ObservableObject {
    
    var responseForView:CheckResponse = decodedResult
    
    @Published var isLoading = false
    @Published var totalRate:Float = -1.0
    @Published var basicInfo = ""
    @Published var relatedList:[relatedModel] = []
    
    
    init() {
        
    }
    
    func run_API(inputText:String){
        self.isLoading = true
        
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
                DispatchQueue.main.async {
                    withAnimation {
                    self.responseForView = decodedResponse
                    self.totalRate = self.responseForView.responseData.rate
                    self.relatedList = self.responseForView.responseData.related
                    }
                 }
              } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
              }
              return
            }
        }
        
        task.resume()
        
        self.delay(interval: 1) {
          self.isLoading = false
        }
    }
    
    
    private func delay(interval: TimeInterval, block: @escaping () -> Void) {
      DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        block()
      }
    }
    
//    枝网文本复制检测报告(简洁)
//    查重时间:2021-07-14 11:46:34
//    总文字复制比:72.73%
//    相似小作文:
//     https://t.bilibili.com/526521058729123221/#reply4593222171
//    作者:VoxSolaris
//    发表时间:2021-05-20 15:14:29
//
//    查重结果仅作参考，请注意辨别是否为原创
    
}
