import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getWish, getSpecificUser, getProduct, getImage, removeWish } from '../connections/base';

const Wishlist = () => {
  const {name} = useParams();
  const [products, setProducts] = useState([]);
  const [buyer, setBuyer] = useState("");

  const removeProduct = async (product_id) => {
    const res = await removeWish(buyer, product_id);
    if (res.error) {
        console.log(res.error);
        alert(res.error);
    } else {
        console.log(res);
        alert("Removed From Wishlist");
    }
  };

  useEffect(() => {
    (async () => {
      const res = await getSpecificUser(name);
      setBuyer(res.email);
      const wish = await getWish();
      let temp = [];
      for(const j in wish) {
        if(wish[j].buyer_id == res.email){
          temp.push(wish[j].product_id);
        }
      }
      console.log(temp);
      let prod_temp = [];
      for(const k in temp) {
        const res = await getProduct(temp[k]);
        const i_mg = await getImage(temp[k]);
        res.img = i_mg.image_url;
        prod_temp.push(res);
      }
      console.log(prod_temp);
      setProducts(prod_temp);
    })();
  }, []);

  return (
    <div className="container">
      <h1 className="my-4">My Wishlist</h1>
      {products.length === 0 ? (
        <p>No products in your wishlist yet!</p>
      ) : (
        <div className="row row-cols-1 row-cols-md-3 g-4">
          {products.map((product) => (
            <div className="col" key={product.id}>
              <div className="card h-100">
                <img src={product.img} className="card-img-top" alt={product.name} />
                <div className="card-body">
                  <h5 className="card-title">{product.product_name}</h5>
                  <p className="card-text">
                    <strong>Price:</strong> {product.price}
                  </p>
                  <p className="card-text">
                    <strong>Reviews:</strong> {product.review_count}
                  </p>
                  <p className="card-text">
                    <strong>Ratings:</strong> {product.rating}
                  </p>
                  <p className="card-text">
                    <strong>Color:</strong> {product.color}
                  </p>
                  <button className="btn btn-primary" onClick={() => removeProduct(product.product_id)}>
                    Remove
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default Wishlist;
