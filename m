From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 4/5 v4] ESDHC: Workaround for data crc error on p1010rdb
Date: Fri, 13 Jan 2012 16:12:31 +0400
Message-ID: <20120113121231.GE8837@oksana.dev.rtsoft.ru>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <1325827997-27490-3-git-send-email-r66093@freescale.com>
 <1325827997-27490-4-git-send-email-r66093@freescale.com>
 <1325827997-27490-5-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11669381@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65243 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab2AMMMf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 07:12:35 -0500
Received: by bkvi17 with SMTP id i17so1980108bkv.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2012 04:12:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11669381@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Jan 13, 2012 at 02:37:07AM +0000, Huang Changming-R66093 wrote:
> Hi, Anton,
> Could you have any comment about this serial patch?
> 
> Thanks
> Jerry Huang
> 
[...]
> > @@ -56,6 +56,13 @@ static inline void esdhc_set_clock(struct sdhci_host
> > *host, unsigned int clock)
> >  	if (clock == 0)
> >  		goto out;
> > 
> > +	if (host->quirks2 & SDHCI_QUIRK2_RELAX_FREQ) {
> > +		if (clock > 20000000)
> > +			clock -= 5000000;
> > +		if (clock > 40000000)
> > +			clock -= 5000000;
> > +	}
> > +

That's weird. According to the code, you are underclocking a device
(i.e. the card actually expects higher clocks).

Did you check (with an oscilloscope) what clocks HW actually generates?
Maybe it just generates higher than expected clocks, then this code
would be a correct workaround.

Otherwise, if HW generates correct/precise clock, then you probably
would rather not permit high clocks at all... but then you limit max
freq to 20 MHz. :-(

Oh well, if the patch works for your HW, I'm fine with it.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

> >  	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> >  		pre_div *= 2;
> > 
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> > pltfm.c
> > index e64f773..841ffc1 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -79,6 +79,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
> >  			|| of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> >  			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > 
> > +		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
> > +			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
> > +
> >  		clk = of_get_property(np, "clock-frequency", &size);
> >  		if (clk && size == sizeof(*clk) && *clk)
> >  			pltfm_host->clock = be32_to_cpup(clk);
> > diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> > index e4b6935..f7c1e13 100644
> > --- a/include/linux/mmc/sdhci.h
> > +++ b/include/linux/mmc/sdhci.h
> > @@ -91,6 +91,8 @@ struct sdhci_host {
> >  	unsigned int quirks2;	/* More deviations from spec. */
> > 
> >  #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
> > +/* Controller operates the cards at reduced frequency */
> > +#define SDHCI_QUIRK2_RELAX_FREQ				(1<<1)
> > 
> >  	int irq;		/* Device IRQ */
> >  	void __iomem *ioaddr;	/* Mapped address */
> > --
> > 1.7.5.4
> 
> 

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
