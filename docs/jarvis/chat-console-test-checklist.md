# Jarvis Chat Console Test Checklist

After applying Phase 05E and rebuilding Docker, test the following.

## Browser refresh

- Open `http://localhost:7000`
- Press `Ctrl + F5`
- Confirm the app loads without JavaScript errors visible in the UI

## Chat basics

- Start or open a chat
- Select a model
- Send a short message
- Confirm the assistant replies
- Confirm the input box still accepts text

## UI checks

- Mission context rail appears on wide screens
- Rail does not cover the chat composer
- Sidebar still works
- Top command bar from Phase 05D still works
- Model dropdown still works
- Attach/files controls still appear
- Agent/chat mode controls still appear

## Pages to spot check

- Chat
- Settings
- Added Models
- Brain
- Tools
- Notes
- Tasks

## Responsive checks

- Narrow browser width hides or softens the mission rail
- Chat remains usable
- No horizontal scrolling caused by the rail

## Regression warning signs

Stop and report if:

- chat input is blocked
- send button disappears
- model selector cannot be used
- settings cannot open
- large blank panel covers the app
- console shows repeated JavaScript errors
