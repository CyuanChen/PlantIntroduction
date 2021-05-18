//
//  ViewController.swift
//  TapeiPlant
//
//  Created by Peter Chen on 2021/5/9.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: PlantViewModel?
    var spinner = UIActivityIndicatorView(style: .large)
    var observer: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()
        let barApperance = UINavigationBarAppearance()
        barApperance.backgroundColor = .systemGreen
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PlantCell", bundle: nil), forCellReuseIdentifier: "PlantCell")
        self.tableView.estimatedRowHeight = 600
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.allowsSelection = false
        self.navigationController?.navigationBar.standardAppearance = barApperance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barApperance
        
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = true
        self.observer = self.navigationController?.navigationBar.observe(\.bounds, options: [.new], changeHandler: { (navigationBar, changes) in
            if let height = changes.newValue?.height {
                if height > 44.0 {
                    self.title = "Plant Introduction"
                    let segmentedControl = UISegmentedControl(items: ["植物", "動物"])
                    self.navigationItem.titleView = segmentedControl
                    
                } else {
                    self.navigationItem.titleView = nil
                    self.navigationItem.title = "Plant Introduction"
                }
            }
        })
        
        self.spinner.center = self.view.center
        self.binding()
    }
    
    func binding() {
        self.viewModel = PlantViewModel()
        self.getData()
    }
    
    func getData() {
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        self.viewModel?.getData(completion: { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    self?.spinner.removeFromSuperview()
                    self?.tableView.reloadData()
                }
                
            }
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.plants?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell") as? PlantCell else { return UITableViewCell() }
        cell.updateCell(self.viewModel?.plants?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalCount = self.viewModel?.plants?.count else { return }
        if indexPath.row == totalCount - 1 {
            self.getData()
        }
    }
}

