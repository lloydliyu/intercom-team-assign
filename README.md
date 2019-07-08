# intercom-team-assign
A simple project for Intercom to reassign conversations from away mode reassigns to the last team inbox.

## Problem to solve
When a conversation is reassigned due to away mode, regardless of who it was assigned to, the inbox assignment rules it triggered when it was first started, or the inboxes it has been assigned to previously, it is always reassigned to the same `Lowest Priority Inbox`.

intercom-team-assign determines the last team inbox is the conversation was assigned to before the away mode reassign, and assigns it to that inbox.

## Dev Environment Install

Recommended: Ruby 2.6.3

- Download repository
- Open terminal and direct to the repository
- run `bundle install` command
- run `ruby server.rb`
- User `Ngrok` to expose the serve publicly.
- Create an App in your Intercom workspace.
- Within that app create a webhook that fires towards your ngrok URL with the topic `conversation.admin.assigned`.
- Create a file in the same directory of server.rb called `.env` and set the variables as per below.
- Run `ruby init.rb` within the directory.
- Put your away and reassign mode on.

## .env example

```
IC_ACCESS_TOKEN=
ASSIGNER_ID=
```

By default the assigner is the owner of the access token, this can be overridden by adding an `ASSIGNER_ID` in the .env file. This needs to be an id of an admin within the workspace or the assignment will fail.
