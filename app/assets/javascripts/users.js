/* global $, Stripe */
//Document Ready
$(document).on('turbolinks:load', function(){
  
  var theForm = $('#pro_form');
  var submitBtn = $('#pro-submit-btn');

  //Set Stripe Publishable Key.
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

  //When user clicks the form submit button,
  submitBtn.click(function(event){
    //prevent default submission behavior.
    event.preventDefault();
    submitBtn.val("processing").prop("disabled",true);
    
    //Collect the credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    
    //Use Stripe JS to check for card errors.
    var error = false;
    
    //Validate card number.
    if(!Stripe.card.validateCardNumber(ccNum)){
      error = true;
      alert("The credit card number appears to be invalid.");
    }
    //Validate CVC number.
    if(!Stripe.card.validateCVC(cvcNum)){
      error = true;
      alert("The CVC Code appears to be invalid.");
    }
    //Validate expiration date.
    if(!Stripe.card.validateExpiry(expMonth, expYear)){
      error = true;
      alert("The expiration Date appears to be invalid.");
    }
    if(error){
      //If there are errors, don't send to Stripe.
      submitBtn.text("Sign Up").prop("disabled",false);
    } else {
        //Send the card info to Stripe
        Stripe.createToken({
          number: ccNum,
          cvc: cvcNum,
          exp_month: expMonth,
          exp_year: expYear,
          }, stripeResponseHandler);
        }
    return false;
  });
  //Stripe will return a card token.
  function stripeResponseHandler(status, response) {
    //Get the token from the response.
    var card_token = response.id;
    
    //Inject the token in a hidden field into the form.
    theForm.append($('<input type="hidden" name="user[stripe_card_token]">').val(card_token));
    //Submit the form into Rails server.
    theForm.get(0).submit();
  }
});