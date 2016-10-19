var request = require('request');

return function (context, callback) {

    if (contxt.webhook){
        request({ 
        url:'https://hooks.slack.com/services/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', 
        method: 'POST',
        payload: {"channel": "#random", "text": "New Code has been committed to: " +context.webhook.repository.full_name }
       
        }, function (error, res, body) {
            callback(error, body);
        });
    }
}