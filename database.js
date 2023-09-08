import mysql from 'mysql2'; 

const ecommerce = mysql.createPool({
    host: '127.0.0.1',
    user: 'joe root',
    password: '123',
    database: 'ecommerce',
}).promise();

export async function getUsers() {
    const [result] = await ecommerce.query("SELECT * FROM user_detail");
    return result;
}

export async function getProducts() {
    const [result] = await ecommerce.query("SELECT * FROM product");
    return result;
}

export async function getProduct(id) {
    const [result] = await ecommerce.query(`
        SELECT *
        FROM product
        WHERE product_id = ?
        `, [id])
    return result[0];
}

export async function getImage(id) {
    const [result] = await ecommerce.query(`
        SELECT *
        FROM product_image
        WHERE product_id = ?
        `, [id])
    return result[0];
}

export async function getUser(name) {
    const [result] = await ecommerce.query(`
        SELECT *
        FROM user_detail
        WHERE name = ?
    `, [name])
    return result[0];
}

export async function createUser(email, name, password) {
    const result = await ecommerce.query(`
        CALL register_buyer(?, ?, ?)
    `, [email, name, password]);
    return result;
}

export async function addWish(buyer_id, prod_id) {
    const result = await ecommerce.query(`CALL add_to_wish_list(? ,?)`, [buyer_id, prod_id]);
    return result;
}

export async function removeWish(buyer_id, prod_id) {
    const result = await ecommerce.query(`CALL remove_wishlist(? ,?)`, [buyer_id, prod_id]);
    return result;
}

export async function removeCart(buyer_id, prod_id) {
    const result = await ecommerce.query(`CALL remove_shopping_cart(? ,?)`, [buyer_id, prod_id]);
    return result;
}

export async function addCart(buyer_id, prod_id) {
    const result = await ecommerce.query(`CALL add_to_shopping_cart(? ,?)`, [buyer_id, prod_id]);
    return result;
}

export async function getWishList() {
    const [result] = await ecommerce.query(`select * from wish_list`);
    return result;
}

export async function getCart() {
    const [result] = await ecommerce.query(`select * from product_shoppingcart`);
    return result;
}

