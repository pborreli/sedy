# Sedy Installer
A frontend application to make you install [Sedy](../) easily

# Install npm dependencies

```bash
make install
```

# Run project

```bash
make run
```

# Configuration

```js
export default {
    appBaseUrl: 'http://localhost:8080',
    githubRedirection: '/setup',
    githubAppId: 'xxx',
    githubScopes: [
        'write:repo_hook',
        'repo',
    ],
    githubUrl: 'https://api.github.com',
    webhookUrl: 'https://sedy.marmelab.com',
    sedyUsername: 'sedy-bot',
};

```
