From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: Replace SDHCI_QUIRK_NO_MULTIBLOCK with
	a platform hook.
Date: Sat, 12 Feb 2011 21:05:41 +0000
Message-ID: <20110212210541.GA11634@void.printf.net>
References: <m3zkq9n115.fsf@pullcord.laptop.org> <20110207174839.GF3123@pengutronix.de> <20110212202212.GA11375@void.printf.net> <20110212204350.GA23657@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39057 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab1BLVFn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Feb 2011 16:05:43 -0500
Content-Disposition: inline
In-Reply-To: <20110212204350.GA23657@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi Wolfram,

On Sat, Feb 12, 2011 at 09:43:50PM +0100, Wolfram Sang wrote:
> > If there still isn't a better alternative in mind, I'm thinking about
> > going ahead and taking this patch, and then reusing the quirk bit for
> > Chuanxiao's "mmc: set a suitable max_discard_sectors value for HC"
> > patchset.
> 
> What about using the SZ_2048 quirk instead which could be done via
> io-accessors?

That sounds fine too; I thought this one was more straightforward.

> That being said, I have a train travel tomorrow and will try to
> see if a fixup() function would make sense for this one. Can you
> wait one more day?

Sure, no immediate hurry.  Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
