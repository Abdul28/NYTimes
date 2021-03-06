//
//  Networking.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import Foundation
import MoyaSugar
import RxSwift

typealias NewsNetworking = Networking<NewsAPI>

final class Networking<Target: SugarTargetType>: MoyaSugarProvider<Target> {
    
    init(plugins: [PluginType] = [/*NetworkLoggerPlugin()*/]) {
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        super.init(session: session, plugins: plugins)
  }

  func request(
    _ target: Target,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line) -> Single<Response> {
    let requestString = "\(target.method.rawValue) \(target.path)"
      
    return self.rx.request(target)
      .catchAPIError(APIErrorResponse.self)
      .filterSuccessfulStatusCodes()
      .do(
        onSuccess: { value in
          let message = "SUCCESS: \(requestString) (\(value.statusCode))"
//          log.debug(message, file: file, function: function, line: line)
        },
        onError: { error in
          if let response = (error as? MoyaError)?.response {
            if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
              log.warning(message, file: file, function: function, line: line)
            } else if let rawString = String(data: response.data, encoding: .utf8) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
              log.warning(message, file: file, function: function, line: line)
            } else {
              let message = "FAILURE: \(requestString) (\(response.statusCode))"
              log.warning(message, file: file, function: function, line: line)
            }
          } else {
            let message = "FAILURE: \(requestString)\n\(error)"
            log.warning(message, file: file, function: function, line: line)
          }
        },
        onSubscribed: {
          let message = "REQUEST: \(requestString)"
//          log.debug(message, file: file, function: function, line: line)
        }
      )
  }
}
