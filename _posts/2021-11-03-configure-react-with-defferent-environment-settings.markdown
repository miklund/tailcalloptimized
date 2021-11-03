---
layout: post
title: "Configure React with different Environment Settings"
description: "Some techniques for configuring a React application."
date: 2021-11-03 20:39:02
tags: development
assets: assets/2021-11-03-configure-react-with-defferent-environment-settings
image: assets/posts/2021-11-03-configure-react-with-defferent-environment-settings/title.png

author:
  name: Mikael Lundin
  email: hello@mikaellundin.name
  web: http://mikaellundin.name
  twitter: mikaellundin
  github: miklund
  linkedin: miklund
---

I ran into this problem today, and after solving it was asked to blog about my findings.

I have a React application that is built to a Docker image and then statically hosted. I needed to configure the application with different OpenID Connect settings for test, staging and production environments. I couldn't just send environment variables to the Docker container, because the frontend application cannot read them.

I found a couple of different options.

## Using .env files

Create React App has built-in support for .env files. When you build the application, the configuration options are bundled into the app with the app bundle. The problem is that [dotenv](https://www.npmjs.com/package/dotenv) doesn't work like you expect it to.

Basically it supports using different configurations for development `npm start`, production `npm run build` and testing `npm test`. It doesn't support environments like test, staging and production. It is also strongly discouraged to commit .env files to source control.

Documentation for .env files.  
[https://create-react-app.dev/docs/adding-custom-environment-variables/](https://create-react-app.dev/docs/adding-custom-environment-variables/)

## Dynamic Rendering

Another technique I’ve used before, is to dynamically render the settings in a `<script>` tag in `index.html`.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <script>
      window.SERVER_DATA = <?php= json_encode($settings) ?>;
    </script>
  </head>
</html>
```

In your React application you can fetch the settings object from `window.SERVER_DATA`. By composing the settings object from environment variables, this lets you configure the React application from Docker container env vars.

The bad news is that your application is now dependent on external state, and that breaks portability. I don't like it.

I couldn't use the dynamic technique this time as my React files are statically hosted.

Some official documentation.  
[https://create-react-app.dev/docs/title-and-meta-tags#generating-dynamic-meta-tags-on-the-server](https://create-react-app.dev/docs/title-and-meta-tags#generating-dynamic-meta-tags-on-the-server)

## Fetch Configuration on Startup

I also have the option to fetch the configuration when application mounts.

```js
function App() {
  const [settings, setSettings] = useState({});

  useEffect(() => {
    const fetchSettingsAsync = () => {
      fetch("/api/settings")
        .then((response) => response.json())
        .then((data) => setSettings(data));
    };

    fetchSettingsAsync();
  });

  // rest of the program
}
```

If you're hosting an API for your application already on localhost, this might be a cleaner solution, but I don't like that my app starts with showing a loading spinner. Not for data that could've been bundled with the application.

## My Solution

I like the .env file approach. It is simple and integrates well into local development. However it doesn't support multiple environments out of the box. We can create a work-around by replacing the .env file in our CI.

First I create a `.env.development` file with reasonable defaults for local development. This can be committed to source control for simplified development setup.

Next, I create two files that I **don't** commit to source control.

- `.env-staging`
- `.env-production`

These files contain configurations for staging and production environment. As I've been using Azure DevOps I upload these files to the _secure file area_.

![Upload to Secure Files in DevOps](/assets/2021-11-03-configure-react-with-defferent-environment-settings/secret-files.png)

Next, I modify the build pipeline. Since Docker images are immutable I'll have to build one image for each environment.

In the build pipeline I download the secure file and add it as a secret to the `docker build` command. If using Docker Compose, secrets will not work during build step. An option here is to copy the file into the build context instead.

```yaml
- task: DownloadSecureFile@1
  name: env
  inputs:
  secureFile: "env-$(envName)"

- bash: DOCKER_BUILDKIT=1 docker build --secret id=env,src=$(env.secureFilePath)  -t incaps/vaccinated:1.0.0-$(envName) .
  displayName: "Docker build"
```

In the Dockerfile, I copy the `/run/secrets/env` file into my source repository where the `.env` file normally would be. This file has preceedence to any .env variant like `.env.development` or `.env.production`.

```dockerfile
# syntax = docker/dockerfile:1.1-experimental
# ...

RUN --mount=type=secret,id=env cp /run/secrets/env /src/.env
RUN npm run build
```

The app will now bundle with the environment specific configuration.

## Downsides

Since I bundle the configuration into the React bundle, I need to build one docker image for each of my environments. This somewhat contradicts the purpose of Docker, build once - run everywhere, but it is the option that I favoured for my specific case.
