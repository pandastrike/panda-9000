# Introducing The PANDA-9000

The PANDA 9000 should probably be a set of Grunt plugins or something. Basically, I'm finding that, for every project, I'm repeating certain patterns. We always have a Patchboard server, we always have a static file server (at least for development), we always need to build HTML and CSS files with Nice, and so on.

Rather than continue to cut-and-paste away, I figured the next most obvious thing to do was to put all this stuff in a repo with a package.json so we can reference it via Git tags. From there, we may promote some of these things into various NPMs, like those for Patchboard and Nice.

## Getting Started

Install via GitHub:

    npm install git://github.com/dyoder/panda-9000.git#0.0.0 --save
    
From there, you can run bin scripts from the `node_modules` directory.

**Example:**

Run an API server, which will attempt to build a Patchboard server using your local `src/api` directory, using (in this case) the `development` configuration in your `env` directory (`env/development/config.cson`):

    bin/api-server development

## Available Utilities

TBD
