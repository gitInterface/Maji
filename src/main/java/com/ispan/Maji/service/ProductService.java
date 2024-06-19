package com.ispan.Maji.service;

import java.util.Base64;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.ispan.Maji.domain.ProductBean;
import com.ispan.Maji.repository.ProductRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    // 查詢所有商品
    public List<ProductBean> getAllProducts() {
        return productRepository.findAll();
    }

    // 用product ID查詢商品
    public ProductBean getProductById(Integer id) {
        return productRepository.findById(id).orElse(null);
    }

    // 新增或修改商品
    public void saveProduct(ProductBean product) {
        productRepository.save(product);
    }
    
    // 刪除商品
    public void deleteProductById(int productId) {
        productRepository.deleteById(productId);
    }

    // 查詢商品
    public List<ProductBean> searchProducts(String query) {
        List<ProductBean> products;

        try {
            // 如果搜尋為數字的話
            int price = Integer.parseInt(query);
            products = productRepository.findByPrice(price);
            System.out.println("Filtered by price: " + products.size());
        } catch (NumberFormatException e) {
            // 進行字串模糊搜尋
            products = productRepository.findByProductNameContainingIgnoreCaseOrDiscriptionContainingIgnoreCaseOrTagContainingIgnoreCase(query, query, query);
            System.out.println("Query is not a number, skipping price filter");
        }

        return products.stream()
            .map(this::convertToBase64)
            .collect(Collectors.toList());
    }

    // 將圖片轉為Base64
    private ProductBean convertToBase64(ProductBean product) {
        if (product.getPicture() != null) {
            product.setPictureBase64(Base64.getEncoder().encodeToString(product.getPicture()));
        }
        return product;
    }

    // 分頁查詢的方法
    public Page<ProductBean> getProductsByPage(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ProductBean> productPage = productRepository.findAll(pageable);
        productPage.getContent().forEach(this::convertToBase64);
        return productPage;
    }

    // 隨機選擇商品
    public List<ProductBean> getRandomProducts(int count) {
        List<ProductBean> allProducts = productRepository.findAll();
        Random random = new Random();
        List<ProductBean> randomProducts = allProducts.stream()
            .sorted((p1, p2) -> random.nextInt(2) - 1)
            .limit(count)
            .collect(Collectors.toList());

        // 轉換圖片為Base64
        randomProducts.forEach(this::convertToBase64);

        return randomProducts;
    }
}
