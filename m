From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048
	with a pklatform hook.
Date: Mon, 7 Feb 2011 17:54:24 +0000
Message-ID: <20110207175424.GA2065@void.printf.net>
References: <m31v3lofm1.fsf@pullcord.laptop.org> <20110207174039.GE3123@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45423 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070Ab1BGRyZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Feb 2011 12:54:25 -0500
Content-Disposition: inline
In-Reply-To: <20110207174039.GE3123@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi Wolfram, thanks for the review,

On Mon, Feb 07, 2011 at 06:40:39PM +0100, Wolfram Sang wrote:
> On Sun, Feb 06, 2011 at 01:13:10AM -0500, Chris Ball wrote:
> > Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
> > This patch is untested.
> > 
> > Signed-off-by: Chris Ball <cjb@laptop.org>
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 9e15f41..fcd6188 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1962,8 +1962,8 @@ int sdhci_add_host(struct sdhci_host *host)
> >  	 * Maximum block size. This varies from controller to controller and
> >  	 * is specified in the capabilities register.
> >  	 */
> > -	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> > -		mmc->max_blk_size = 2;
> > +	if (host->ops->get_max_blk_size) {
> > +		mmc->max_blk_size = host->ops->get_max_blk_size(host);
> >  	} else {
> >  		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
> >  				SDHCI_MAX_BLOCK_SHIFT;
> 
> I tend to think this could be fixed using io-accessors when reading the
> caps register?

Hm, I agree that it would work, but I'm not sure it's going to be
cleaner/more readable that way.  I like that here we have one place
for setting the max_blk_size, and it's obvious from the code exactly
where you need to look to see if it's been overloaded by the driver.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
