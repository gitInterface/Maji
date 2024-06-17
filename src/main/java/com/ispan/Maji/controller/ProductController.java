package com.ispan.Maji.controller;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ispan.Maji.domain.ProductBean;
import com.ispan.Maji.service.ProductService;

@RestController
@RequestMapping("/api/products")
@CrossOrigin
public class ProductController {
    @Autowired
    private ProductService productService;

    // 顯示商品
    @GetMapping("/showproducts")
    public ResponseEntity<List<ProductBean>> showProducts() {
        List<ProductBean> products = productService.getAllProducts();
        // 將圖片轉換為Base64格式
        products.forEach(product -> {
            byte[] imageBytes = product.getPicture();
            if (imageBytes != null) {
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                product.setPictureBase64(base64Image);
            }
        });
        return ResponseEntity.ok(products);
}
    
    // 新增商品
    @PostMapping("/insert")
    public ResponseEntity<String> insertProduct(@RequestParam("name") String name,
                                                @RequestParam("discription") String discription,
                                                @RequestParam("picture") MultipartFile picture,
                                                @RequestParam("tags") String tag,
                                                @RequestParam("price") String price) {
        try {
            ProductBean product = new ProductBean();
            product.setProductName(name);
            product.setDiscription(discription);
            product.setTag(tag);
            product.setPrice(Integer.parseInt(price));
            if (!picture.isEmpty()) {
                product.setPicture(picture.getBytes());
            }
            productService.saveProduct(product);
            return ResponseEntity.status(HttpStatus.CREATED).body("商品新增成功");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("新增商品過程中發生錯誤" + e.getMessage());
        }
    }

    //  刪除商品
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable("id") String productId) {
        try {
            productService.deleteProductById(Integer.parseInt(productId));
            return ResponseEntity.ok("商品刪除成功");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("刪除商品過程中發生錯誤" + e.getMessage());
        }
    }

    // 查詢商品
    @GetMapping("/search")
    public ResponseEntity<List<ProductBean>> searchProducts(@RequestParam("query") String query) {
        List<ProductBean> products = productService.searchProducts(query);
        return ResponseEntity.ok(products);
    }

    // 分頁查詢方法
    @GetMapping("/paginated")   
    public ResponseEntity<Page<ProductBean>> getProductsByPage(@RequestParam int page, @RequestParam int size) {
        Page<ProductBean> productPage = productService.getProductsByPage(page, size);
        return ResponseEntity.ok(productPage);
    }

    // 獲取單個商品信息的方法
    @GetMapping("/{productID}")
    public ResponseEntity<ProductBean> getProductById(@PathVariable Integer productID) {
        ProductBean product = productService.getProductById(productID);
        if (product.getPicture() != null) {
            product.setPictureBase64(Base64.getEncoder().encodeToString(product.getPicture()));
        }
        return ResponseEntity.ok(product);
    }

    // 更新商品資訊的方法
    @PostMapping("/update")
    public ResponseEntity<String> updateProduct(@RequestParam("productID") Integer productID,
                                                @RequestParam("name") String name,
                                                @RequestParam("discription") String discription,
                                                @RequestParam("picture") MultipartFile picture,
                                                @RequestParam("tags") String tag,
                                                @RequestParam("price") String price) {
        try {
            ProductBean product = productService.getProductById(productID);
            product.setProductName(name);
            product.setDiscription(discription);
            product.setTag(tag);
            product.setPrice(Integer.parseInt(price));
            if (!picture.isEmpty()) {
                product.setPicture(picture.getBytes());
            }
            productService.saveProduct(product);
            return ResponseEntity.status(HttpStatus.OK).body("商品更新成功");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("更新商品過程中發生錯誤" + e.getMessage());
        }
    }

}
