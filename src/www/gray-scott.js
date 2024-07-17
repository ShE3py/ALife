
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

document.getElementById("type").onchange = function () {
    const FK = [
        [0.010, 0.047],
        [0.014, 0.039],
        [0.022, 0.051],
        [0.030, 0.055],
        [0.018, 0.055],
        [0.022, 0.061],
        [0.034, 0.063],
        [0.030, 0.057],
        [0.046, 0.059],
        [0.050, 0.063],
        [0.034, 0.065],
        [0.046, 0.065],
        [0.082, 0.063],
        [0.010, 0.041],
        [0.062, 0.061],
        [0.090, 0.059],
        [0.011, 0.052],
    ];

    const [f, k] = FK[this.value];
    f_slider.value = f;
    k_slider.value = k;

    wasm.exports.set_fk(f, k);
    wasm.exports.reset_frame();
}
