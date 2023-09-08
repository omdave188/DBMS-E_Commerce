import React, {useEffect, useState} from "react";
import { useParams } from "react-router-dom";
import { getImage } from "../connections/base";
import { getProduct } from "../connections/base";

const ProductScreen = () => {
    const {id} = useParams();

    const [product, setProduct] = useState({});
    const [imgO, setImg] = useState("");

    useEffect(() => {
        (async () => {
            const res = await getProduct(id);
                const _img = await getImage(id);
                console.log(_img.image_url);
                setProduct(res);
                setImg(_img);
        })();
      }, []);

    return (
        <div className="container mt-5">
        <div className="row">
            <div className="col-md-6">
            <img
                src={imgO}
                alt="Product Thumbnail"
                className="card-img-top"
            />
            </div>
            <div className="col-md-6">
            <h1>{product.product_name}</h1>
            <p><strong>Product Description:</strong></p>
            <p>{product.product_description}</p>
            <p><strong>Color:</strong> {product.color}</p>
            <p><strong>Rating:</strong> {product.rating}</p>
            <p><strong>Review Count:</strong> {product.review_count}</p>
            <p><strong>Units Available:</strong> {product.available_units}</p>
            <h4 className="mt-4">${product.price}</h4>
            <button className="btn btn-primary mt-2">Add to Cart</button>
            </div>
        </div>
        </div>
    );
};

export default ProductScreen;
