
return function (context, callback) {
    
    if (context.webhook) {
        console.log('Logging push for ' + context.webhook.repository.full_name);
        console.log('context.webhook.info:  ' +context.webhook.info);
    }
    else {
        console.log('No webhook');
        return callback();
    }
}
