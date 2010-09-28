From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: RE: [PATCH v2 2/2] sdhci-s3c: Add support no internal clock divider in
	host controller
Date: Tue, 28 Sep 2010 13:02:34 +0900
Message-ID: <006e01cb5ec1$fe00b770$fa022650$%seo@samsung.com>
References: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
 <1284716701-5140-3-git-send-email-kgene.kim@samsung.com>
 <4C97FB34.1000802@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12626 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0I1ECU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 00:02:20 -0400
In-reply-to: <4C97FB34.1000802@simtec.co.uk>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ben Dooks' <ben@simtec.co.uk>, 'Kukjin Kim' <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org

Ben Dooks worte:
> On 17/09/10 10:45, Kukjin Kim wrote:
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > This patch adds to support no internal clock divider in SDHCI.
> > The external clock divider can be used to make a proper clock
> > because SDHCI doesn't support internal clock divider by itself.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-s3c.c |   60
> ++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 60 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index e6e0438..5ad5ed7 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -96,6 +96,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct
> sdhci_host *host)
> >  	unsigned int rate, max;
> >  	int clk;
> >
> > +	/*
> > +	 * There is only one clock source(sclk) if there is no clock
> divider
> > +	 * in the host controller
> > +	 */
> > +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> > +		return clk_round_rate(ourhost->clk_bus[2], UINT_MAX);
> 
> interesting, <linux/clk.h> doesn't have a second parameter to
> clk_round_rate().
> 
Hi Ben,

Thanks for your comments.

When I see clk_round_rate in <linux/clk.h>, which function is defined 
as "long clk_round_rate(struct clk *clk, unsigned long rate)" that has two
parameters.
Please let me know if you have another meaning for this.

> 
> >  	/* note, a reset will reset the clock source */
> >
> >  	sdhci_s3c_check_sclk(host);
> > @@ -130,6 +137,15 @@ static unsigned int sdhci_s3c_consider_clock(struct
> sdhci_s3c *ourhost,
> >  	if (!clksrc)
> >  		return UINT_MAX;
> >
> > +	/*
> > +	 * There is only one clock source(sclk) if there is no clock
> divider
> > +	 * in the host controller
> > +	 */
> > +	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
> > +		rate = clk_round_rate(clksrc, wanted);
> > +		return wanted - rate;
> > +	}
> 
> Why does this need a quirk, instead of just having one clock available
> in the list of usable clocks?
> 

The available clock is made by dividing a clock source with a certain
divider value.
Most of the host controller has this capability that can divide a clock what
we want.
However, the host controller of both S5PC210 and S5PV310 don't have this so
we have to
Add additional routine to make a proper clock with outland clock divider
instead of
Internal clock divider in host controller.

Best Regards,
Jeongbae Seo


