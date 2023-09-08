import axios from "axios";
const baseURL = 'http://localhost:8081';

export const getUsers = async () => {
    const output = await axios.get(`${baseURL}/users`)
        .catch((err) => {
            console.log(err);
        });
    return output.data;
}

export const getWish = async () => {
    const output = await axios.get(`${baseURL}/wishlist`)
        .catch((err) => {
            console.log(err);
        });
    return output.data;
}

export const getCart = async () => {
    const output = await axios.get(`${baseURL}/cart`)
        .catch((err) => {
            console.log(err);
        });
    return output.data;
}

export const createUser = async (email, name, password) => {
    const output = await axios.post(`${baseURL}/users`, {
        email : email,
        name : name,
        password : password
    });
    return output.data;
}

export const getProducts = async () => {
    const output = await axios.get(`${baseURL}/products`)
        .catch((err) => {
            console.log(err);
        });
    return output.data;
}

export const getProduct = async (id) => {
    const output = await axios.get(`${baseURL}/products/${id}`)
        .catch((err) => {
            console.log(err);
        })
    return output.data;
}

export const getImage = async (id) => {
    const output = await axios.get(`${baseURL}/image/${id}`)
        .catch((err) => {
            console.log(err);
        })
    return output.data;
}

export const getSpecificUser = async (name) => {
    const output = await axios.get(`${baseURL}/users/${name}`)
        .catch((err) => {
            console.log(err);
        })
    return output.data;
}

export const addWish = async (buyer_id, prod_id) => {
    const output = await axios.post(`${baseURL}/add_to_wishlist`, {
        buyer_id : buyer_id,
        prod_id : prod_id,
    });
    return output.data;
}

export const removeWish = async (buyer_id, prod_id) => {
    const output = await axios.post(`${baseURL}/remove_wishlist`, {
        buyer_id : buyer_id,
        prod_id : prod_id,
    });
    return output.data;
}

export const removeCart = async (buyer_id, prod_id) => {
    const output = await axios.post(`${baseURL}/remove_cart`, {
        buyer_id : buyer_id,
        prod_id : prod_id,
    });
    return output.data;
}

export const addCart = async (buyer_id, prod_id) => {
    const output = await axios.post(`${baseURL}/cart`, {
        buyer_id : buyer_id,
        prod_id : prod_id,
    });
    return output.data;
}