var request = require('request');

return function (context, callback) {
    request({ 
        url:'https://hooks.slack.com/services/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', 
        method: 'POST',
        payload: {'channel': '#random', 'text': 'New Code has been committed to the HB Repo'}
       
    }, function (error, res, body) {
        callback(error, body);
    });
}
