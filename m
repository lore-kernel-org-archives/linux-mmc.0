From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] mmc: sdhci: work around broken dma boundary behavior
Date: Mon, 11 Apr 2011 17:05:12 -0400
Message-ID: <m3tye4a48n.fsf@pullcord.laptop.org>
References: <20110314172129.GA20654@pengutronix.de>
	<1301388814-10931-1-git-send-email-mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43770 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239Ab1DKVAa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Apr 2011 17:00:30 -0400
In-Reply-To: <1301388814-10931-1-git-send-email-mmvinni@yahoo.com> (Mikko
	Vinni's message of "Tue, 29 Mar 2011 11:53:34 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Wolfram,

On Tue, Mar 29 2011, Mikko Vinni wrote:
> In my opinion this is more risky than the original patch because this
> will affect the behavior on all controllers that use sdhci, and not
> just on those ones that don't update SDHCI_DMA_ADDRESS themselves.
> Comments welcome!

Any thoughts on which of the two approaches you prefer?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
