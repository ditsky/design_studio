var preview = document.getElementById("preview")

preview.onclick = (event) => {
    event.preventDefault()
    var body = document.getElementById("email_body").value.replace(/(?:\r\n|\r|\n)/g, '<br>').replace(/ /g, '\u00a0');
    window.open("/rails/mailers/user_mailer/newsletter?email_body="+ body, 'Preview', "_parent");
}