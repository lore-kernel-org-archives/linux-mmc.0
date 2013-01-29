From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Add a common clk API based
 implementation of get_timeout_clock
Date: Tue, 29 Jan 2013 17:06:10 +0800
Message-ID: <CADz5_gKkE7PCGEoGY1cn1q7SCqfwDWVNXUC-4C1KhvaAds0dZg@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B059D3F2@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:51237 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab3A2JGL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 04:06:11 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so183332obq.7
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jan 2013 01:06:10 -0800 (PST)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C08B059D3F2@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Tuesday, January 29, 2013 2:27 AM
> To: Chris Ball
> Cc: Stephen Warren; Shawn Guo; Zhangfei Gao; Kevin Liu; linux-mmc@vger.kernel.org; Lars-Peter Clausen
> Subject: [PATCH] mmc: sdhci-pltfm: Add a common clk API based implementation of get_timeout_clock
>
> Quite a few drivers have a implementation of the get_timeout_clock callback
> which simply returns the result of clk_get_rate on devices clock. This patch
> adds a common implementation of this to the sdhci-pltfm module and replaces all
> custom implementations with the common one.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I've only runtime tested this patch on a platform which is not yet upstream. For
> the drivers which are modified in this patch I've only done compile time
> testing. But I think all changes, but maybe the bcm2835 one, are straight
> forward.
> ---
>  drivers/mmc/host/sdhci-bcm2835.c   | 27 +++++----------------------
>  drivers/mmc/host/sdhci-esdhc-imx.c |  9 +--------
>  drivers/mmc/host/sdhci-pltfm.c     |  8 ++++++++
>  drivers/mmc/host/sdhci-pltfm.h     |  2 ++
>  drivers/mmc/host/sdhci-pxav2.c     |  9 +--------
>  drivers/mmc/host/sdhci-pxav3.c     |  9 +--------
>  6 files changed, 18 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 453825f..1e97b89 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -51,7 +51,6 @@
>  #define BCM2835_SDHCI_WRITE_DELAY      (((2 * 1000000) / MIN_FREQ) + 1)
>
>  struct bcm2835_sdhci {
> -       struct clk *clk;
>         u32 shadow;
>  };
>
> @@ -120,27 +119,11 @@ static u8 bcm2835_sdhci_readb(struct sdhci_host *host, int reg)
>         return byte;
>  }
>
> -static unsigned int bcm2835_sdhci_get_max_clock(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct bcm2835_sdhci *bcm2835_host = pltfm_host->priv;
> -
> -       return clk_get_rate(bcm2835_host->clk);
> -}
> -
>  unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
>  {
>         return MIN_FREQ;
>  }
>
> -unsigned int bcm2835_sdhci_get_timeout_clock(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct bcm2835_sdhci *bcm2835_host = pltfm_host->priv;
> -
> -       return clk_get_rate(bcm2835_host->clk);
> -}
> -
>  static struct sdhci_ops bcm2835_sdhci_ops = {
>         .write_l = bcm2835_sdhci_writel,
>         .write_w = bcm2835_sdhci_writew,
> @@ -148,9 +131,9 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
>         .read_l = bcm2835_sdhci_readl,
>         .read_w = bcm2835_sdhci_readw,
>         .read_b = bcm2835_sdhci_readb,
> -       .get_max_clock = bcm2835_sdhci_get_max_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_min_clock = bcm2835_sdhci_get_min_clock,
> -       .get_timeout_clock = bcm2835_sdhci_get_timeout_clock,
> +       .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>  };
>
>  static struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
> @@ -180,9 +163,9 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>         pltfm_host = sdhci_priv(host);
>         pltfm_host->priv = bcm2835_host;
>
> -       bcm2835_host->clk = devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(bcm2835_host->clk)) {
> -               ret = PTR_ERR(bcm2835_host->clk);
> +       pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(pltfm_host->clk)) {
> +               ret = PTR_ERR(pltfm_host->clk);
>                 goto err;
>         }
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ae68bc9..4757b04 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -323,13 +323,6 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>                 esdhc_clrset_le(host, 0x7, 0x7, ESDHC_SYSTEM_CONTROL);
>  }
>
> -static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -       return clk_get_rate(pltfm_host->clk);
> -}
> -
>  static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -363,7 +356,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>         .write_w = esdhc_writew_le,
>         .write_b = esdhc_writeb_le,
>         .set_clock = esdhc_set_clock,
> -       .get_max_clock = esdhc_pltfm_get_max_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_min_clock = esdhc_pltfm_get_min_clock,
>         .get_ro = esdhc_pltfm_get_ro,
>  };
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d4283ef..3145a78 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -36,6 +36,14 @@
>  #endif
>  #include "sdhci-pltfm.h"
>
> +unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return clk_get_rate(pltfm_host->clk);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
> +
>  static struct sdhci_ops sdhci_pltfm_ops = {
>  };
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 37e0e18..153b6c5 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -98,6 +98,8 @@ extern int sdhci_pltfm_register(struct platform_device *pdev,
>                                 struct sdhci_pltfm_data *pdata);
>  extern int sdhci_pltfm_unregister(struct platform_device *pdev);
>
> +extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
> +
>  #ifdef CONFIG_PM
>  extern const struct dev_pm_ops sdhci_pltfm_pmops;
>  #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index ac854aa..c151a25 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -111,15 +111,8 @@ static int pxav2_mmc_set_width(struct sdhci_host *host, int width)
>         return 0;
>  }
>
> -static u32 pxav2_get_max_clock(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -       return clk_get_rate(pltfm_host->clk);
> -}
> -
>  static struct sdhci_ops pxav2_sdhci_ops = {
> -       .get_max_clock = pxav2_get_max_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .platform_reset_exit = pxav2_set_private_registers,
>         .platform_8bit_width = pxav2_mmc_set_width,
>  };
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3d20c10..f09877f 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -163,18 +163,11 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>         return 0;
>  }
>
> -static u32 pxav3_get_max_clock(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -       return clk_get_rate(pltfm_host->clk);
> -}
> -
>  static struct sdhci_ops pxav3_sdhci_ops = {
>         .platform_reset_exit = pxav3_set_private_registers,
>         .set_uhs_signaling = pxav3_set_uhs_signaling,
>         .platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
> -       .get_max_clock = pxav3_get_max_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  };
>
>  #ifdef CONFIG_OF

Tested-by: Kevin Liu <kliu5@marvell.com>

The patch worked well on sdhci-pxav3 platform.

> --
> 1.8.0
>
