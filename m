From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [v3, 2/6] mmc: sdhci-pltfm: support both LE and BE mode for SDHCI platform
Date: Fri, 08 May 2015 09:40:42 +0200
Message-ID: <2093374.CPZJl41Uyy@wuerfel>
References: <1431067818-41378-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49736 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbEHHky (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 03:40:54 -0400
In-Reply-To: <1431067818-41378-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org

On Friday 08 May 2015 14:50:18 Yangbo Lu wrote:
> -static inline u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
> +static inline void sdhci_clrsetbits(struct sdhci_host *host, u32 mask,
> +                                   u32 val, int reg)
>  {
> -       return in_be32(host->ioaddr + reg);
> +       void __iomem *base = host->ioaddr + (reg & ~0x3);
> +       u32 shift = (reg & 0x3) * 8;
> +
> +       if (host->mmc->big_endian_mode)
> +               iowrite32be(((ioread32be(base) & ~(mask << shift)) |
> +                           (val << shift)), base);
> +       else
> +               iowrite32(((ioread32(base) & ~(mask << shift)) |
> +                         (val << shift)), base);
>  }
>  
> 

I think it would be better to use function pointers that are assigned at probe
time than run-time checks here.

Have a look at drivers/mmc/host/sdhci-of-hlwd.c:

static const struct sdhci_ops sdhci_hlwd_ops = {
        .read_l = sdhci_be32bs_readl,
        .read_w = sdhci_be32bs_readw,
        .read_b = sdhci_be32bs_readb,
        .write_l = sdhci_hlwd_writel,
        .write_w = sdhci_hlwd_writew,
        .write_b = sdhci_hlwd_writeb,
        .set_clock = sdhci_set_clock,
        .set_bus_width = sdhci_set_bus_width,
        .reset = sdhci_reset,
        .set_uhs_signaling = sdhci_set_uhs_signaling,
};


You can copy this method into your own driver.

	Arnd
