$(document).ready(function () {
    $(".dropdown-button").dropdown();
    $('.modal-trigger').leanModal();
    $('.tabs').tabs();
});

var count = 0;
var total = 0;
var items = [];

function addItem(id, quantity, price) {
    var tempqty = parseInt(quantity);
    var tempprc = parseInt(price);
    var item = {itemId: id, itemQty: tempqty, itemPrc: tempprc};
    items.push(item);
}

function calculateTotal() {
    var total = 0;
    for (var i = 0; i < items.length; i++) {
        total = total + (items[i].itemQty * items[i].itemPrc);
    }
    $("#totalHarga").attr("data-value", total);
    $("#totalHarga").html(total);
}

function calculateRemainder(){
    var credit = document.getElementById('userCredit').getAttribute('data-value');
    var total = document.getElementById('totalHarga').getAttribute('data-value');
    var remainder = credit - total;
    if (remainder < 0) {
        $("#submitOrder").addClass("disabledbutton");
    } else {
        $("#submitOrder").removeClass("disabledbutton");
    }
    document.getElementById("sisacredit").value = remainder;
}
function changeQuantity(id, sel) {
    var quantity = sel.value;
    for (var i = 0; i < items.length; i++) {
        if (items[i].itemId === id) {
            items[i].itemQty = quantity;
        }
    }
    calculateTotal();
    calculateRemainder();
}
function removeItem(id) {
    items = jQuery.grep(items, function (value){
        return value.itemId !== id;
    });
    calculateTotal();
    calculateRemainder();
}
function addToCart(id, name, price) {

    $("#shopcart").append("<div id='order" + count + "' class='card animated bounceInUp  light-blue lighten-5'><div class='card-content black-text'><h4>" + name + "</h4><input type='hidden' name='id" + count + "' value='" + id + "'><div class='row'><div class='input-field'><select name='jumlah" + count + "' onchange='changeQuantity(" + id + ", this)'required><option value='0' selected disabled>Jumlah</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select><input type='text' name='keterangan" + count + "' placeholder='Keterangan'></div></div></div><div class='card-action'><a class='right-align' href='#' onclick='eraseCart(" + id + ", " + count + ", " + price + ")'><i class='material-icons right'>close</i></a></div></div>");
    disableButton(id);
    addItem(id, 0, price);
    increaseCount();
    $('select').material_select();
}

function increaseCount() {
    count++;
    document.getElementById("itemCount").value = count;
}

function decreaseCount() {
    count--;
    document.getElementById("itemCount").value = count;
}


function eraseCart(id, count, price) {
    $('#order' + count).remove();
    removeItem(id);
    enableButton(id);
    decreaseCount();

}

function updateTotal() {
    $("#totalHarga").html(total);
}


function disableButton(id) {
    $("#button" + id).addClass("disabledbutton");
}

function enableButton(id) {
    $("#button" + id).removeClass("disabledbutton");
}


