From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: esdhc: add eSDHC little-endian mode support
Date: Wed, 8 Apr 2015 11:35:15 +0200
Message-ID: <CAPDyKFoDP0XxaYXuppEViY9WVZ6HLNUC-=g_ofK6NumkVOr21w@mail.gmail.com>
References: <1427514168-6372-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34276 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbbDHJfQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 05:35:16 -0400
Received: by qkgx75 with SMTP id x75so78572578qkg.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2015 02:35:15 -0700 (PDT)
In-Reply-To: <1427514168-6372-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 28 March 2015 at 04:42, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> This patch is to support little-endian mode for ARM
> eSDHC that has the same IP block with PowerPC but has
> different endian mode.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

I would suggest you to split this patch into a few pieces. The common
part in sdhci-pltfm, then one for sdhci-of-esdhc and on for
sdhci-of-hlwd.

In case you _really_ need to change all files in one patch, please
update the commit message header to explain that.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 105 +++++++++++++++++++++++++-------------
>  drivers/mmc/host/sdhci-of-hlwd.c  |  12 ++---
>  drivers/mmc/host/sdhci-pltfm.c    |  12 ++++-
>  drivers/mmc/host/sdhci-pltfm.h    |  74 +++++++++++++++++++--------
>  4 files changed, 139 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 17fe02e..a39b789 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -28,7 +28,7 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
>  {
>         u32 ret;
>
> -       ret = in_be32(host->ioaddr + reg);
> +       ret = sdhci_32bs_readl(host, reg);
>         /*
>          * The bit of ADMA flag in eSDHC is not compatible with standard
>          * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
> @@ -40,7 +40,7 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
>          * the verdor version number, oxFE is SDHCI_HOST_VERSION.
>          */
>         if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
> -               u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +               u32 tmp = sdhci_32bs_readl(host, SDHCI_SLOT_INT_STATUS);
>                 tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>                 if (tmp > VENDOR_V_22)
>                         ret |= SDHCI_CAN_DO_ADMA2;
> @@ -56,9 +56,9 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
>         int shift = (reg & 0x2) * 8;
>
>         if (unlikely(reg == SDHCI_HOST_VERSION))
> -               ret = in_be32(host->ioaddr + base) & 0xffff;
> +               ret = sdhci_32bs_readl(host, base) & 0xffff;
>         else
> -               ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
> +               ret = (sdhci_32bs_readl(host, base) >> shift) & 0xffff;
>         return ret;
>  }
>
> @@ -66,7 +66,10 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
>  {
>         int base = reg & ~0x3;
>         int shift = (reg & 0x3) * 8;
> -       u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
> +       u32 ret;
> +       u8 val;
> +
> +       ret = sdhci_32bs_readl(host, base);
>
>         /*
>          * "DMA select" locates at offset 0x28 in SD specification, but on
> @@ -75,16 +78,18 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
>         if (reg == SDHCI_HOST_CONTROL) {
>                 u32 dma_bits;
>
> -               dma_bits = in_be32(host->ioaddr + reg);
>                 /* DMA select is 22,23 bits in Protocol Control Register */
> -               dma_bits = (dma_bits >> 5) & SDHCI_CTRL_DMA_MASK;
> +               dma_bits = (ret >> 5) & SDHCI_CTRL_DMA_MASK;
>
>                 /* fixup the result */
>                 ret &= ~SDHCI_CTRL_DMA_MASK;
>                 ret |= dma_bits;
> +               val = (ret & 0xff);
>         }
>
> -       return ret;
> +       val = (ret >> shift) & 0xff;
> +
> +       return val;
>  }
>
>  static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
> @@ -96,11 +101,28 @@ static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
>          */
>         if (reg == SDHCI_INT_ENABLE)
>                 val |= SDHCI_INT_BLK_GAP;
> -       sdhci_be32bs_writel(host, val, reg);
> +       sdhci_32bs_writel(host, val, reg);
>  }
>
>  static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
>  {
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       switch (reg) {
> +       case SDHCI_TRANSFER_MODE:
> +               /*
> +                * Postpone this write, we must do it together with a
> +                * command write that is down below.
> +                */
> +               pltfm_host->xfer_mode_shadow = val;
> +               return;
> +       case SDHCI_COMMAND:
> +               sdhci_32bs_writel(host, val << 16 |
> +                                 pltfm_host->xfer_mode_shadow,
> +                                 SDHCI_TRANSFER_MODE);
> +               return;
> +       }
> +
>         if (reg == SDHCI_BLOCK_SIZE) {
>                 /*
>                  * Two last DMA bits are reserved, and first one is used for
> @@ -109,7 +131,7 @@ static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
>                  */
>                 val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
>         }
> -       sdhci_be32bs_writew(host, val, reg);
> +       sdhci_clrsetbits(host, 0xffff, val, reg);
>  }
>
>  static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
> @@ -130,16 +152,16 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
>
>                 /* DMA select is 22,23 bits in Protocol Control Register */
>                 dma_bits = (val & SDHCI_CTRL_DMA_MASK) << 5;
> -               clrsetbits_be32(host->ioaddr + reg , SDHCI_CTRL_DMA_MASK << 5,
> -                       dma_bits);
> +               sdhci_clrsetbits(host, SDHCI_CTRL_DMA_MASK << 5, dma_bits,
> +                                SDHCI_HOST_CONTROL);
>                 val &= ~SDHCI_CTRL_DMA_MASK;
> -               val |= in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK;
> +               val |= sdhci_32bs_readl(host, reg) & SDHCI_CTRL_DMA_MASK;
>         }
>
>         /* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
>         if (reg == SDHCI_HOST_CONTROL)
>                 val &= ~ESDHC_HOST_CONTROL_RES;
> -       sdhci_be32bs_writeb(host, val, reg);
> +       sdhci_clrsetbits(host, 0xff, val, reg);
>  }
>
>  /*
> @@ -156,7 +178,7 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>         dma_addr_t dmastart;
>         dma_addr_t dmanow;
>
> -       tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +       tmp = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
>         tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>
>         applicable = (intmask & SDHCI_INT_DATA_END) &&
> @@ -174,12 +196,13 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>         dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
>                 SDHCI_DEFAULT_BOUNDARY_SIZE;
>         host->data->bytes_xfered = dmanow - dmastart;
> -       sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +       esdhc_writel(host, dmanow, SDHCI_DMA_ADDRESS);
>  }
>
>  static int esdhc_of_enable_dma(struct sdhci_host *host)
>  {
> -       setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
> +       esdhc_writel(host, esdhc_readl(host, ESDHC_DMA_SYSCTL)
> +                       | ESDHC_DMA_SNOOP, ESDHC_DMA_SYSCTL);
>         return 0;
>  }
>
> @@ -245,7 +268,7 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
>  {
>         u32 vvn;
>
> -       vvn = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +       vvn = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
>         vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>         if (vvn == VENDOR_V_22)
>                 host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> @@ -272,8 +295,8 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>                 break;
>         }
>
> -       clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
> -                       ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
> +       sdhci_clrsetbits(host, ESDHC_CTRL_BUSWIDTH_MASK, ctrl,
> +                        SDHCI_HOST_CONTROL);
>  }
>
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
> @@ -309,7 +332,7 @@ static int esdhc_of_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>
> -       esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
> +       esdhc_proctl = esdhc_readl(host, SDHCI_HOST_CONTROL);
>
>         return sdhci_suspend_host(host);
>  }
> @@ -322,7 +345,7 @@ static int esdhc_of_resume(struct device *dev)
>         if (ret == 0) {
>                 /* Isn't this already done by sdhci_resume_host() ? --rmk */
>                 esdhc_of_enable_dma(host);
> -               sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
> +               esdhc_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
>         }
>
>         return ret;
> @@ -348,19 +371,18 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
>         .ops = &sdhci_esdhc_ops,
>  };
>
> -static int sdhci_esdhc_probe(struct platform_device *pdev)
> +static void esdhc_get_property(struct platform_device *pdev)
>  {
> -       struct sdhci_host *host;
> -       struct device_node *np;
> -       int ret;
> -
> -       host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
> -       if (IS_ERR(host))
> -               return PTR_ERR(host);
> +       struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
>         sdhci_get_of_property(pdev);
>
> -       np = pdev->dev.of_node;
> +       /* call to generic mmc_of_parse to support additional capabilities */
> +       mmc_of_parse(host->mmc);
> +       mmc_of_parse_voltage(np, &host->ocr_mask);
> +
>         if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
>                 /*
>                  * Freescale messed up with P2020 as it has a non-standard
> @@ -369,13 +391,24 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>                 host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
>         }
>
> -       /* call to generic mmc_of_parse to support additional capabilities */
> -       ret = mmc_of_parse(host->mmc);
> -       if (ret)
> -               goto err;
> +       if (!pltfm_host->clock) {
> +               pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> +               pltfm_host->clock = clk_get_rate(pltfm_host->clk);
> +               clk_prepare_enable(pltfm_host->clk);
> +       }
> +}
>
> -       mmc_of_parse_voltage(np, &host->ocr_mask);
> +static int sdhci_esdhc_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       int ret;
> +
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
>
> +       esdhc_get_property(pdev);
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto err;
> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
> index be47927..9384c2a 100644
> --- a/drivers/mmc/host/sdhci-of-hlwd.c
> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
> @@ -35,26 +35,26 @@
>
>  static void sdhci_hlwd_writel(struct sdhci_host *host, u32 val, int reg)
>  {
> -       sdhci_be32bs_writel(host, val, reg);
> +       sdhci_32bs_writel(host, val, reg);
>         udelay(SDHCI_HLWD_WRITE_DELAY);
>  }
>
>  static void sdhci_hlwd_writew(struct sdhci_host *host, u16 val, int reg)
>  {
> -       sdhci_be32bs_writew(host, val, reg);
> +       sdhci_32bs_writew(host, val, reg);
>         udelay(SDHCI_HLWD_WRITE_DELAY);
>  }
>
>  static void sdhci_hlwd_writeb(struct sdhci_host *host, u8 val, int reg)
>  {
> -       sdhci_be32bs_writeb(host, val, reg);
> +       sdhci_32bs_writeb(host, val, reg);
>         udelay(SDHCI_HLWD_WRITE_DELAY);
>  }
>
>  static const struct sdhci_ops sdhci_hlwd_ops = {
> -       .read_l = sdhci_be32bs_readl,
> -       .read_w = sdhci_be32bs_readw,
> -       .read_b = sdhci_be32bs_readb,
> +       .read_l = sdhci_32bs_readl,
> +       .read_w = sdhci_32bs_readw,
> +       .read_b = sdhci_32bs_readb,
>         .write_l = sdhci_hlwd_writel,
>         .write_w = sdhci_hlwd_writew,
>         .write_b = sdhci_hlwd_writeb,
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index c5b01d6..781f90f 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -123,6 +123,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     size_t priv_size)
>  {
>         struct sdhci_host *host;
> +       struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_pltfm_host *pltfm_host;
>         struct resource *iomem;
>         int ret;
>
> @@ -143,6 +145,14 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                 goto err;
>         }
>
> +       pltfm_host = sdhci_priv(host);
> +       pltfm_host->endian_mode = BIG_ENDIAN_MODE;
> +
> +#ifdef CONFIG_OF
> +       if (of_get_property(np, "little-endian", NULL))
> +               pltfm_host->endian_mode = LITTLE_ENDIAN_MODE;
> +#endif /* CONFIG_OF */
> +
>         host->hw_name = dev_name(&pdev->dev);
>         if (pdata && pdata->ops)
>                 host->ops = pdata->ops;
> @@ -225,7 +235,7 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
>  int sdhci_pltfm_unregister(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> -       int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
> +       int dead = (sdhci_readl(host, SDHCI_INT_STATUS) == 0xffffffff);
>
>         sdhci_remove_host(host, dead);
>         sdhci_pltfm_free(pdev);
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 04bc248..a8cf954 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -28,6 +28,10 @@ struct sdhci_pltfm_host {
>         /* migrate from sdhci_of_host */
>         unsigned int clock;
>         u16 xfer_mode_shadow;
> +       enum endian_mode {
> +               LITTLE_ENDIAN_MODE,
> +               BIG_ENDIAN_MODE,
> +       } endian_mode;
>
>         unsigned long private[0] ____cacheline_aligned;
>  };
> @@ -37,33 +41,61 @@ struct sdhci_pltfm_host {
>   * These accessors are designed for big endian hosts doing I/O to
>   * little endian controllers incorporating a 32-bit hardware byte swapper.
>   */
> -static inline u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
> +static inline void sdhci_clrsetbits(struct sdhci_host *host, u32 mask,
> +                                   u32 val, int reg)
>  {
> -       return in_be32(host->ioaddr + reg);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       void __iomem *base = host->ioaddr + (reg & ~0x3);
> +       u32 shift = (reg & 0x3) * 8;
> +
> +       if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
> +               iowrite32be(((ioread32be(base) & ~(mask << shift)) |
> +                           (val << shift)), base);
> +       else
> +               iowrite32(((ioread32(base) & ~(mask << shift)) |
> +                         (val << shift)), base);
>  }
>
> -static inline u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
> +static inline u32 sdhci_32bs_readl(struct sdhci_host *host, int reg)
>  {
> -       return in_be16(host->ioaddr + (reg ^ 0x2));
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
> +               return ioread32be(host->ioaddr + reg);
> +       else
> +               return ioread32(host->ioaddr + reg);
>  }
>
> -static inline u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
> +static inline u16 sdhci_32bs_readw(struct sdhci_host *host, int reg)
>  {
> -       return in_8(host->ioaddr + (reg ^ 0x3));
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
> +               return ioread16be(host->ioaddr + (reg ^ 0x2));
> +       else
> +               return ioread16(host->ioaddr + (reg ^ 0x2));
>  }
>
> -static inline void sdhci_be32bs_writel(struct sdhci_host *host,
> -                                      u32 val, int reg)
> +static inline u8 sdhci_32bs_readb(struct sdhci_host *host, int reg)
>  {
> -       out_be32(host->ioaddr + reg, val);
> +       return ioread8(host->ioaddr + (reg ^ 0x3));
>  }
>
> -static inline void sdhci_be32bs_writew(struct sdhci_host *host,
> +static inline void sdhci_32bs_writel(struct sdhci_host *host,
> +               u32 val, int reg)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
> +               iowrite32be(val, host->ioaddr + reg);
> +       else
> +               iowrite32(val, host->ioaddr + reg);
> +}
> +
> +static inline void sdhci_32bs_writew(struct sdhci_host *host,
>                                        u16 val, int reg)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       int base = reg & ~0x3;
> -       int shift = (reg & 0x2) * 8;
>
>         switch (reg) {
>         case SDHCI_TRANSFER_MODE:
> @@ -74,20 +106,20 @@ static inline void sdhci_be32bs_writew(struct sdhci_host *host,
>                 pltfm_host->xfer_mode_shadow = val;
>                 return;
>         case SDHCI_COMMAND:
> -               sdhci_be32bs_writel(host,
> -                                   val << 16 | pltfm_host->xfer_mode_shadow,
> -                                   SDHCI_TRANSFER_MODE);
> +               if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
> +                       iowrite32be(val << 16 | pltfm_host->xfer_mode_shadow,
> +                                   host->ioaddr + SDHCI_TRANSFER_MODE);
> +               else
> +                       iowrite32(val << 16 | pltfm_host->xfer_mode_shadow,
> +                                 host->ioaddr + SDHCI_TRANSFER_MODE);
>                 return;
>         }
> -       clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
> +       sdhci_clrsetbits(host, 0xffff, val, reg);
>  }
>
> -static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
> +static inline void sdhci_32bs_writeb(struct sdhci_host *host, u8 val, int reg)
>  {
> -       int base = reg & ~0x3;
> -       int shift = (reg & 0x3) * 8;
> -
> -       clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
> +       sdhci_clrsetbits(host, 0xff, val, reg);
>  }
>  #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
>
> --
> 2.1.0.27.g96db324
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
