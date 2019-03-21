//
//  PulseLiveTests.swift
//  PulseLiveTests
//
//  Created by Metricell Developer on 08/03/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import XCTest
@testable import PulseLive

class PulseLiveTests: XCTestCase {

    func testObtainingAndParsingArticlesWithNoBody(){
        // This method will pull and parse the JSON response in order to populate the Articles Model - without an ArticleBody - obtained from the first end-point
        var articles = [Articles]()
        let noBodyForArticlesExpectation = expectation(description: "Will attempt to obtain articles from first end point - no body")
        // Pass an empty [Articles] object to the async task, which will pull and parse articles with no body
        DataDownloader.getContentList(articlesList: articles, getBody: false) { (result) in
            // Assign the articles object the result from the completionhandler
            articles = result
            // Check that an item at index 3 of the [Articles] has an empty body value
            if (articles[3].body == nil){
                // Success
                XCTAssertTrue(true)
                noBodyForArticlesExpectation.fulfill()
            } else {
                // Fail
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Timeout occured waiting for article pull with no body - \(error)")
            }
        }
    }
    
    func testObtainingAndParsingArticlesWithBody(){
        // This method will pull and parse the first end-point into an [Articles] (without the body), and pass it into an async task where this list of articles will now be populated with bodies
        // From their own respective secondary end-point
        var articles = [Articles]()
        let containsBodyForArticlesExpectation = expectation(description: "Will attempt to obtain articles from second end point - with body")
        // Pass an empty [Articles] object to the async task, which will pull and parse articles with no body
        DataDownloader.getContentList(articlesList: articles, getBody: false) { result in
            // Assign the articles object the result, from the completionhandler
            articles = result
            // Now pass the prepopulated articles to the async task in order to cycle through their Article ID (used as a parameter for the secondary end point) to obtain each respective article's body
            DataDownloader.getContentList(articlesList: articles, getBody: true, completionHandler: { result in
                // Re-assign the articles object with the result, from the completion handler, which should now have articles with bodies
                articles = result
                // Check that an item at index 3 of the [Articles] no longer has an empty body
                if (articles[3].body != nil){
                    // Success
                    XCTAssertTrue(true)
                    containsBodyForArticlesExpectation.fulfill()
                } else {
                    // Fail
                    XCTAssertTrue(false)
                }
            })
        }
        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                XCTFail("Timeout occured waiting for article pull with body - \(error)")
            }
        })
    }

    func testGetMethodPullsXAmountOfArticles(){
        // There is a total of 8 articles from the first end point
        // The async task should assign the [Articles] object with a total count of 8
        let x = 8
        var articles = [Articles]()
        let noBodyForArticlesExpectation = expectation(description: "Will attempt to pull a total of \(x) articles")
        // Pass an empty [Articles] object to the async task, which will pull and parse articles with no body
        DataDownloader.getContentList(articlesList: articles, getBody: false) { (result) in
            // Assign the articles object the result from the completionhandler
            articles = result
            // Check if the count of the assigned [Articles] object is that of X (in this case we know the number of articles to be 8)
            if (articles.count == x){
                // Success
                XCTAssertTrue(true)
                noBodyForArticlesExpectation.fulfill()
            } else {
                // Fail
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Did not pull and assigned \(x) number of articles - \(error)")
            }
        }
    }
    
    func testArticleAscendingSortByID(){
        var articles = [Articles]()
        var confirmedCorrectIDSorts = Int()
        let noBodyForArticlesExpectation = expectation(description: "Will attempt to sort articles from first end point - in ascending order by their ID")
        // Pass an empty [Articles] object to the async task, which will pull and parse articles with no body
        DataDownloader.getContentList(articlesList: articles, getBody: false) { (result) in
            // Assign the articles the result object after the view model has executed an ascending sort
            articles = ArticlesViewModel.ascendingArticles(articles: result)
            // Check that each article in the [Articles] has a lower ID than its subsequential article
            for i in 1..<articles.count {
                if (articles[i-1].id < articles[i].id){
                    // Increase the count of confirmed checks that the previous article's ID is < than the next article's ID
                    confirmedCorrectIDSorts += 1
                }
            }
            // Confirm that there was a total of 7 confirmed checks that the article's IDs increased as did the index of the [Articles] object
            if (confirmedCorrectIDSorts == 7){
                // Success
                XCTAssertTrue(true)
                noBodyForArticlesExpectation.fulfill()
            } else {
                // Fail
                XCTAssertTrue(false)
            }
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Timeout occured waiting for article pull with no body - \(error)")
            }
        }

    }

}
