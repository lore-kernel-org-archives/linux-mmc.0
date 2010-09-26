From: Chris Ball <cjb@laptop.org>
Subject: Re: sdhci: Best Practice Question
Date: Sun, 26 Sep 2010 17:40:05 +0100
Message-ID: <20100926164005.GC19772@void.printf.net>
References: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48686 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab0IZQkG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Sep 2010 12:40:06 -0400
Content-Disposition: inline
In-Reply-To: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

On Sat, Sep 25, 2010 at 01:08:20PM -0700, Philip Rakity wrote:
> The change proposed by Richard Zhu for handling write protect uses 
> only a callback.
> 
> <snip>
> static int sdhci_get_ro(struct mmc_host *mmc)
> {
> 	struct sdhci_host *host;
> 	unsigned long flags;
> 	int present;
> 
> 	host = mmc_priv(mmc);
> 
> 	if (host->ops->get_ro)
> 		return host->ops->get_ro(host);
> 
> 	spin_lock_irqsave(&host->lock, flags);
> 
> <end snip>
> 
> What is the correct practice?  

I think that the get_ro hook is reasonable in this case -- we're saying
that the host has a sufficiently weird WP setup that sdhci doesn't know 
what we're supposed to do (unlike SDHCI_QUIRK_INVERTED_WRITE_PROTECT).

I'd be curious to hear what others think, though.  Should we be simply
moving away from adding new quirks, or just limiting them to cases where
a full hook isn't warranted?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
