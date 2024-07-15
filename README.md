# nagster

Simply shell script I'm using to send myself annoying popup windows so I don't miss a meeting while I'm heads down.

I'm sure there are far better options out there to accomplish the same thing, but I wanted something simple and to flex my shell scripting muscles a bit.

## Quickstart
```sh
nagster -e 'Take a break!' --system
nagster -e 'Daily Affirmation' -m 'You are a very good person. You are loved.' --popup
nagster -m 'Taking server down for maintenance!' --wall


# For custom notifiers, I'm thinking they should accept $EVENT_NAME and $EVENT_MESSAGE as $1 and $2 args.
nagster -e 'Super important meeting' -m "Don't miss this!!!" --system --wall --write --popup --app=sms.sh --app=slack-me.sh --app=pagerduty-alert.sh

# To watch my calendar, I'll be using a cron-job and gcalcli to send a popup nag for upcoming meetings. This way I'm forced to click the 'OK' button to close the dialog. Not implemented yet.

## Installing
```shell
git clone github.com/keithdadkins/nagster
cd nagster
chmod +x nagster
# optionally add to you PATH, ie
ln -sf nagster ~/.local/bin/nagster
export PATH="~/.local/bin:$PATH"
```

## TODO

- [ ] add vim/nvim notifiers
- [ ] add aws sqs notifier (to trigger slack, email, text, notifications via sns etc.)
