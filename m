From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: print out controller name for register debug
Date: Thu, 23 Sep 2010 17:12:15 +0100
Message-ID: <20100923161215.GA27023@void.printf.net>
References: <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com> <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com> <4C984B01.2000005@nokia.com> <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com> <1CE3965A-95E9-41A7-8333-432778AAC336@marvell.com> <20100922230805.GA6659@void.printf.net> <20100923083946.GA2994@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60091 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab0IWQMW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 12:12:22 -0400
Content-Disposition: inline
In-Reply-To: <20100923083946.GA2994@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

Hi Wolfram,

On Thu, Sep 23, 2010 at 10:39:46AM +0200, Wolfram Sang wrote:
> Uh, that was fast.

Sorry, you're right, was fast.  I'm okay with improving patches after
they enter mmc-next, but I'll leave more time for comments on patches
in future before merging.

> I would have preferred to switch the whole printout to dev_dbg?

That's a much bigger change, though -- you'd be making sdhci_dumpregs()
a no-op unless CONFIG_MMC_DEBUG is defined, right?  That's a change in
semantics, since it's intentionally called from many non-debug error
paths right now.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
