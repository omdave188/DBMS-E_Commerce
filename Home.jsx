import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { getImage, getWish, getCart, addCart } from "../connections/base";
import { getProducts, getSpecificUser, addWish } from "../connections/base";

const Home = () => {

  const [cart, setCart] = useState([]);
  const [wishlist, setWishlist] = useState([]);
  const [buyer, setBuyer] = useState([]);

  const handleAddToCart = async (product_id) => {
    const res = await addCart(buyer, product_id);
    if (res.error) {
        console.log(res.error);
        alert(res.error);
    } else {
        console.log(res);
        alert("Added to Cart");
    }
  };

  const handleAddToWishlist = async (product_id) => {
    const res = await addWish(buyer, product_id);
    if (res.error) {
        console.log(res.error);
        alert(res.error);
    } else {
        console.log(res);
        alert("Added to Wishlist");
    }
  };

  const { name } = useParams();
  const [products, setProducts] = useState([]);
 
    useEffect(() => {
        (async () => {
            const res = await getSpecificUser(name);
            setBuyer(res.email);
            const prod = await getProducts();
            const wish = await getWish();
            let temp = [];
            for(const j in wish) {
              if(wish[j].buyer_id == res.email){
                temp.push(wish[j].product_id);
              }
            }
            const cart = await getCart();
            let temp2 = [];
            for(const j in cart) {
              if(cart[j].buyer_id == res.email){
                temp2.push(cart[j].product_id);
              }
            }
            setCart(temp2);
            setWishlist(temp);
            for(const i in prod) {
              const i_mg = await getImage(prod[i].product_id);
              prod[i].img = i_mg.image_url;
            }
            setProducts(prod);
        })();
      }, []);

      return (
        <div>
        <nav className="navbar navbar-expand-lg navbar-light bg-light">
          <a className="navbar-brand ml-10" href="#">Ecommerce Store</a>
          <div className="collapse navbar-collapse" id="navbarNav">
            <ul className="navbar-nav">
              <li className="nav-item">
                <a className="nav-link" href={`/${name}/cart`}>Cart ({cart.length})</a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href={`/${name}/wishlist`}>Wishlist ({wishlist.length})</a>
              </li>
            </ul>
          </div>
        </nav>
        <div className="container mt-5">
          <h1 className="text-center mb-4">Products</h1>
          <div className="row">
            {products.map(product => (
              <div key={product.product_id} className="col-md-6 col-lg-4 mb-4">
                <div className="card">
                  <img
                    src={product.img}
                    alt="Product Thumbnail"
                    className="card-img-top"
                  />
                  <div className="card-body">
                    <a href={`/product/${product.product_id}`}>
                      <h5 className="card-title">{product.product_name}</h5>
                    </a>
                    <p className="card-text">{product.product_description}</p>
                    <p className="card-text"><strong>Color:</strong> {product.color}</p>
                    <p className="card-text"><strong>Rating:</strong> {product.rating}</p>
                    <p className="card-text"><strong>Reviews:</strong> {product.review_count}</p>
                    <p className="card-text"><strong>Units available:</strong> {product.available_units}</p>
                    <h6 className="card-subtitle mb-2 text-muted">${product.price}</h6>
                    <button className="btn btn-primary mr-2" onClick={() => handleAddToCart(product.product_id)}>Add to Cart</button> <br />
                    <button className="btn btn-outline-primary mt-2" onClick={() => handleAddToWishlist(product.product_id)}>Add to Wishlist</button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
      );
}

export default Home;