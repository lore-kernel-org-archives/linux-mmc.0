From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3] mmc: sdhci-cadence: add HS400 enhanced strobe support
Date: Thu, 16 Mar 2017 15:46:01 +0100
Message-ID: <CAPDyKFqb6C8n6Z-GXN64R1mosXn8YBtLRn8s5Xmr4VWS55GUcw@mail.gmail.com>
References: <1488788921-29260-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35371 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbdCPOqD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 10:46:03 -0400
Received: by mail-ua0-f171.google.com with SMTP id q7so27501679uaf.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 07:46:02 -0700 (PDT)
In-Reply-To: <1488788921-29260-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 6 March 2017 at 09:28, Piotr Sroka <piotrs@cadence.com> wrote:
> Add support for HS400ES mode to Cadence SDHCI driver.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
> - Modify enhanced strobe function to handle disabling
>   enhanced strobe inside the function.
>   Do no relay on that mmc_set_ios() is called
>   immediately after host->ops->hs400_enhanced_strobe(host, &host->ios).
> Changes in v3:
> - Few coding-style fixes were made.
> ---
>  drivers/mmc/host/sdhci-cadence.c | 57 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 316cfec..48f6419 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -40,6 +40,7 @@
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_DDR                0x3
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS200      0x4
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400      0x5
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES    0x6
>
>  /* SRS - Slot Register Set (SDHCI-compatible) */
>  #define SDHCI_CDNS_SRS_BASE            0x200
> @@ -64,6 +65,7 @@
>
>  struct sdhci_cdns_priv {
>         void __iomem *hrs_addr;
> +       bool enhanced_strobe;
>  };
>
>  static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> @@ -108,11 +110,30 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>         return host->max_clk / 1000;
>  }
>
> +static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
> +{
> +       u32 tmp;
> +
> +       /* The speed mode for eMMC is selected by HRS06 register */
> +       tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> +       tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
> +       tmp |= mode;
> +       writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> +}
> +
> +static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
> +{
> +       u32 tmp;
> +
> +       tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> +       return tmp & SDHCI_CDNS_HRS06_MODE_MASK;
> +}
> +
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>                                          unsigned int timing)
>  {
>         struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> -       u32 mode, tmp;
> +       u32 mode;
>
>         switch (timing) {
>         case MMC_TIMING_MMC_HS:
> @@ -125,18 +146,17 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>                 mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
>                 break;
>         case MMC_TIMING_MMC_HS400:
> -               mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
> +               if (priv->enhanced_strobe)
> +                       mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
> +               else
> +                       mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
>                 break;
>         default:
>                 mode = SDHCI_CDNS_HRS06_MODE_SD;
>                 break;
>         }
>
> -       /* The speed mode for eMMC is selected by HRS06 register */
> -       tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> -       tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
> -       tmp |= mode;
> -       writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> +       sdhci_cdns_set_emmc_mode(priv, mode);
>
>         /* For SD, fall back to the default handler */
>         if (mode == SDHCI_CDNS_HRS06_MODE_SD)
> @@ -213,6 +233,26 @@ static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
>  }
>
> +static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                            struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       u32 mode;
> +
> +       priv->enhanced_strobe = ios->enhanced_strobe;
> +
> +       mode = sdhci_cdns_get_emmc_mode(priv);
> +
> +       if (mode == SDHCI_CDNS_HRS06_MODE_MMC_HS400 && ios->enhanced_strobe)
> +               sdhci_cdns_set_emmc_mode(priv,
> +                                        SDHCI_CDNS_HRS06_MODE_MMC_HS400ES);
> +
> +       if (mode == SDHCI_CDNS_HRS06_MODE_MMC_HS400ES && !ios->enhanced_strobe)
> +               sdhci_cdns_set_emmc_mode(priv,
> +                                        SDHCI_CDNS_HRS06_MODE_MMC_HS400);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> @@ -240,8 +280,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>
>         priv = sdhci_cdns_priv(host);
>         priv->hrs_addr = host->ioaddr;
> +       priv->enhanced_strobe = false;
>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
>         host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
> +       host->mmc_host_ops.hs400_enhanced_strobe =
> +                               sdhci_cdns_hs400_enhanced_strobe;
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
> --
> 2.2.2
>
