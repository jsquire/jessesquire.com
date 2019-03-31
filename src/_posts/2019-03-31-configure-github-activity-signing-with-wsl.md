---
layout: post
title:  "Configure GitHub Activity Signing with Windows Subsystem for Linux (WSL)"
date:   2019-03-09 13:34:26 -0500
category: articles
tags:
  - git
  - github
  - wsl
  - configuration
---
Now that I'm in a role where my job entails writing code for Microsoft products in the open on GitHub, I thought that it may be a good idea to make sure that my commits and related activities on GitHub were signed and could be verified as my contributions.  That isn't meant to imply that I have major concerns about spoofing, but I remembered that it happened to [Scott Hanselman](https://twitter.com/shanselman) last year and that he set up signing in response to it.

Scott ended up [configuring GPG signing with a YubiKey](https://www.hanselman.com/blog/HowToSetupSignedGitCommitsWithAYubiKeyNEOAndGPGAndKeybaseOnWindows.aspx), which looked like an intimidating process.  I wanted to do something more basic and see if using the stock on-box storage was as straightforward as configuring SSH authentication for GitHub.

# Setting the Stage

In my normal development flow, I use the git command line, either under WSL on Windows or natively on Linux.  While I may use a GUI tool occasionally to help visualize the commit graph for a repository, I tend to do all of the activities that I'm interested in signing outside of them.  I prefer a dedicated stand-alone command line window to embedded instances, such as the terminal in Visual Studio Code.

As a result, the process that I'm describing here is focused on integrating GPG signing into a git workflow from a stand-alone terminal window.  Some things may or may not work elsewhere but, I've honestly not spent any time exploring or verifying other tools.  The other goal that I had was to try and minimize the number of times in a day that I'd have to unlock my GPG key with a password.

GitHub has some great documentation on the process, walking through the steps needed locally as well as within the GitHub site in order to enable signing.  For the most part, I'll be referring back to them where possible, up through configuring the basic signing mechanism.  There are a few things needed to enable local caching of your GPG credentials to avoid a password prompt for each commit that those guides didn't cover.

# Prerequisites

Before starting, I find it helpful to have the necessary packages installed and ready to go, rather than pulling them down as needed.  To that end, I'd recommend installing the following on a Debian-based distribution, such as Ubuntu:

{:.with-paragraph .single .end-section}
- `build-essential`
- `apt-transport-https`
- `software-properties-common`
- `ca-certificates`
- `curl`
- `git`
- `gpg`
- `gnupg`
- `gpg-agent`
- `pinentry-curses`

# Generating the Key

I'd recommend following the GitHub Help guide - [Generating a new GPG key](https://help.github.com/en/articles/generating-a-new-gpg-key).  It has a nice step-by-step flow for each operating system.  In my case, the Linux steps went smoothly and I'd echo the GitHub advice of using a 4096 bit key.  As the guide mentions, you can verify the key that you created using:<br />
`gpg --list-secret-keys --keyid-format LONG`{:.no-wrap .with-paragraph}

# Configuring GitHub

Here, again, GitHub Help provides an excellent guide - [Adding a new GPG key to your GitHub account](https://help.github.com/en/articles/adding-a-new-gpg-key-to-your-github-account), which builds upon the previous guide for key generation.  Before starting the configuration guide, you'll want to make sure that you have your key available.

{:.with-paragraph}
To do so, start by listing your available GPG keys, using:<br />
`gpg --list-secret-keys --keyid-format LONG`{:.no-wrap}

{:.with-paragraph}
From the list, copy the id of the key that you'll be using to sign, which will be in a line that looks like:<br />
`sec    [Key Length]/[Key ID] [Date Created and Expiry Date]`{:.no-wrap .with-paragraph}

{:.with-paragraph}
If the `sec` line of your output is the following, then your key Id is `3AA5C34371567BD2`.<br />
`sec    4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]`{:.no-wrap .with-paragraph}

{:.with-paragraph}
Once you have the key, you'll need to export the full key in armor format.  You can do so using:<br />
`gpg --armor --export << YOUR KEY ID >>`{:.no-wrap}

{:.with-paragraph}
GitHub will expect the public portion of your key, starting with `-----BEGIN PGP PUBLIC KEY BLOCK-----`{:.no-wrap} up through `-----END PGP PUBLIC KEY BLOCK-----`{:.no-wrap}, including those markers copied as part of your key.

{:.with-paragraph}
Once you follow the steps in the guide, GitHub will have your key registered and is ready to verify your signed activities.

# Register Your Key with Git

The most important step in configuring the terminal is to tell git to make use of your key.  Again, GitHub Help has a useful guide - [Telling Git about your signing key](https://help.github.com/en/articles/telling-git-about-your-signing-key#telling-git-about-your-gpg-key-1), from which the steps that we're interested in fall under the `Telling Git about your GPG key` title.  In a nutshell, the steps are:

{:.with-paragraph}
1. List your available GPG keys and copy the Id of the key that you'll be using to sign, the same way that you had done when configuring GitHub.
1. Configure your `.gitconfig`{:.no-color} to associate the key by using the command:<br />`git config --global user.signingkey << YOUR KEY ID >>`{:.no-wrap}

Optionally, if you'd like to instruct git to always sign commits and tags, you can run the following to update your git configuration:

{:.with-paragraph .single .end-section}
- `git config --global commit.gpgsign true`
- `git config --global tag.gpgsign true`

# Configuring Entry and Caching for your GPG Credentials

At this point, you're able to perform end-to-end signing for commits, tags, and related GitHub activities.  The unfortunate part is that your git client will prompt for a password before each of those operations, which tends to have a negative impact on productivity.  To get around this, it is possible to cache your GPG key password, allowing you to use the git client normally, without additional entry, but producing signed commits.

Unfortunately, this is an area where there wasn't a helpful GitHub guide and most of the resources that I found were focused on macOS and/or out of date.  The basic gist of what we'd like to do is use the `gpg-agent` as a cache for the credentials and integrate that with the WSL terminal, having the `curses`{:.no-color} user experience prompt for entry of the GPG password, so that it's very clear when it's needed.

To start, we'll need to configure GPG to make use of the agent for caching and set the key used by default.  In `~/.gnupg/gpg.conf`{:.no-color}, add or update the following:

```text
# Uncomment within config (or add this line)
# This tells gpg to use the gpg-agent
use-agent

# Set the default key
default-key << YOUR KEY ID >>
```
{:.with-paragraph}

The next step is to configure the GPG Agent to cache your password and instruct it how we would like to be prompted for password entry.  The GPG Agent allows for the time of the cache to be specified, so that you're able to make the choice that is right for you.  In the example, caching is set to 400 days (34560000 seconds) so that it can be entered once and then is not needed again until the computer or WSL session are restarted.  In `~/.gnupg/gpg.conf`{:.no-color}, the cache times and an executable for password prompting are registered.  The GPU configuration should contain the following, though you may need to change the location of your pin entry program to the output of the command `which pinentry-curses`, depending on your operating system:

```text
default-cache-ttl 34560000
max-cache-ttl 34560000
pinentry-program /usr/bin/pinentry-curses
```
{:.with-paragraph}

The final step is to ensure that the GPG agent launches when your WSL session starts and that the environment is prepared.  Note that this is an area where things have changed fairly recently, and most of the resources that I found on the web were outdated.  The approach that I'm using here was tested with GPG v2.2.4 and GPG Agent v2.2.4.  In either `~/.profile`{:.no-color} or `~/.bashrc`{:.no-color}, add the following:

```text
# enable GPG signing
export GPG_TTY=$(tty)

if [ ! -f ~/.gnupg/S.gpg-agent ]; then
    eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf )
fi

export GPG_AGENT_INFO=${HOME}/.gnupg/S.gpg-agent:0:1
```
{:.with-paragraph}

# That's All, Folks

If you've gotten this far, then git in your Windows Subsystem for Linux terminal should be all set to sign commits.  While there may be a few steps involved, they felt reasonably straightforward to me, once I had figured out the environment configuration.  Hopefully, this guide helped to lay out the end-to-end steps and will save others from having to piece them together from multiple resources.

# Helpful Resources

{:.single}
- [GitHub Help - Signing commits](https://help.github.com/en/articles/signing-commits)
- [GitHub Help - Generating a new GPG key](https://help.github.com/en/articles/generating-a-new-gpg-key)
- [Git GPG Documentation](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)
- [GPG Agent Configuration Options](https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html)
- [GPG Suite](https://gpgtools.org/) _(allows GPG integration with the macOS keychain)_{:.tiny-text}
- [Gpg4win](https://www.gpg4win.org/) _(allows GPG integration with Windows and may enable GUI clients)_{:.tiny-text}
- [Signing Git Commits and Tags Using Your GPG Key](https://jasonrogena.github.io/2016/09/14/osx-signing-off-git-using-gpg.html) _(a guide focused on macOS, used as inspiration for this one)_{:.tiny-text}
