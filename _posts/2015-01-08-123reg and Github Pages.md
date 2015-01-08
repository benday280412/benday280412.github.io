---
layout: post
title:  "Github Pages & 123-Reg DNS"
date:   2015-01-08 15:04
categories:
- blog
description: Configuring DNS with 123-reg for GitHub Pages
---

GitHub Pages provides a fast and easy way to get a static site up and running in a matter of minutes.  By simply creating a repository following the convention `{USERNAME}.github.io`, and adding some content, your done, site running.  The down side to this approach is that you end up with your site hosted under a URL of the same name, [benday280412.github.io][] in my case, which isn't that pretty and could cause some pain if you ever device to move your site.

To get around this, GitHub have provided a simple mechanism to allow you to use your own DNS name, letting you host your site under whatever name you like.  Whilst this sounds simple enough, it took a little fiddling to get it right for my particular use case.

So, the problem at hand.  I wanted to have my blog hosted on [www.benjaminday.co.uk][], but allow any traffic that hit [benjaminday.co.uk][] to be redirected to the www version.  This required a couple of changes, one on the GitHub repo and the second for my domain registrar, 123-reg.

The first was simple, add a file named CNAME to the root of your repo.  In this file, just add the DNS name you want your site to be hosted on.  So in my case [www.benjaminday.co.uk][].  This may take a while for it to propagate across GitHub's servers so give it a while.

Now we need to configure our domain registrar to route traffic to GitHub.  Head over to 123-reg and log in.  Then go to the control panel for your domain, click Manage->Manage DNS->Advanced DNS to access the configuration page.  My working setup looks as follows.

![DNS Settings Image](/images/123-reg DNS Settings.png "DNS Settings in 123-reg")

The first two entries are A records, these map your domain name to IP addresses.  GitHub has a couple of IPs that they provide, should one go off the air.  The @ denotes the apex domain, [benjaminday.co.uk][] for me.  It's important to get this in otherwise the redirect from [benjaminday.co.uk][] to [www.benjaminday.co.uk][] won't work, it needs both the www and the non-www version.

The third entry is a CNAME and this maps to a named host, rather than an IP.  In this case we point to the host name that GitHub issued, [benday280412.github.io][].  Now when traffic hits either variant www or non-www, the name resolves, and if it's the non-www, GitHub redirects the browser to the correct www one.

It's worth noting, the A records that map to the IP's do not benefit from GitHub's CDN nor their DDOS protection, so if you decide that you want the non-www version to be your primary address, route it using a CNAME and point the www version at the IPs.

These changes can take a few days to propagate, but I found that they usually took a couple of hours.

[benday280412.github.io]: http://benday280412.github.io "benday280412.github.io"
[www.benjaminday.co.uk]: http://www.benjaminday.co.uk "www.benjaminday.co.uk"
[benjaminday.co.uk]: http://benjaminday.co.uk "benjaminday.co.uk"

