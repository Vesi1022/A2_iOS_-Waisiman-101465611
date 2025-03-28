
import UIKit
import CoreData

class ProductManager {
    static let shared = ProductManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchAllProducts() -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func addProduct(id: Int32, name: String, description: String, price: Double, provider: String) {
        let product = Product(context: context)
        product.productID = id
        product.productName = name
        product.productDescription = description
        product.productPrice = price
        product.productProvider = provider
        try? context.save()
    }

    func searchProduct(keyword: String) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "productName CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@", keyword, keyword)
        return (try? context.fetch(request)) ?? []
    }
}
