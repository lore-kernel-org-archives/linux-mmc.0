From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec
 3.0
Date: Mon, 16 Aug 2010 19:27:10 +0100
Message-ID: <20100816182710.GA6338@console-pimps.org>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
 <4C696233.6000408@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:49547 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488Ab0HPS1M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 14:27:12 -0400
Content-Disposition: inline
In-Reply-To: <4C696233.6000408@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Aug 16, 2010 at 05:07:15PM +0100, David Vrabel wrote:
> zhangfei gao wrote:
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 913555e..32dcac9 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> [...]
> > @@ -1001,13 +1001,23 @@ static void sdhci_set_clock(struct sdhci_host
> > *host, unsigned int clock)
> >  	if (clock == 0)
> >  		goto out;
> > 
> > -	for (div = 1;div < 256;div *= 2) {
> > -		if ((host->max_clk / div) <= clock)
> > -			break;
> > +	if (host->version >= SDHCI_SPEC_300)
> > +		max_div = 2046;
> > +	else
> > +		max_div = 256;
> > +
> > +	if(host->max_clk <= clock)
> > +		div = 1;
> > +	else {
> > +		for (div = 2; div < max_div; div += 2) {
> > +			if ((host->max_clk / div) <= clock)
> > +				break;
> > +		}
> 
> This isn't correct.  The divisor must be a power of two for 2.00
> controllers.

Sorry, I did mean to reply to this sooner but I've been travelling. Yeah
David, you're right. Zhangfei, have you confused the Programmable Clock
Mode in the 3.00 spec here with 10-bit Divided Clock Mode?

Both 8-bit Divided Clock Mode and 10-bit Divided Clock Mode require the
divisor to be a power of two. Support for Programmable Clock Mode would
require a bit more work because not all clock multiplier values are
valid. Support for that should be done as a separate patch.
