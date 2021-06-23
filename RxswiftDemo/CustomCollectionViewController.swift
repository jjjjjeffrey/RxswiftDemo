//
//  CustomCollectionViewController.swift
//  RxswiftDemo
//
//  Created by Jeffrey on 2021/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class CustomCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { m in
            m.edges.equalToSuperview()
        }

        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.register(CustomCollectionViewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomCollectionViewHeaderView")

        sections.bind(to: collectionView.rx.items(dataSource: datasource)).disposed(by: bag)
        
        collectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    let bag = DisposeBag()
    
    var datasource = RxCollectionViewSectionedReloadDataSource<
        SectionModel<CollectionViewHeaderModel, CollectionViewCellModel>
    > { datasource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.titleLabel.text = item.title
        cell.subTitleLabel.text = item.subTitle
        return cell
    } configureSupplementaryView: { datasource, collectionView, kind, indexPath in
        let section = datasource[indexPath.section]
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomCollectionViewHeaderView", for: indexPath) as! CustomCollectionViewHeaderView
        header.titleLabel.text = section.model.title
        header.subTitleLabel.text = section.model.subTitle
        return header
    }

    let sections: Observable<[SectionModel<CollectionViewHeaderModel, CollectionViewCellModel>]>
        = Observable.just([
            .init(model: CollectionViewHeaderModel(title: "Header", subTitle: "1"), items: [
                .init(title: "Cell", subTitle: "1"),
                .init(title: "Cell", subTitle: "2"),
                .init(title: "Cell", subTitle: "3")
            ]),
            .init(model: CollectionViewHeaderModel(title: "Header", subTitle: "2"), items: [
                .init(title: "Cell", subTitle: "1"),
                .init(title: "Cell", subTitle: "2"),
                .init(title: "Cell", subTitle: "3")
            ]),
            .init(model: CollectionViewHeaderModel(title: "Header", subTitle: "3"), items: [
                .init(title: "Cell", subTitle: "1"),
                .init(title: "Cell", subTitle: "2"),
                .init(title: "Cell", subTitle: "3")
            ]),
    ])
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CustomCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 136.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
}

struct CollectionViewCellModel {
    var title: String
    var subTitle: String
}

struct CollectionViewHeaderModel {
    var title: String
    var subTitle: String
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { m in
            m.left.equalTo(25.0)
            m.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { m in
            m.right.equalTo(-25.0)
            m.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}

class CustomCollectionViewHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { m in
            m.left.equalTo(25.0)
            m.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { m in
            m.right.equalTo(-25.0)
            m.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
