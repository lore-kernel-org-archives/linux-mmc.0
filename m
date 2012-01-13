From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH][upstream] eSDHC: fix errors when booting kernel on
 Freescale eSDHC version 2.3
Date: Fri, 13 Jan 2012 15:47:41 +0400
Message-ID: <20120113114741.GA8837@oksana.dev.rtsoft.ru>
References: <1326438121-26732-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57154 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757840Ab2AMLrq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 06:47:46 -0500
Received: by bkvi17 with SMTP id i17so1964595bkv.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2012 03:47:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326438121-26732-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Lei Xu <B33228@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

On Fri, Jan 13, 2012 at 03:02:01PM +0800, Roy Zang wrote:
[...]
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 01e5f62..36caad3 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -38,6 +38,22 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
>  	int base = reg & ~0x3;
>  	int shift = (reg & 0x3) * 8;
>  	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
> +
> +	/*
> +	 * "DMA select" locates at offset 0x28 in SD specification, but on
> +	 * P5020 or P3041, it locates at 0x29.
> +	 */
> +	if (reg == SDHCI_HOST_CONTROL) {
> +		u32 dma_bits;

Just a small nit: per coding style, here should be empty line.

> +		dma_bits = in_be32(host->ioaddr + reg);
> +		/* DMA select is 22,23 bits in Protocol Control Register*/
> +		dma_bits = (dma_bits >> 5) & SDHCI_CTRL_DMA_MASK;
> +
> +		/* fixup the result */
> +		ret &= ~SDHCI_CTRL_DMA_MASK;
> +		ret |= dma_bits;
> +	}
> +
>  	return ret;
>  }
>  
> @@ -56,6 +72,20 @@ static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
>  
>  static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
>  {
> +	/*
> +	 * "DMA select" locates at offset 0x28 in SD specification, but on
> +	 * P5020 or P3041, it locates at 0x29.
> +	 */
> +	if (reg == SDHCI_HOST_CONTROL) {
> +		u32 dma_bits;

Ditto. Empty line here.

> +		/* DMA select is 22,23 bits in Protocol Control Register*/
> +		dma_bits = (val & SDHCI_CTRL_DMA_MASK) << 5;
> +		clrsetbits_be32(host->ioaddr + reg , SDHCI_CTRL_DMA_MASK << 5,
> +			dma_bits);
> +		val &= ~SDHCI_CTRL_DMA_MASK;
> +		val |= (in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK);

No need for the outer parentheses.

Otherwise the patch looks perfect.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
