import '../styles/login.css';
import { useState } from 'react';
import { createUser } from '../connections/base';

const SignUp = () => {

    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    const onSubmit = async () => {
        const res = await createUser(email, name, password);
        if (res.error) {
            console.log(res.error);
            alert(res.error);
        } else {
            console.log(res);
            alert("Signup Successful");
            window.location.href = `home/${name}`;
        }
    }

    return(
        <div class="container">
            <div class="row justify-content-center align-items-center inner-row">
                <div class="col-mg-5 col-md-7">
                    <div class="form-box signup-form p-md-5 p-3">
                        <div class="form-title">
                            <h2 class="fw-bold mb-3">
                                Sign Up
                            </h2>
                        </div>
                        <div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control form-control-sm" value={name} placeholder="Name" id="floatingName" onChange={(e) => setName(e.target.value)}/>
                                <label for="name"> Name </label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control form-control-sm" value={email} placeholder="Email" id="floatingEmail" onChange={(e) => setEmail(e.target.value)}/>
                                <label for="email"> Email </label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control form-control-sm" value={password} placeholder="Password" id="floatingPassword" onChange={(e) => setPassword(e.target.value)}/>
                                <label for="password"> Password </label>
                            </div>
                            <div class="mt-3" onClick={onSubmit}>
                                <button class="btn primaryBg">Sign Up</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default SignUp;
