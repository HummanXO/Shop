import UIKit

class FirstViewController: UIViewController {
    let goods = [Goods(imageName: "tshirt-adidas", titleGood: "T-Shirt Adidas", discriptionGood: "New Arival T-Shirt", priceGood: "1100"),
        Goods(imageName: "tshirt-nike", titleGood: "T-Shirt Nike", discriptionGood: "New Arival T-Shirt", priceGood: "1100"),
        Goods(imageName: "tshirt-puma", titleGood: "T-Shirt Puma", discriptionGood: "New Arival T-Shirt", priceGood: "1100"),
        Goods(imageName: "adidas-shoes", titleGood: "Shoes Adidas", discriptionGood: "New Arival Shoes", priceGood: "4599"),
        Goods(imageName: "nike-shoes", titleGood: "Shoes Nike", discriptionGood: "New Arival Shoes", priceGood: "4599"),
        Goods(imageName: "puma-shoes", titleGood: "Shoes Puma", discriptionGood: "New Arival Shoes", priceGood: "4599")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var previousButton : UIButton?
        title = "Goods"
        view.backgroundColor = .white
        for (index, good) in goods.enumerated() {
            let topAnchor = previousButton?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor
            let button = createCustomButton(goods: good, topAnchor: topAnchor, tag: index)
            previousButton = button
        }
        setupActions()
    }
    
    private func createCustomButton(
        goods: Goods,
        topAnchor: NSLayoutYAxisAnchor,
        tag: Int
    ) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.tag = tag
        
        let imageView = UIImageView(image: UIImage(named: goods.imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        
        let titleLabel = UILabel()
        titleLabel.text = goods.titleGood
        titleLabel.textColor = .black
        titleLabel.isUserInteractionEnabled = false
        
        let discriptionLabel = UILabel()
        discriptionLabel.text = goods.discriptionGood
        discriptionLabel.textColor = .gray
        discriptionLabel.font = .systemFont(ofSize: 13)
        discriptionLabel.isUserInteractionEnabled = false
        
        let priceLabel = UILabel()
        priceLabel.text = goods.priceGood
        priceLabel.textColor = .black
        priceLabel.isUserInteractionEnabled = false
        
        let separator = UIView()
        separator.backgroundColor = .gray
        priceLabel.isUserInteractionEnabled = false
        
        [imageView, titleLabel, discriptionLabel, priceLabel, separator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 25),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            discriptionLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            discriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -25),
            
            separator.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            separator.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        return button
    }
    
    private func setupActions() {
        let buttons = view.subviews.compactMap { $0 as? UIButton }
        
        buttons.forEach {
            $0.addTarget(self, action: #selector(goodSelected), for: .touchUpInside)
        }
    }
    
    @objc private func goodSelected(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        })
        let index = sender.tag
        let selectedGood = goods[index]
        let goodVC = GoodViewController()
        goodVC.selectedGood = selectedGood
        present(UINavigationController(rootViewController: goodVC), animated: true)
    }
}
