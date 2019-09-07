//
//  NewsAppViewController.swift
//  NewsAPP
//
//  Created by Srinivasan on 08/09/19.
//  Copyright © 2019 Srinivasan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class NewsAppTableViewController:UITableViewController{
    
    private var newsList = [NewsItem]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News App"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.populateNews()
    }
    
    private func populateNews(){
       
        URLRequest.loadResource(resource: NewsList.all)
            .asObservable().subscribe(onNext: { [weak self] newsList in
                if let list = newsList{
                    self?.newsList = list.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
}

extension NewsAppTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCell else{
            fatalError()
        }
        cell.newsTitle.text = self.newsList[indexPath.row].title
        cell.newsDescription.text = self.newsList[indexPath.row].description
        return cell
    }
}
