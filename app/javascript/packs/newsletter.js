var preview = document.getElementById("preview")

preview.onclick = (event) => {
    event.preventDefault()
    var body = document.getElementById("email_body")
    window.open("/rails/mailers/user_mailer/newsletter?email_body="+ body.value, 'Preview', "_parent");
}