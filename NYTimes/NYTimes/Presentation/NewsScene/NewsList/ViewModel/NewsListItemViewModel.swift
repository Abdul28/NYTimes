//
//  NewsListItemViewModel.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

struct NewsListItemViewModel : Equatable {
    let title: String
    let author: String
    let image: String
    let published_date: String?
    let news: News
}

extension NewsListItemViewModel {

    init(with news: News) {
        self.news = news
        self.title = news.title ?? ""
        self.author = news.byline ?? ""
        self.image = news.mediaUri.url

        if let published_date = news.published_date {
            self.published_date = dateFormatter.string(from: published_date)
        } else {
            self.published_date = NSLocalizedString("not-available", comment: "")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
