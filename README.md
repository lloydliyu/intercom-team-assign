# intercom-team-assign
A simple project for Intercom to reassign conversations from away mode reassigns to the last team inbox.

Originally created: June 2018

Last updated: 9th July 2019

## Problem to solve
When a conversation is reassigned due to away mode, regardless of who it was assigned to, the inbox assignment rules it triggered when it was first started, or the inboxes it has been assigned to previously, it is always reassigned to the same `Lowest Priority Inbox`.

intercom-team-assign determines the last team inbox the conversation was assigned to before the away mode reassign, and assigns it to that inbox instead.

## Dev Environment Install

Recommended: Ruby 2.6.3

- Download repository
- Open terminal and direct to the repository
- run `bundle install` command
- Use `Ngrok` to expose port `4567` publicly.
- Create an app in your Intercom Developer Hub.
- Within that app create a webhook that fires towards your ngrok URL with the topic `conversation.admin.assigned`.
- Create a file in the same directory of server.rb called `.env` and set the variables as below with your own access token.
- Run `ruby init.rb` within the directory. This would need to be run if you add/remove any new teams to/from your workspace.
- Run `ruby server.rb`
- Put your away and reassign mode on.

## .env example

```
IC_ACCESS_TOKEN=
```

By default the assigner is the owner of the access token, this can be overridden by adding an `ASSIGNER_ID=` in the .env file. This needs to be an id of an admin within the workspace or the assignment will fail.