From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 5/5 v4] ESDHC: Fix DMA errors in kernel booting on P1010
Date: Mon, 9 Jan 2012 02:59:15 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11662AC5@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
	<1325827997-27490-2-git-send-email-r66093@freescale.com>
	<1325827997-27490-3-git-send-email-r66093@freescale.com>
	<1325827997-27490-4-git-send-email-r66093@freescale.com>
	<1325827997-27490-5-git-send-email-r66093@freescale.com>
	<1325827997-27490-6-git-send-email-r66093@freescale.com>
 <m2ehvczxj3.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:55496
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861Ab2AIC7x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 8 Jan 2012 21:59:53 -0500
In-Reply-To: <m2ehvczxj3.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Friday, January 06, 2012 11:00 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Jain Priyanka-
> B32167
> Subject: Re: [PATCH 5/5 v4] ESDHC: Fix DMA errors in kernel booting on
> P1010
> 
> Hi Jerry,
> 
> On Fri, Jan 06 2012, r66093@freescale.com wrote:
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 2db0d5c..d5a2259 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -832,14 +832,29 @@ static void sdhci_prepare_data(struct sdhci_host
> *host, struct mmc_command *cmd)
> >  	 * is ADMA.
> >  	 */
> >  	if (host->version >= SDHCI_SPEC_200) {
> > -		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > -		ctrl &= ~SDHCI_CTRL_DMA_MASK;
> > -		if ((host->flags & SDHCI_REQ_USE_DMA) &&
> > -			(host->flags & SDHCI_USE_ADMA))
> > -			ctrl |= SDHCI_CTRL_ADMA32;
> > -		else
> > -			ctrl |= SDHCI_CTRL_SDMA;
> > -		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > +		if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD) {
> > +#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
> > +#define ESDHCI_PROCTL_ADMA32		0x00000200
> > +#define ESDHCI_PROCTL_SDMA		0x00000000
> > +			u32 ctrl;
> > +			ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
> > +			ctrl &= ~ESDHCI_PROCTL_DMAS_MASK;
> > +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> > +				(host->flags & SDHCI_USE_ADMA))
> > +				ctrl |= ESDHCI_PROCTL_ADMA32;
> > +			else
> > +				ctrl |= ESDHCI_PROCTL_SDMA;
> > +			sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> > +		} else {
> > +			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > +			ctrl &= ~SDHCI_CTRL_DMA_MASK;
> > +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> > +				(host->flags & SDHCI_USE_ADMA))
> > +				ctrl |= SDHCI_CTRL_ADMA32;
> > +			else
> > +				ctrl |= SDHCI_CTRL_SDMA;
> > +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > +		}
> 
> drivers/mmc/host/sdhci.c must know nothing about ESDHC registers.
> It's a generic driver.  We can add hooks so that your own driver can run
> code in the right place instead.
> 
Hi, Chris,
For the PROCTL register, the FSL ESDHC controller has different bit setting.
So I just redefined the related bit for this register.
I have thought about it, but I didn't find the better way to implement it.
If use the hook, but, how to handle the bit setting for SDHCI_POWER_CONTROL?

