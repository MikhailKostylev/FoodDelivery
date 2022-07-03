//
//  OnboardingViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private var onboardingView: OnboardingView!
    
    private var slides = [OnboardingSlideModel]()
    var currentPage = 0 {
        didSet {
            onboardingView.pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                onboardingView.nextButton.setTitle("Get Started", for: .normal)
                onboardingView.skipButton.isHidden = true
            } else {
                onboardingView.nextButton.setTitle("Next", for: .normal)
                onboardingView.skipButton.isHidden = false
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupOnboardingView()
        setupSlidesContent()
        setupPageControl()
        addActions()
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = .white
    }
    
    private func setupOnboardingView() {
        onboardingView = OnboardingView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height
            )
        )
        
        view.addSubview(onboardingView)
        onboardingView.collectionView.dataSource = self
        onboardingView.collectionView.delegate = self
    }
    
    private func setupSlidesContent() {
        slides = [
            OnboardingSlideModel(title: "A huge assortment of food to choose from in your device", subtitle: "Order as many as you like.", image: "onboarding1"),
            OnboardingSlideModel(title: "Make an order in a few seconds", subtitle: "A couple of taps and you're already happy.", image: "onboarding2"),
            OnboardingSlideModel(title: "Five star delivery", subtitle: "Traffic jams are not a problem for us.", image: "onboarding3"),
            OnboardingSlideModel(title: "Stock up on groceries for the weeks ahead", subtitle: "No more going to the store and waiting in line.", image: "onboarding4"),
            OnboardingSlideModel(title: "All your favorites", subtitle: "Order from the best local restaurants with easy, on-demand delivery.", image: "onboarding5"),
            OnboardingSlideModel(title: "The best from the delivery world", subtitle: "Innovative technology for your convenience.", image: "onboarding6")
        ]
    }
    
    private func setupPageControl() {
        onboardingView.pageControl.numberOfPages = slides.count
    }
    
    // MARK: - Actions
    
    private func addActions() {
        onboardingView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        onboardingView.skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
    }
    
    private func goToMainVC() {
        UserDefaults.standard.hasOnboarded = true
        let vc = MainViewController()
        let mainVC = UINavigationController(rootViewController: vc)
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
    @objc private func didTapNextButton() {
        if currentPage == slides.count - 1 {
            goToMainVC()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc private func didTapSkipButton() {
        goToMainVC()
    }
}

// MARK: - CollectionView methods

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingSlideCollectionViewCell.identifier, for: indexPath) as! OnboardingSlideCollectionViewCell
        cell.configure(with: slides[indexPath.row])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.width)
    }
}
