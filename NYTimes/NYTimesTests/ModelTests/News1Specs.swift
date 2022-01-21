//
//  News1Specs.swift
//  NYTimesTests
//
//  Created by Abdul on 1/21/22.
//

import Foundation
import Quick
import Nimble
@testable import NYTimes

class News1Specs: QuickSpec {

    override func spec() {
      var sut: NewsResponseDTO!
      //1
      describe("Most Viewed News'") {
        //2
        context("Can be created with valid JSON") {
          //3
          afterEach {
            sut = nil
          }
          //4
          beforeEach {
            //5
            if let path = Bundle(for: type(of: self)
            ).path(forResource:"news_parse_correct",
                              ofType: "json") {
                  do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                        options: .alwaysMapped)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    sut = try decoder.decode(NewsResponseDTO.self, from: data)
                  } catch {
                    fail("Problem parsing JSON")
                  }
                }
            }
            //6
            it("can parse the correct lat") {
              //7
                expect(sut.status).to(equal("OK"))
            }
            it("can parse the correct date time") {
                expect(sut.result).to(equal(20))
            }
          }
        }
    }
}

