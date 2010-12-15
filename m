From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 07:03:55 -0600
Message-ID: <20101215130355.GA4124@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net> <20101215083546.GA16459@pengutronix.de> <20101215084307.GA29717@lixom.net> <20101215084634.GB29717@lixom.net> <20101215103730.GB3515@pengutronix.de> <20101215114000.GC2500@lixom.net> <20101215115911.GH3515@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:41593 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab0LOND4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 08:03:56 -0500
Content-Disposition: inline
In-Reply-To: <20101215115911.GH3515@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

On Wed, Dec 15, 2010 at 12:59:11PM +0100, Wolfram Sang wrote:
> 
> > > If there is something yet missing in sdhci-pltfm which you need, it
> > > probably is worth adding it there. Chances are good that other
> > > pltfm-users might want that, too.
> > 
> > Taking that to an extreme, any sdhci driver should plug into sdhci-pltfm and
> > just add the hooks needed. It will result in just one more abstraction layer that
> > makes following code flow harder.
> 
> Yes, of course. SDHCI is pretty well defined, so a good core on a SOC
> should just need sdhci-pltfm and some pltfm-data (and we got rid of a
> complete driver that way recently). If the core has quirks (as most
> sadly do), a bit of extension is needed. I'd prefer to have those
> extensions in one place rather than hidden in various drivers. I have
> the assumption they will be reusable, maybe this is a core point where
> we disagree?

Actually, I was of the impression that you wanted to hide the per-platform
hooks away from drivers/mmc/host. I see now that other drivers still add it
there. That's acceptable to me.

I'll whip up the changes and see how invasive it gets as a -pltfm
driver. It shouldn't be too bad. I'll repost the series that way, but
I will still keep the quirks for now and do a pass reworking these as
well as others separately (see below).

> > Especially if you want some of the quirk code to be moved from sdhci.c
> > to the driver.
> 
> Please elaborate. Why is sdhci-pltfm complicating things here?

Well, doing post-host_add-modifications of host->mmc->caps would add yet
another hook for the various platforms. :(

Anyway, I wonder if it does makes some sense to add a sdhci_ops callback
for fixing up the mmc settings after setting the defaults in host_add,
and for not just -pltfm. A handful of quirks are already only used for
overriding defaults, and they could be freed up. There's a few more that
are only used by a single driver and are suitable for handling through
overloaded register read/write functions.


I'll do a first pass, but it might take me a week or two due to other
more pressing things.


-Olof

