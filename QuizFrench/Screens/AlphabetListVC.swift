//
//  AlphabetListVC.swift
//  QuizFrench
//
//  Created by Marcos Barbosa on 20/09/24.
//

import UIKit

enum Section {
    case main
}

class AlphabetListVC: UIViewController {
    
    enum Section { case main }
    
    let frenchAlphabet = ["Aa", "Bb", "Cc", "Dd", "Ee", "Ff", "Gg", "Hh", "Ii", "Jj", "Kk", "Ll", "Mm", "Nn", "Oo", "Pp", "Qq", "Rr", "Ss", "Tt", "Uu", "Vv", "Ww", "Xx", "Yy", "Zz"]
    var alphabets = [Alphabet]()

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Alphabet>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAlphabet()
        configureCollectionView()
        configureDataSource()
        updateData()
        print(alphabets)
        
        
    }
    
    private func configureAlphabet() {
        for letter in frenchAlphabet {
            let alphabet = Alphabet(letter: letter, audio: "alphabet_\(letter)_male.mp3") // alphabet_Aa.mp3, alphabet_Bb.mp3
            alphabets.append(alphabet)
        }
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(AlphabetCell.self, forCellWithReuseIdentifier: AlphabetCell.reuseID)
    }
    
    func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, alphabet in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlphabetCell.reuseID, for: indexPath) as! AlphabetCell
            cell.set(alphabetLetter: alphabet.letter)
            
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Alphabet>()
        snapshot.appendSections([.main])
        snapshot.appendItems(alphabets)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
