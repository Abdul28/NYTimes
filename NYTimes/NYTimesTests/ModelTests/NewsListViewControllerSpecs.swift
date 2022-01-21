//
//  NewsListViewControllerSpecs.swift
//  NYTimesTests
//
//  Created by Abdul on 1/21/22.
//
import Foundation
import Quick
import Nimble
@testable import NYTimes

class ViewControllerSpecs: QuickSpec {
        override func spec() {
            var sut: NewsListViewController!
            describe("The 'View Controller'") {
                context("Can show the correct labels text") {
                    afterEach {
                        sut = nil
                    }
                    beforeEach {
                        // 1
                        let storyboard = UIStoryboard(name: "NewsListViewController", bundle: Bundle.main)
                        sut = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                        _ = sut.view
                        if let path = Bundle(for: type(of: self)
                            ).path(forResource: "news_parse_correct", ofType: "json") {
                            do {
                                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                sut.searchResult = try decoder.decode(NewsResponseDTO.self, from: data)
                            } catch {
                                fail("Problem parsing JSON")
                            }
                        }
                    }
                    it("can show the correct text within the coord label") {
                        // 2
                        expect(sut.title).to(equal("How to Find a Quality Mask (and Avoid Counterfeits)"))
                    }
                    
                }
            }
        }
    }
