
class UserCheckout 
{
    constructor () {
        this.changeLoadingState = this.changeLoadingState.bind(this);
    }

    // runs script
    checkout = () => {

        this.deleteExtraForm()
        this.hideBillingAddress()
        
        //setup Stripe
        var env = document.getElementById("env")
        var stripe = Stripe(env.getAttribute("data-public_key"))
        
        var elements = stripe.elements();
        
        // Set up Stripe.js and Elements to use in checkout form
        var style = {
            base: {
                color: "#32325d",
            }
        };
        
        var card = elements.create("card", { style: style });
        card.mount("#card-element");
        
        
        card.on('change', ({error}) => {
        const displayError = document.getElementById('card-errors');
            if (error) {
                displayError.textContent = error.message;
            } else {
                displayError.textContent = '';
            }
        });
        
        document.getElementById("error").style.display = "none";
        document.getElementById("success").style.display = "none";
        
        var form = document.getElementById('payment-form');
        form.addEventListener('submit', (ev) => {
            ev.preventDefault();
            this.changeLoadingState(true);
            console.log("submitted")
            data = new FormData
            this.fillOrderData(data)
        
            console.log(data.values)
        
            Rails.ajax({
                url: "/secret",
                type: 'POST',
                data: data,
                error: (responseJson) => {
                    console.dir(responseJson)
                    console.log('error')
                    this.errorMessage("Invalid Address Info");
                },
                
                success: (responseJson) => {
                    var clientSecret = responseJson.client_secret;
                    stripe.confirmCardPayment(clientSecret, {
                            payment_method: {
                            card: card,
                            billing_details: {
                                name: responseJson.name,
                                email: responseJson.email,
                                address: {city: responseJson.billing_address.city,
                                        country: responseJson.billing_address.country,
                                        line1: responseJson.billing_address.line1,
                                        line2: responseJson.billing_address.line2,
                                        postal_code: responseJson.billing_address.postal_code,
                                        state: responseJson.billing_address.state}
                            }
                        }
                    }).then((result) => {
                        if (result.error) {
                            // Show error to your customer (e.g., insufficient funds)
                            this.errorMessage(result.error.message);
                        } else {
                            if (result.paymentIntent.status === 'succeeded') {
                                console.log('payment succeeded!')
                                setTimeout(() => {                                 
                                    this.paymentSuccess();
                                }, 500);
                                
                            } else {
                                this.errorMessage()
                            }
                        }
                        
                    });
                }
            })
        });        
    }    

    // Remove extra checkout shell based on screen size
    deleteExtraForm() {
        width = $(window).width();
        if (width <= 750) {
            document.getElementById("lg").remove();
        } else {
            document.getElementById("sm").remove();
        }
    }

    // Hide billling address form when user selects same as shipping
    hideBillingAddress = () => {
        var same_address = document.getElementById("same");
        var billing_form = document.getElementById("Billing");
        
        if (same_address)
        {
            same_address.onclick = function() {
                
                if (same_address.checked) {            
                    billing_form.style.display = "none";
                } else {
                    billing_form.style.display = "block";
                }
            }

        }

    }

    // Show a loading spinner on payment submission
    changeLoadingState = (isLoading) => {
        if (isLoading) {
            console.log('spinner time')
            
            document.getElementById("submit").disabled = true;
            document.querySelector("#spinner").classList.remove("hidden");
            document.querySelector("#button-text").classList.add("hidden");
        } else {
            document.getElementById("submit").disabled = false;
            document.querySelector("#spinner").classList.add("hidden");
            document.querySelector("#button-text").classList.remove("hidden");
        }
    }

    // Display a green check to notify user payment completed
    paymentSuccess = () => {
        document.getElementById("error").style.display = "none";
        document.getElementById("success").style.display = "block";
        document.getElementById("submit").style.display = "none";
        document.getElementById("check").style.display = "block";
        window.scrollTo(0, 0);
    }

    // Display a payment error to user
    errorMessage = (error = "An Unknown Error Has Occured") => {
        document.getElementById("error").innerText = error;
        document.getElementById("error").style.display = "block";
        document.getElementById("success").style.display = "none";
        this.changeLoadingState(false);
        window.scrollTo(0, 0);
    }

    // If guest checkout, append to the data whether the same button is checked
    getSameChecked (data) {
        var sameCheckedQuery = $("#billing #same");
        // If guest wants billing address to match shipping address
        if (sameCheckedQuery.length)
        {
            data.append("order[same_address]", sameCheckedQuery.is(':checked'))
        }
    }

    // Appends all address data fields to data form
    getAddressData(type, data) {
        var addressQuery = $("#order_"+ type + "_address_id");

        // If logged in user provides an address id
        if (addressQuery.length) {
            data.append("order[" + type + "_address_id]", addressQuery.val())
        }

        // Creating a new address in guest checkout
        else 
        { 
            data.append("order[" + type + "_address_id]", -1)
            data.append("order[" + type + "][full_name]", $("#" + type + " #full_name").val())
            data.append("order[" + type + "][phone_number]", $("#" + type + " #phone_number").val())
            data.append("order[" + type + "][address_line_1]", $("#" + type + " #address_line_1").val())
            data.append("order[" + type + "][address_line_2]", $("#" + type + " #address_line_2").val())
            data.append("order[" + type + "][city]", $("#" + type + " #city").val())
            data.append("order[" + type + "][state]", $("#" + type + " #state_code").val())
            data.append("order[" + type + "][zip]", $("#" + type + " #zip").val())
            data.append("order[" + type + "][country]", $("#" + type + " #country_code").val())
        }     
    }


    fillOrderData(data) {

        // Consistent field values
        data.append("order[amount]", $("#amount").val())
        data.append("order[currency]", $("#currency").val())
        data.append("order[user_id]", $("#user_id").val())
        

        // Inconsistent for guests and logged in users
        var emailQuery = $("#shipping #email")
        if (emailQuery.length)
            data.append("order[email]", $("#shipping #email").val())
        
        this.getAddressData("shipping", data)
        this.getSameChecked (data)
        this.getAddressData("billing", data)
    }
}


// Script execution
var CheckoutService = new UserCheckout()
CheckoutService.checkout()