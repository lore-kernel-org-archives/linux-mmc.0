From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048 with a platform hook.
Date: Wed, 01 Jun 2011 00:42:02 -0400
Message-ID: <m3sjru40yt.fsf_-_@pullcord.laptop.org>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
	<m3mxi6p7fm.fsf@pullcord.laptop.org>
	<20110601040050.GA24330@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48022 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab1FAElH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2011 00:41:07 -0400
In-Reply-To: <20110601040050.GA24330@pengutronix.de> (Wolfram Sang's message
	of "Wed, 1 Jun 2011 06:00:50 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Nicolas Pitre <nico@fluxnic.net>

Hi Wolfram, Nico,

On Wed, Jun 01 2011, Wolfram Sang wrote:
> :( I still like the io-accessor-method a lot better.

That's okay -- nothing's final yet, I just wanted to get things moving
again since we're out of quirk space now.  I'm still happy to take a
patch from you instead if we decide it's the better way to go.

> I would have created a patch if I had got some feedback on my
> suggestion[1] (and will still do).
>
> [1] http://thread.gmane.org/gmane.linux.kernel.mmc/5742/focus=5768

Sorry for not replying.  I'm still mildly in favor of having it handled
as a platform check in the obvious place in sdhci.c, because I can
recall when I didn't know what IO-accessors were, and if I were trying
to track down a bug with with max_blk_size I would have found my way to
sdhci.c but not thought to look at a different part of the host driver
for code that had overloaded sdhci_readl() to mean something non-obvious.

In short, I want the code to be maintainable even by hackers who don't
yet understand how MMC chooses to organize itself, and I feel that your
proposal eventually results in code that seems "magic" and can't easily
be followed by a kernel hacker who happens to be unfamiliar with which
functions we tend to make override-able; someone doing a board bringup,
say.  I'm willing to change my mind, though.

You can counter-argue that my approach eventually pollutes sdhci.c with
a bunch of potential calls into platform code, such that people have to
spend time working out whether their platform is or isn't overwriting
any particular function.  That's certainly true.

Perhaps it comes down to preferred coding style -- maybe we can get
someone else to act as a tie-breaker?  :)  CC'ing Nico in case he's
interested.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
