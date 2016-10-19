var nodemailer = require('nodemailer');

return function (context, callback) {
    
    if (context.webhook) {
        console.log('Logging push for ' + context.webhook.repository.full_name);
        console.log('context.webhook.info:  ' +context.webhook.info);

        // create reusable transporter object using the default SMTP transport
        var transporter = nodemailer.createTransport('smtps://user%40gmail.com:pass@smtp.gmail.com');

        // setup e-mail data with unicode symbols
        var mailOptions = {
            from: '"Adam Chin ?" <chinjazz@gmail.com>', // sender address
            to: 'chinjazz@gmail.com, adam.chin@icloud.com', // list of receivers
            subject: 'More Cowbell for ' + context.webhook.repository.full_name, // Subject line
            text: 'More Cowbell  ?', // plaintext body
            html: '<b>More Cowbell ?</b>' // html body
        };

        // send mail with defined transport object
        transporter.sendMail(mailOptions, function(error, info){
            if(error){
                return console.log(error);
            }
            console.log('Message sent: ' + info.response);
        });
    }
    else {
        console.log('No webhook');
        return callback();
    }
}
