import express from 'express';
import {getUsers, getUser, createUser, getProducts, getProduct, getImage, addWish, getWishList, getCart, addCart, removeWish, removeCart} from './database.js';
import cors from 'cors';

const app = express()

const corsOption = {
    origin:'*',
    credentials:true,
    optionSuccessStatus:200,
}

app.use(express.json())

app.use(cors(corsOption))

app.get("/users", async(req, res)=> {
    const users = await getUsers();
    res.send(users);
})

app.get("/products", async(req, res) => {
    const products = await getProducts();
    res.send(products);
})

app.get("/products/:id", async(req, res) => {
    const product = await getProduct(req.params.id);
    res.send(product);
})

app.get("/image/:id", async(req, res) => {
    const image = await getImage(req.params.id);
    res.send(image);
})

app.post("/add_to_wishlist", async(req, res) => {
    const { buyer_id, prod_id } = req.body;
    const out = await addWish(buyer_id, prod_id);
    res.send(out);
})

app.post("/remove_wishlist", async(req, res) => {
    const { buyer_id, prod_id } = req.body;
    const out = await removeWish(buyer_id, prod_id);
    res.send(out);
})

app.post("/remove_cart", async(req, res) => {
    const { buyer_id, prod_id } = req.body;
    const out = await removeCart(buyer_id, prod_id);
    res.send(out);
})

app.post("/cart", async(req, res) => {
    const { buyer_id, prod_id } = req.body;
    const out = await addCart(buyer_id, prod_id);
    res.send(out);
})

app.get("/users/:id", async(req, res) => {
    const user = await getUser(req.params.id);
    res.send(user);
})

app.get("/wishlist", async(req, res) => {
    const wish = await getWishList();
    res.send(wish);
})

app.get("/cart", async(req, res) => {
    const cart = await getCart();
    res.send(cart);
})

app.post("/users", async(req, res) => {
    const { email, name, password } = req.body;
    const user = await createUser(email, name, password);
    res.status(201).send(user);
})

app.listen(8081, () => {
    console.log('Server is running on port 8081');
})