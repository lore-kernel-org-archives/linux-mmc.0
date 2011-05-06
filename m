From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/7] mmc: sdhci: make sdhci-of device drivers self
 registered
Date: Fri, 6 May 2011 10:15:05 +0800
Message-ID: <20110506021504.GA21667@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-4-git-send-email-shawn.guo@linaro.org>
 <20110505142344.GA13400@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:40925
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878Ab1EFCLV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 22:11:21 -0400
Content-Disposition: inline
In-Reply-To: <20110505142344.GA13400@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

On Thu, May 05, 2011 at 06:23:44PM +0400, Anton Vorontsov wrote:
> On Thu, May 05, 2011 at 09:22:54PM +0800, Shawn Guo wrote:
> [...]
> > - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> > - * Copyright (c) 2009 MontaVista Software, Inc.
> > - *
> > - * Authors: Xiaobo Xie <X.Xie@freescale.com>
> > - *	    Anton Vorontsov <avorontsov@ru.mvista.com>
> [...]
> > -#ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> > -
> > -/*
> > - * These accessors are designed for big endian hosts doing I/O to
> > - * little endian controllers incorporating a 32-bit hardware byte swapper.
> > - */
> > -
> > -u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
> > -{
> > -	return in_be32(host->ioaddr + reg);
> > -}
> > -
> > -u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
> > -{
> > -	return in_be16(host->ioaddr + (reg ^ 0x2));
> > -}
> > -
> > -u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
> > -{
> > -	return in_8(host->ioaddr + (reg ^ 0x3));
> > -}
> > -
> > -void sdhci_be32bs_writel(struct sdhci_host *host, u32 val, int reg)
> > -{
> > -	out_be32(host->ioaddr + reg, val);
> > -}
> > -
> > -void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg)
> > -{
> > -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -	int base = reg & ~0x3;
> > -	int shift = (reg & 0x2) * 8;
> > -
> > -	switch (reg) {
> > -	case SDHCI_TRANSFER_MODE:
> > -		/*
> > -		 * Postpone this write, we must do it together with a
> > -		 * command write that is down below.
> > -		 */
> > -		pltfm_host->xfer_mode_shadow = val;
> > -		return;
> > -	case SDHCI_COMMAND:
> > -		sdhci_be32bs_writel(host, val << 16 | pltfm_host->xfer_mode_shadow,
> > -				    SDHCI_TRANSFER_MODE);
> > -		return;
> > -	}
> > -	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
> > -}
> > -
> > -void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
> > -{
> > -	int base = reg & ~0x3;
> > -	int shift = (reg & 0x3) * 8;
> > -
> > -	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
> > -}
> > -#endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
> [...]
> > +#ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> > +/*
> > + * These accessors are designed for big endian hosts doing I/O to
> > + * little endian controllers incorporating a 32-bit hardware byte swapper.
> > + */
> > +u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
> > +{
> > +	return in_be32(host->ioaddr + reg);
> > +}
> > +
> > +u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
> > +{
> > +	return in_be16(host->ioaddr + (reg ^ 0x2));
> > +}
> > +
> > +u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
> > +{
> > +	return in_8(host->ioaddr + (reg ^ 0x3));
> > +}
> > +
> > +void sdhci_be32bs_writel(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +	out_be32(host->ioaddr + reg, val);
> > +}
> > +
> > +void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	int base = reg & ~0x3;
> > +	int shift = (reg & 0x2) * 8;
> > +
> > +	switch (reg) {
> > +	case SDHCI_TRANSFER_MODE:
> > +		/*
> > +		 * Postpone this write, we must do it together with a
> > +		 * command write that is down below.
> > +		 */
> > +		pltfm_host->xfer_mode_shadow = val;
> > +		return;
> > +	case SDHCI_COMMAND:
> > +		sdhci_be32bs_writel(host, val << 16 | pltfm_host->xfer_mode_shadow,
> > +				    SDHCI_TRANSFER_MODE);
> > +		return;
> > +	}
> > +	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
> > +}
> > +
> > +void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
> > +{
> > +	int base = reg & ~0x3;
> > +	int shift = (reg & 0x3) * 8;
> > +
> > +	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
> > +}
> > +#endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
> 
> I noticed you're very careful wrt copyright/authorship notices,
> except for this case. How about retaining copyright stuff when
> you merge these two files?
> 
Obviously, need to be more careful.  Will add.  Thanks.

-- 
Regards,
Shawn

