//
//  MainView.swift
//  hiperMOVIE
//
//  Created by Miguel Alejandro Correa Avila on 12/7/23.
//

import UIKit

class MainView: UIViewController {
    
    var model = HomeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.fetchLists{ [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
        
        title = "hiperMOVIE"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logout))
                
//       tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
//        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }
    
    @objc func logout(){
        print("loging out")
        model.logout()
        if let vc = storyboard?.instantiateViewController(identifier: "Login") as? Login{
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}


extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as? ResultsTableViewCell else {return UITableViewCell()}
        cell.configure(row: model.rows[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return model.rows[section].title
//    }
}


