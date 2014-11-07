# twitter-imagebot

A simple-to-use twitter-imagebot written in Ruby

## Usage

`ruby bot.rb`

**Tip:** If you host this bot on a server be sure to run it in a screen/tmux session, so it won't stop when you disconnect

## Setup

### Requirements

* Ruby: Simple as that, there should be a package for \*nix-systems simply called `ruby`, on Windows just install RubyInstaller

### Preparations

* Run `bundle install` to install all other requirements to get the bot running without problems

### Configuration

First of all, rename both `config.example.yml` and `images.example.yml` to `config.yml` and `images.yml`

#### config.yml

* `username`: Filling this in will show you as a hoster of this bots instance on startup
* `sleep_time`: Time (in minutes) the bot will pause between posting images (default: `15`)
* `image_directory`: Directory the images for this bot are placed in (default: `img/`)

##### Twitter

* Go to [Twitter Apps](https://apps.twitter.com/) and create a new application
* Generate your consumer/access token keys/secrets for Read and Write access
* Add your consumer/access token keys/secrets to the `twitter` block inside `config.yml`

#### images.yml

Every block for one image looks like this:

```
- name: IMAGE_NAME_HERE
  location: IMAGE_LOCATION_HERE
  source: IMAGE_SOURCE HERE
```

* `name`: The name of the image displayed in the tweet (use character names or the title specified by the artist)
* `location`: The filename/location of one image, you can just use image names or include directories in between (examples: `image.jpg`, `dir/image.jpg`)
* `source`: The link to the original image, as the artist published it (no, (any)chan, (any)booru are no sources)

## License

twitter-imagebot is licensed under the MIT License