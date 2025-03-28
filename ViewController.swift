
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!

    var products: [Product] = []
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        products = ProductManager.shared.fetchAllProducts()
        if products.isEmpty {
            preloadData()
            products = ProductManager.shared.fetchAllProducts()
        }
        showProduct()
    }

    func showProduct() {
        guard products.indices.contains(currentIndex) else { return }
        let p = products[currentIndex]
        nameLabel.text = "Name: \(p.productName ?? "")"
        descLabel.text = "Description: \(p.productDescription ?? "")"
        priceLabel.text = "Price: $\(p.productPrice)"
        providerLabel.text = "Provider: \(p.productProvider ?? "")"
    }

    @IBAction func nextTapped(_ sender: Any) {
        if currentIndex < products.count - 1 {
            currentIndex += 1
            showProduct()
        }
    }

    @IBAction func prevTapped(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            showProduct()
        }
    }

    func preloadData() {
        for i in 1...10 {
            ProductManager.shared.addProduct(id: Int32(i), name: "Item \(i)", description: "Description for item \(i)", price: Double(i) * 5, provider: "Provider \(i)")
        }
    }
}
