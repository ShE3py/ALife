
const f_slider = document.getElementById("f");
const k_slider = document.getElementById("k");

f_slider.onchange = function () {
    wasm.exports.set_f(this.value);
    wasm.exports.reset_frame();
};

k_slider.onchange = function () {
    wasm.exports.set_k(this.value);
    wasm.exports.reset_frame();
};

document.getElementById("ru").onchange = function () {
    wasm.exports.set_ru(this.value);
    wasm.exports.reset_frame();
};

document.getElementById("rv").onchange = function () {
    wasm.exports.set_rv(this.value);
    wasm.exports.reset_frame();
};

document.getElementById("dt").onchange = function () {
    wasm.exports.set_dt(this.value);
    wasm.exports.reset_frame();
};

document.getElementById("type").onchange = function () {
    const FK = [
        [0.010, 0.047], // Alpha
        [0.014, 0.039], // Beta
        [0.022, 0.051], // Gamma
        [0.030, 0.055], // Delta
        [0.018, 0.055], // Epsilon
        [0.022, 0.061], // Zeta
        [0.034, 0.063], // Eta
        [0.030, 0.057], // Theta
        [0.046, 0.059], // Iota
        [0.050, 0.063], // Kappa
        [0.034, 0.065], // Lambda
        [0.046, 0.065], // Mu
        [0.082, 0.063], // Nu
        [0.010, 0.041], // Xi
        [0.062, 0.061], // Pi
        [0.090, 0.059], // Rho
        [0.011, 0.052], // Sigma
    ];

    const [f, k] = FK[this.value];
    f_slider.value = f;
    k_slider.value = k;

    wasm.exports.set_fk(f, k);
    wasm.exports.reset_frame();
}

document.getElementById("init").onchange = function () {
    wasm.exports.set_frame(this.value);
    wasm.exports.reset_frame();
}
