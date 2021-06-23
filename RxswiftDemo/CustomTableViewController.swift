//
//  CustomTableViewController.swift
//  RxswiftDemo
//
//  Created by Jeffrey on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class CustomTableViewController: UIViewController {
    
    let bag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")

        let items = Observable.just([
                    SectionModel(model: "First section", items: [
                            "1RxCollectionViewSectioned0",
                            "RxCollectionViewSectionedReloadDataSource<SectionModel> expects that you will bind items of SectionModel type, because you passed",
                            "RxCollectionViewSectionedReloadDataSource<SectionModel> expects that you will bind items of SectionModel type, because you passed SectionModel as a generic parameter. Apparently, you would like to use StudentModel. To achieve this, you might make your StudentModel conform to SectionModelType protocol"
                        ])
                    ])
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
//        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
      configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = item
        return cell
    })

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension CustomTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}

class CustomTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        label.snp.makeConstraints { m in
            m.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
}

struct CustomData {
    var title: String
}

struct SectionOfCustomData {
  var header: String
  var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
  typealias Item = CustomData

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
