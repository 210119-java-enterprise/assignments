# Devboards Forum API
The Devboards Forum will support the ability for end-users to be able to sign up for an account. Standard user accounts will have the ability to create new threads on existing boards, as well as share new posts on existing threads. Posts can be made either directly to the initial post of a thread, or to another post already on the thread (creating an inner post chain). Both threads and posts are able to be upvoted and downvoted by users, and this should be tracked for each user for marketing purposes. Users should be able to subscribe to threads. This can be done either by upvoting the thread, or by simply following it (which can be done without actually upvoting the thread). Lastly, the ability for users to directly message one another and for this message history to be retained should be supported.

## Suggested User Stories
As a standard user I can:
- register for a new account
- login using existing credentials
- view standard boards and their threads
- view the posts of a thread
- add a new post on a visible thread
- upvote/downvote posts and threads

As a mod user, I can:
- perform all standard user stories
- be designated as a moderator for a given board
- ban users for rules violations
- unban users
- create boards
- delete posts
- delete threads
- make threads sticky/unsticky

As an admin user, I can:
- perform all other user stories
- change existing user roles (add/remove moderators)

## Non-Functional Requirements
- Expose endpoints in a RESTful manner using Java servlets to support basic operations as defined by requirements documents
- Send error message objects when requests cannot be processed to aid in debugging
- Implement logging using a logging framework of your choice
- Encrypt user passwords prior to persisting to data source
- Persistence logic using Hibernate
- Create custom exception hierarchy
- Achieve <80% unit test coverage of service classes

## Docs:
https://github.com/210119-java-enterprise/assignments/blob/main/assets/devboards-erd.png
