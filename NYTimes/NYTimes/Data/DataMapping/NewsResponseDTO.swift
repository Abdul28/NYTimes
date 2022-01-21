//
//  NewsResponseDTO.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import Foundation

struct NewsResponseDTO : ModelType{
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case result = "num_results"
        case news = "results"
    }
    let status : String
    let copyright: String
    let result: Int
    let news: [NewsDTO]
}

extension NewsResponseDTO{
    
    struct NewsDTO : ModelType{
        let uri: String?
        let url: String?
        let id: UInt64?
        let asset_id: UInt64?
        let source: String?
        let published_date: String?
        let updated: String?
        let section: String?
        let subsection: String?
        let nytdsection: String?
        let adx_keywords: String?
        let byline: String?
        let title: String?
        let abstract: String?
        let media: [MediaObj]

        
        private enum CodingKeys: String, CodingKey {
             case uri           = "uri"
             case url           = "url"
             case id            = "id"
             case asset_id      = "asset_id"
             case source        = "source"
             case published_date    = "published_date"
             case updated       = "updated"
             case section       = "section"
             case subsection    = "subsection"
             case nytdsection   = "nytdsection"
             case adx_keywords  = "adx_keywords"
             case byline        = "byline"
             case title         = "title"
             case abstract      = "abstract"
             case media         = "media"
        }
    }
}


extension NewsResponseDTO {
    func toDomain() -> NewsPage {
        return .init(status: status, copyright: copyright, num_results: result, news: news.map({$0.toDomain()}))
    }
}

extension NewsResponseDTO.NewsDTO {
    func toDomain() -> News {
        var meta_data = NewsImage.init(url: "", format: "", height: 0 , width: 0)
        if !media.isEmpty && !media[0].media_metadata.isEmpty{
            let subMedia = media[0].media_metadata.last!
            meta_data = NewsImage.init(url: subMedia.url, format: subMedia.format, height: subMedia.height , width: subMedia.width)
        }
        return .init( uri: uri, url: url, id: id, asset_id: asset_id, source: source, published_date: dateFormatter.date(from: published_date ?? ""), updated: dateFormatterTime.date(from: updated ?? ""), section: section, subsection: subsection, nytdsection: nytdsection, adx_keywords: adx_keywords , byline: byline, title: title , abstract: abstract ,  mediaUri : meta_data)
    }
}


// MARK: - Private
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()


// MARK: - Private
private let dateFormatterTime: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
