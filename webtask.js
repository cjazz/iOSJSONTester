return function (context, callback) {
    if (context.webhook) {
        console.log('Repo: ' + context.webhook.repository.full_name);
    }
    else {
        console.log('No webhook');
        return callback();
    }
}
