From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5 v4] ESDHC: Fix DMA errors in kernel booting on P1010
Date: Fri, 06 Jan 2012 10:00:16 -0500
Message-ID: <m2ehvczxj3.fsf@bob.laptop.org>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
	<1325827997-27490-2-git-send-email-r66093@freescale.com>
	<1325827997-27490-3-git-send-email-r66093@freescale.com>
	<1325827997-27490-4-git-send-email-r66093@freescale.com>
	<1325827997-27490-5-git-send-email-r66093@freescale.com>
	<1325827997-27490-6-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43424 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030334Ab2AFPA1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Jan 2012 10:00:27 -0500
In-Reply-To: <1325827997-27490-6-git-send-email-r66093@freescale.com>
	(r66093@freescale.com's message of "Fri, 6 Jan 2012 13:33:17 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

Hi Jerry,

On Fri, Jan 06 2012, r66093@freescale.com wrote:
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2db0d5c..d5a2259 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -832,14 +832,29 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	 * is ADMA.
>  	 */
>  	if (host->version >= SDHCI_SPEC_200) {
> -		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -		ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -		if ((host->flags & SDHCI_REQ_USE_DMA) &&
> -			(host->flags & SDHCI_USE_ADMA))
> -			ctrl |= SDHCI_CTRL_ADMA32;
> -		else
> -			ctrl |= SDHCI_CTRL_SDMA;
> -		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +		if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD) {
> +#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
> +#define ESDHCI_PROCTL_ADMA32		0x00000200
> +#define ESDHCI_PROCTL_SDMA		0x00000000
> +			u32 ctrl;
> +			ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
> +			ctrl &= ~ESDHCI_PROCTL_DMAS_MASK;
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +				(host->flags & SDHCI_USE_ADMA))
> +				ctrl |= ESDHCI_PROCTL_ADMA32;
> +			else
> +				ctrl |= ESDHCI_PROCTL_SDMA;
> +			sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> +		} else {
> +			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +			ctrl &= ~SDHCI_CTRL_DMA_MASK;
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +				(host->flags & SDHCI_USE_ADMA))
> +				ctrl |= SDHCI_CTRL_ADMA32;
> +			else
> +				ctrl |= SDHCI_CTRL_SDMA;
> +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +		}

drivers/mmc/host/sdhci.c must know nothing about ESDHC registers.
It's a generic driver.  We can add hooks so that your own driver
can run code in the right place instead.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
