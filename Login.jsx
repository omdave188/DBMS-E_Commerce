import '../styles/login.css';
import { useState } from 'react';
import { getUsers } from '../connections/base';

const Login = () => {

    const [email, setEmail] = useState("");
    const [pass, setPass] = useState("")

    const onSubmit = async () => {
        const res = await getUsers();
        const found = res.find(el => el.email === email);
        if(!found) {
            console.log("No user found!!");
            alert("No user found!!");
        } else {
            console.log(found);
            if(found.password != pass){
                alert("Wrong Password!!");
            }
            else {
                alert("Successful Login!!");
                window.location.href = `home/${found.name}`;
            }
        }
    }

    return(
        <div class="container">
            <div class="row justify-content-center align-items-center inner-row">
                <div class="col-mg-5 col-md-7">
                    <div class="form-box login-form p-md-5 p-3">
                        <div class="form-title">
                            <h2 class="fw-bold mb-3">
                                Login 
                            </h2>
                        </div>
                        <div>
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control form-control-sm" value={email} placeholder="Email" id="flotingInput" onChange={(e) => setEmail(e.target.value)}/>
                                <label for="email"> Email </label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control form-control-sm" value={pass} placeholder="Password" id="flotingPassword" onChange={(e) => setPass(e.target.value)}/>
                                <label for="password"> Password </label>
                            </div>
                            <div class="mt-3" onClick={onSubmit}>
                                <button class="btn primaryBg">Login</button>
                            </div>
                            <div class="mt-3">
                                Don't have an account? <a href="/signup">Sign up</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Login;