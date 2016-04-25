$(document).ready(function () {
    $(".dropdown-button").dropdown();
    $('.modal-trigger').leanModal();
    $('.tabs').tabs();
});

var count = 0;
var total = 0;

function addToCart(id, name, price) {
    $("#shopcart").append("<div id='order" + count + "' class='card animated bounceInUp'><div class='card-content black-text'><input type='text' value='" + name + "' disabled/><div class='row'><div class='input-field'><select id='jumlah" + count + "'><option value='1' selected>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select></div></div></div><div class='card-action'><a class='right-align' href='#' onclick='eraseCart(" + count + ", " + price + ")'>Remove</a></div></div>");
    total += parseInt(price, 10);
    increaseCount();
    updateTotal();
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
function eraseCart(id, price) {
    $('#order' + id).remove()
    total -= parseInt(price, 10);
    decreaseCount();
    updateTotal();
}
function updateTotal() {
    $("#totalHarga").html("Total : Rp. " + total);

}
$("[id^=jumlah]").change(function () {
    $(this).val();
})