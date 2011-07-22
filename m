From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
 esdhc
Date: Fri, 22 Jul 2011 14:15:12 +0400
Message-ID: <20110722101512.GA1576@oksana.dev.rtsoft.ru>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
 <1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54383 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab1GVKPS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2011 06:15:18 -0400
Received: by wyg8 with SMTP id 8so1389826wyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jul 2011 03:15:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, Xu lei <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

On Fri, Jul 22, 2011 at 06:15:17PM +0800, Roy Zang wrote:
[...]
>  	if (host->version >= SDHCI_SPEC_200) {
> -		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -		ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -		if ((host->flags & SDHCI_REQ_USE_DMA) &&
> -			(host->flags & SDHCI_USE_ADMA))
> -			ctrl |= SDHCI_CTRL_ADMA32;
> -		else
> -			ctrl |= SDHCI_CTRL_SDMA;
> -		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +		if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD) {
> +#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
> +#define ESDHCI_PROCTL_ADMA32		0x00000200
> +#define ESDHCI_PROCTL_SDMA		0x00000000
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

We try to not pollute generic sdhci.c driver with chip-specific
quirks.

Maybe you can do the fixups via IO accessors? Or by introducing
some additional sdhci op?

[...]
>  	if (power != (unsigned short)-1) {
>  		switch (1 << power) {
> +#define	ESDHCI_FSL_POWER_MASK	0x40
> +#define	ESDHCI_FSL_POWER_180	0x00
> +#define	ESDHCI_FSL_POWER_300	0x40

Same here. The driver will rot quickly if everyone would start
putting chip-specific quirks into sdhci.c. Please don't.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
