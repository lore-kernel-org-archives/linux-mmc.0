From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/7] sdhci: Tidy up spaces in sdhci_intel_mid
Date: Tue, 14 Sep 2010 17:57:43 +0100
Message-ID: <20100914165743.GA19431@void.printf.net>
References: <20100913172738.20345.61119.stgit@localhost.localdomain> <20100913173940.20345.66285.stgit@localhost.localdomain> <20100914142129.GF2629@pengutronix.de> <20100914144057.0d13f843@linux.intel.com> <20100914144512.GH2629@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56635 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab0INQ5s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Sep 2010 12:57:48 -0400
Content-Disposition: inline
In-Reply-To: <20100914144512.GH2629@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Alan Cox <alan@linux.intel.com>, linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 14, 2010 at 04:45:12PM +0200, Wolfram Sang wrote:
> I would indeed prefer to first have minimal changes to the
> mmc/sdhci-core and then have the final version of sdhci-intel-mid.c put
> on top of that (also applies to patch 4/7). Less error prone and easier
> to review. Yet, I am not the one who is picking up the patches.
> 
> (BTW can't you just combine SoB if you fold patches?)

I'm willing to help split up/fold patches if it'll help, especially
if it would make a difference to whether or not we get MID support
into 2.6.37, which is worth trying for.  I like Wolfram's suggested 
patchset format.  Alan, do you feel comfortable re-doing this in time
for some testing before the merge window opens, or should I help?

I think we should postpone style cleanups outside of sdhci-intel-mid.c
until .38, when there'll be less of an outstanding patch backlog.

The big question seems to be whether the approach the patchset takes
-- moving from quirks to hooks, extending sdhci.c without creating a 
full driver, and the initial choice of overridable hooks -- makes
sense.  I'd be happy to hear everyone's thoughts on that.

Thanks for the review so far, Wolfram!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
