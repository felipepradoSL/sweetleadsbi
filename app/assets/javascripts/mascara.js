function mascara(o, f) {
    v_obj = o;
    v_fun = f;
    setTimeout("execmascara()", 1);
}

function execmascara() {
    v_obj.value = v_fun(v_obj.value);
}

function checaValor(v) {

    v = v.replace(/\D/g, ""); //permite digitar apenas números
    v = v.replace(/(\d{1})(\d{14})$/, "$1.$2");
    v = v.replace(/(\d{1})(\d{11})$/, "$1.$2");
    v = v.replace(/(\d{1})(\d{8})$/, "$1.$2"); //coloca ponto antes dos últimos 8 digitos
    v = v.replace(/(\d{1})(\d{5})$/, "$1.$2"); //coloca ponto antes dos últimos 5 digitos
    v = v.replace(/(\d{1})(\d{1,2})$/, "$1,$2"); //coloca virgula antes dos últimos 2 digitos

    return v;

}

function checaNumero(v) {

    v = v.replace(/\D/g, ""); //permite digitar apenas números
    v = v.replace(/(\d{1})(\d{12})$/, "$1.$2");
    v = v.replace(/(\d{1})(\d{9})$/, "$1.$2");
    v = v.replace(/(\d{1})(\d{6})$/, "$1.$2"); //coloca ponto antes dos últimos 6 digitos
    v = v.replace(/(\d{1})(\d{3})$/, "$1.$2"); //coloca ponto antes dos últimos 3 digitos

    return v;

}

function checaCPF(v) {
    v = v.replace(/\D/g, "") //Remove tudo o que n?o ? d?gito
    v = v.replace(/(\d{3})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1-$2");
    return v;
}

function checaCNPJ(v) {
    v = v.replace(/\D/g, "");
    v = v.replace(/(\d{2})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1.$2");
    v = v.replace(/(\d{3})(\d)/, "$1/$2");
    v = v.replace(/(\d{4})(\d)/, "$1-$2");

    return v;
}

function checaCep(v) {
      v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
      v = v.replace(/(\d{5})(\d)/, "$1-$2"); //Coloca h?fen entre o quarto e o quinto d?gitos
    return v;
}

function checaData(v) {
      v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
      v = v.replace(/(\d{2})(\d)/, "$1/$2"); //Coloca h?fen entre o quarto e o quinto d?gitos
      v = v.replace(/(\d{2})(\d)/, "$1/$2"); //Coloca h?fen entre o quarto e o quinto d?gitos
    return v;
}

function checaTelefone(v) {
    if( v.length < 15 ) {
      v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
      v = v.replace(/^(\d\d)(\d)/g, "($1) $2"); //Coloca par?nteses em volta dos dois primeiros d?gitos
      v = v.replace(/(\d{4})(\d)/, "$1-$2"); //Coloca h?fen entre o quarto e o quinto d?gitos
    }
    else {
      v = v.replace(/\D/g, ""); //Remove tudo o que n?o ? d?gito
      v = v.replace(/^(\d\d)(\d)/g, "($1) $2"); //Coloca par?nteses em volta dos dois primeiros d?gitos
      v = v.replace(/(\d{5})(\d)/, "$1-$2"); //Coloca h?fen entre o quarto e o quinto d?gitos
    }
    return v;
}

function checaEmail( value ) {
    regex=/^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,4}$/;
    return regex.test( value );
}
