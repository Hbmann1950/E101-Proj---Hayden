function gcd(_a, _b) {
    _a = abs(_a);
    _b = abs(_b);
    while (_b != 0) {
        var _temp = _b;
        _b = _a % _b;
        _a = _temp;
    }
    return _a;
}

function lcm(_a, _b) {
    if (_a == 0 || _b == 0) return 0;
    
    // We divide before multiplying to prevent potential integer overflow
    return abs(_a * (_b / gcd(_a, _b)));
}