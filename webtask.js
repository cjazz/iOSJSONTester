var request = require('request');

return function (context, callback) {
    if (context.data.slack_token && context.data.slack_channel) {
        console.log('Posting message to slack for repository ' 
            + context.webhook.repository.full_name);
        var url = 'https://slack.com/api/chat.postMessage'
            + '?token=' + 'xoxp-15101058326-15101831218-93098380470-d30b4b9ecbd3a8d30de2f72cb73bccf3'
            + '&channel=' + '#random'
            + '&user=' + (context.data.slack_user || 'WebTask')
            + '&text=' + encodeURIComponent('Changes in `' + context.webhook.repository.full_name + '`');
        request({ url: url, method: 'POST' }, function (error, res, body) {
            callback(error, body);
        });
    }
    else {
        console.log('Repository ' + context.webhook.repository.full_name + ' changed but slack credentials not supplied.');
        return callback();
    }
}