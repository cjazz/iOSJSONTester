var req = require('request');

return function (context, cb) {
    if (context.data.slack_token && context.data.slack_channel) {
        console.log('Posting message to slack for repository ' 
            + context.webhook.repository.full_name);
        var url = 'https://slack.com/api/chat.postMessage'
            + '?token=' + context.data.slack_token
            + '&channel=' + context.data.slack_channel
            + '&user=' + (context.data.slack_user || 'WebTask')
           // + '&text=' + encodeURIComponent('Changes made in `' + context.webhook.repository.full_name + '`' + ' url: ' + context.webhook.repository.html_url);
            + '&text=' +('Changes made in: ' +context.webhook.repository.full_name + ' at: ' + context.webhook.repository.html_url);
            //+ '&text=' + context.webhook.repository.html_url;
        req({ url: url, method: 'POST' }, function (error, res, body) {
            cb(error, body);
        });
    }
    else {
        console.log('Repository ' + context.webhook.repository.full_name + ' changed but slack credentials not supplied.');
        return cb();
    }
}