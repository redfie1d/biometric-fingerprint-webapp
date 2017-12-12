/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    $('.cancel').hide();
    $('.confirm').hide();
    
    $('button.edit').on('click', function(){
       $('button.approve').hide();
       $('button.reject').hide();
       $('button.edit').hide();
       $('button.mask').hide();
       $(this).siblings('.cancel').show();
       $(this).siblings('.confirm').show();
    });
    
    $('button.cancel').on('click', function(){
       $('button.approve').show();
       $('button.reject').show();
       $('button.edit').show();
       $('button.mask').show();
       $(this).siblings('.confirm').hide();
       $(this).hide();
    });
});

function onEdit(orderIndex, orderID) {
    console.log("orderID"+orderID);

    var list = [];
    var $input = $("<td><input class='form-control' name='abc'/></td>");
    $input.css("width", "100px")

    var selection= $('.issued' + orderIndex + ' td:nth-child(5)');

     selection.each(function(index, select){
        list.push(+select.innerText);
    })

    selection.replaceWith($input);

    list.forEach(function(currentValue, index, array){
        var newSelection = $('input.form-control:eq('+ index +')');
        newSelection.val(currentValue);
    });
    
    $('button.cancel').on('click', function(){
        var testing = $('.issued' + orderIndex +' input');
        testing.each(function(index, select){
            select.replaceWith(list[index]);
        });
    });
    
    newQuantity = [];
    
    $('button.confirm').on('click',function(){
        console.log(orderID);
            var newSelection = $('input.form-control').each(function(index, select){
                newQuantity.push(+select.value);
            });
            
            jQuery.ajax({
                type: "POST",
                url: "EditOrderServlet",
                data: {
                    orderID: orderID,
                    newQuantity: newQuantity,
                },
                success: function (msg) {
                    location.reload();

                },
                error: function (request, status, error) {

                }
            });
    });

};

function onApprove(orderID) {
    jQuery.ajax({
        type: "POST",
        url: "ApproveOrderServlet",
        data: {
            orderID: orderID,
            approve: "approve",
        },
        success: function (msg) {
            location.reload();

        },
        error: function (request, status, error) {

        }
    });
};

function onReject(orderID) {
    jQuery.ajax({
        type: "POST",
        url: "ApproveOrderServlet",
        data: {
            orderID: orderID,
            reject: "reject",
        },
        success: function (msg) {
            location.reload();

        },
        error: function (request, status, error) {

        }
    });
};

function onHide(orderID) {
    jQuery.ajax({
        type: "POST",
        url: "ApproveOrderServlet",
        data: {
            orderID: orderID,
            hide: "hide",
        },
        success: function (msg) {
            location.reload();

        },
        error: function (request, status, error) {

        }
    });
};