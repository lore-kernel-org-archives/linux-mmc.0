From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 4/4 v4] ESDHC: add callback esdhc_of_get_cd to detect card
Date: Sun, 18 Nov 2012 18:54:54 -0800
Message-ID: <20121119025454.GA5165@lizard>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <1351584769-16662-3-git-send-email-r66093@freescale.com>
 <1351584769-16662-4-git-send-email-r66093@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C224FA5@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60593 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab2KSC6F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 21:58:05 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so540632dak.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 18:58:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C224FA5@039-SN1MPN1-004.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 19, 2012 at 02:50:49AM +0000, Huang Changming-R66093 wrote:
[...]
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -179,6 +179,28 @@ static void esdhc_of_platform_init(struct sdhci_host
> > *host)
> >  		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> >  }
> > 
> > +/* Return: none zero - the card is presetn; 0 - card is absent */
> > +static int esdhc_of_get_cd(struct sdhci_host *host)
> > +{
> > +	int present;
> > +
> > +	if (host->flags & SDHCI_DEVICE_DEAD)
> > +		present = 0;

return 0;

> > +	else {

then you don't need the 'else', which reduces indentation level.

> > +		int sysctl = sdhci_be32bs_readl(host, SDHCI_CLOCK_CONTROL);

empty line is needed here.

> > +		/* Enable the controller clock to update the present state */
> > +		sdhci_be32bs_writel(host, sysctl | SDHCI_CLOCK_INT_EN,
> > +				SDHCI_CLOCK_CONTROL);

empty line for better readability.

> > +		/* Detect the card present or absent */
> > +		present = sdhci_be32bs_readl(host, SDHCI_PRESENT_STATE);
> > +		present &= (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL);

ditto here.

> > +		/* Resve the previous to System control register */
> > +		sdhci_be32bs_writel(host, sysctl, SDHCI_CLOCK_CONTROL);
> > +	}
> > +
> > +	return present;
> > +}
> > +
> >  static struct sdhci_ops sdhci_esdhc_ops = {
> >  	.read_l = esdhc_readl,
> >  	.read_w = esdhc_readw,
> > @@ -191,6 +213,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
> >  	.get_max_clock = esdhc_of_get_max_clock,
> >  	.get_min_clock = esdhc_of_get_min_clock,
> >  	.platform_init = esdhc_of_platform_init,
> > +	.get_cd = esdhc_of_get_cd,
> >  #ifdef CONFIG_PM
> >  	.platform_suspend = esdhc_of_suspend,
> >  	.platform_resume = esdhc_of_resume,
> > --
> > 1.7.9.5

Otherwise, it looks good to me.

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
