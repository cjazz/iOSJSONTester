// var request = require('request');

return function (context, callback) {
    if (context.webhook) {
        console.log('Logging push for ' + context.webhook.repository.full_name);
        console.log('Context data' + context.data);

        // context.webhook contains the webhook payload provided by GitHub
        // context.data contains URL query and webtask token parameters

        // var url = 'https://slack.com/api/chat.postMessage'
        //     + '?token=' + context.data.slack_token
        //     + '&channel=' + context.data.slack_channel
        //     + '&user=' + (context.data.slack_user || 'WebTask')
        //     + '&text=' + encodeURIComponent('Changes in `' + context.webhook.repository.full_name + '`');
        // request({ url: url, method: 'POST' }, function (error, res, body) {
        //     callback(error, body);
        // });
    }
    else {
        console.log('No webhook');
        return callback();
    }
}
