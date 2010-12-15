From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 05:40:00 -0600
Message-ID: <20101215114000.GC2500@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net> <20101215083546.GA16459@pengutronix.de> <20101215084307.GA29717@lixom.net> <20101215084634.GB29717@lixom.net> <20101215103730.GB3515@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:52290 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab0LOLkA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 06:40:00 -0500
Content-Disposition: inline
In-Reply-To: <20101215103730.GB3515@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

On Wed, Dec 15, 2010 at 11:37:30AM +0100, Wolfram Sang wrote:
> 
> > Still, I don't see the point -- the amount of code would be about the
> > same between wrapping it with a coat of workarounds and op structures,
> > gpio setup, etc, and just doing a separate simple driver. The code shared
> > is really just the resource allocation pieces.
> 
> ? Saving 150 out of 260 lines does not count? Having a central point for
> bug-fixes in that part of the code?

Between duplicating some platform resource allocation code in the separate driver,
a driver (or shim layer) that will be needed in either case, I don't consider that
a high price to pay.

> If there is something yet missing in sdhci-pltfm which you need, it
> probably is worth adding it there. Chances are good that other
> pltfm-users might want that, too.

Taking that to an extreme, any sdhci driver should plug into sdhci-pltfm and
just add the hooks needed. It will result in just one more abstraction layer that
makes following code flow harder.

I know there's times when it makes sense to do so. I just consider this one to be
over the line where it makes sense to do a separate driver.

Especially if you want some of the quirk code to be moved from sdhci.c
to the driver.


Thanks,

-Olof
