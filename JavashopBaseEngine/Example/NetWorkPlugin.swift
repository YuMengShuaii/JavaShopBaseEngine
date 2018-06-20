//
//  NetWorkPlugin.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/5.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import HandyJSON
enum ApiManager {
    case isLogin()
    
    case Login(name:String,pass:String)
}

extension ApiManager: TargetType {
    public var baseURL: URL { return URL(string: "http://116.196.110.30:8080/")! }
    public var path: String {
        switch self {
        case .isLogin:
            return "islogin"
        case .Login:
            return "login"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
            case .Login(let name, let pass):
            return ["username": name, "password": pass]
            default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        switch self {
        case .Login:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        default:
            return .requestPlain
        }
    }
    public var validate: Bool {
            return false
    }
    public var sampleData: Data {
        return "示例数据".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String: String]? {
        return nil
    }
}

enum  GankApi{
    case IOS()
    case Girl(String)
    case Android()
}

extension GankApi:TargetType{

    var baseURL: URL{
        return URL(string: "http://gank.io/api/data/")!
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var method: Moya.Method{
        return .get
    }
    
    var path: String{
        switch self {
        case .IOS():
            return "iOS/10/1"
        case .Android():
            return "Android/10/1"
        case .Girl(let num):
            return "福利/10/\(num)"
        }
    }
    
    var sampleData: Data{
        return "示例数据".data(using: String.Encoding.utf8)!
    }
    
    var task: Task{
        
        return .requestPlain
    }
    
    var validate: Bool{
        return false
    }
}

enum RegionApi{
    case get(parentId :Int)
}

extension RegionApi :TargetType{
    var baseURL: URL{
        return URL(string: "http://v65.javamall.com.cn/api/")!
    }
    
    var headers: [String : String]?{
        return nil
    }
    
    var method: Moya.Method{
        return .get
    }
    
    var path: String{
        switch self {
        case .get(let parentId):
            return "mobile/address/region-list/\(parentId).do"
        }
    }
    
    public var parameters: [String: Any]? {
        return nil
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data{
        return "示例数据".data(using: String.Encoding.utf8)!
    }
    
    var task: Task{
        switch self {
        case .get:
            return .requestPlain
        }
    }
    
    var validate: Bool{
        return false
    }
}

