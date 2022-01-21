//
//  NewsDetailsViewController.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import UIKit

class NewsDetailsViewController: BaseViewController, StoryboardInstantiable, Alertable  {

    @IBOutlet var imgNews: UIImageView!
    @IBOutlet var tvDetail: UITextView!
    @IBOutlet var lblAuther: UILabel!
    
    private var viewModel: NewsDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()

    }
    
    private func setupView() {
        assert(viewModel != nil )
        
        let input = NewsDetailsViewModel.Input()
        
        let output = viewModel.transform(input: input)
        setupBackButton()
        self.imgNews.setImage(with: output.posterImage)
        self.lblAuther.text = output.author
        self.tvDetail.text = "\(output.title)  \n\n \(output.abstract)"
        
//        posterImageView.setImage(with: PictureUrl.getPicUrl()+output.posterImgae)
//        overviewTextView.text = output.overview
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func create(with viewModel: NewsDetailsViewModel) -> NewsDetailsViewController {
        
        let view = NewsDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

}
