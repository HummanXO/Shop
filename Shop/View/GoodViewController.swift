import UIKit

class GoodViewController: UIViewController {
    
    var selectedGood : Goods!
    
    var sizeArray = [35,36,37,38,39,40,41,42,43,44,45]

    private var segmentedArray: [String] = []
    
    private let imageGood : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let titleGood : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let separator : UIView = {
        let separator = UIView()
        separator.backgroundColor = .gray
        return separator
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "Стоимость:"
        return label
    }()
    
    private let finalPriceLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    private let sizeLabel : UILabel = {
        let label = UILabel()
        label.text = "Размер:"
        return label
    }()
    
    private let sizeTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.placeholder = "Выбрать"
        return tf
    }()
    
    private let sizePicker : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let amountLabel : UILabel = {
        let label = UILabel()
        label.text = "Количество:"
        return label
    }()
    
    private let amountTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.keyboardType = .numberPad
        tf.placeholder = "Выбрать"
        return tf
    }()
    
    private let colorLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберете цвет:"
        return label
    }()
    
    private lazy var colorSegment : UISegmentedControl = {
        let segment = UISegmentedControl()
        return segment
    }()
    
    private let predoplataLabel : UILabel = {
        let label = UILabel()
        label.text = "Предоплата:"
        return label
    }()
    
    private let predoplataSwitch : UISwitch = {
        let swt = UISwitch()
        return swt
    }()
    
    private let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Добавить в корзину", for: .normal)
        button.layer.cornerRadius = 15
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupPicker()
        setupActions()
        configureWithGood()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTappted))
    }
    
    @objc private func shareTappted() {
        guard let image = imageGood.image else { return }
        
        let shareText = """
        Посмотрите на этот товар!
        Название: \(selectedGood.titleGood)
        Описание: \(selectedGood.discriptionGood)
        Цена: \(selectedGood.priceGood) ₽
        """
        
        let activityVC = UIActivityViewController(
            activityItems: [shareText, image],
            applicationActivities: nil
        )
        
        if let popover = activityVC.popoverPresentationController {
            popover.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        
        present(activityVC, animated: true)
    }
    
    private func setupLayout() {
        [imageGood, titleGood, separator, priceLabel, finalPriceLabel, sizeLabel, sizeTextField, amountLabel, amountTextField, colorLabel, colorSegment, predoplataLabel, predoplataSwitch, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageGood.topAnchor.constraint(equalTo: view.topAnchor),
            imageGood.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageGood.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageGood.heightAnchor.constraint(equalTo: imageGood.widthAnchor),
            
            titleGood.topAnchor.constraint(equalTo: imageGood.bottomAnchor, constant: 30),
            titleGood.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separator.topAnchor.constraint(equalTo: titleGood.bottomAnchor, constant: 10),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            priceLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            
            finalPriceLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            finalPriceLabel.trailingAnchor.constraint(equalTo: separator.trailingAnchor),
            
            sizeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            sizeLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            
            sizeTextField.topAnchor.constraint(equalTo: sizeLabel.topAnchor),
            sizeTextField.trailingAnchor.constraint(equalTo: finalPriceLabel.trailingAnchor),
            
            amountLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: sizeLabel.leadingAnchor),
            
            amountTextField.topAnchor.constraint(equalTo: amountLabel.topAnchor),
            amountTextField.trailingAnchor.constraint(equalTo: sizeTextField.trailingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
            colorLabel.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
            
            colorSegment.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 10),
            colorSegment.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: 20),
            colorSegment.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            colorSegment.heightAnchor.constraint(equalToConstant: 20),
            
            predoplataLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10),
            predoplataLabel.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor),
            
            predoplataSwitch.centerYAnchor.constraint(equalTo: predoplataLabel.centerYAnchor),
            predoplataSwitch.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            
            button.topAnchor.constraint(equalTo: predoplataLabel.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: predoplataLabel.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: predoplataSwitch.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureWithGood() {
        guard selectedGood != nil else {
            fatalError("Good must be set before presenting this VC")
        }
        segmentedArray = [selectedGood.imageName, selectedGood.imageName + "2", selectedGood.imageName + "3"]
        imageGood.image = UIImage(named: selectedGood.imageName)
        titleGood.text = selectedGood.titleGood
        finalPriceLabel.text = selectedGood.priceGood
        colorSegment.removeAllSegments()
        for i in 0..<segmentedArray.count {
            colorSegment.insertSegment(withTitle: "\(i + 1)", at: i, animated: false)
        }
        
        if segmentedArray.count > 0 {
            colorSegment.selectedSegmentIndex = 0
            updateImage()
        }
        amountTextField.text = "1"
        updatePrice()
    }
    
    private func setupActions() {
        amountTextField.addTarget(self, action: #selector(updatePrice), for: .editingChanged)
        colorSegment.addTarget(self, action: #selector(updateImage), for: .valueChanged)
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc private func updateImage() {
        guard selectedGood != nil else { return }
        let selectedImageName = segmentedArray[colorSegment.selectedSegmentIndex]
        imageGood.image = UIImage(named: selectedImageName)
    }
    
    @objc private func addToCart() {
        guard let size = sizeTextField.text, !size.isEmpty,
              let quantity = amountTextField.text, !quantity.isEmpty else {
            showAlert(message: "Заполните все поля")
            return
        }
        
        let selectedColor = segmentedArray[colorSegment.selectedSegmentIndex]
        print("Добавлено: \(size), \(quantity), \(selectedColor)")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func updatePrice() {
        guard let selectedGood = selectedGood,
              let quantityText = amountTextField.text,
              let quantity = Int(quantityText) else {
            finalPriceLabel.text = "0.00 ₽"
            return
        }
        
        let totalPrice = Double(selectedGood.priceGood)! * Double(quantity)
        finalPriceLabel.text = String(format: "%.2f ₽", totalPrice)
    }
    
    private func setupPicker() {
        sizePicker.dataSource = self
        sizePicker.delegate = self
        sizeTextField.inputView = sizePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dissmisPicker))
        toolbar.setItems([doneButton], animated: true)
        sizeTextField.inputAccessoryView = toolbar
    }
    
    @objc private func dissmisPicker() {
        view.endEditing(true)
    }
}

extension GoodViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeArray.count
    }
}

extension GoodViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(sizeArray[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sizeTextField.text = String(sizeArray[row])
    }
}
