From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5 3/4] mmc: sdhci-cadence: Update PHY delay configuration
Date: Thu, 30 Mar 2017 21:30:46 +0200
Message-ID: <CAPDyKFqLhBCH=SK=_Se=BFKobTPLRpNy++6ci2cjUCF4k4mS3A@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com> <1490106791-3553-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34647 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934581AbdC3Tax (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:30:53 -0400
Received: by mail-vk0-f52.google.com with SMTP id z204so67232502vkd.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:30:52 -0700 (PDT)
In-Reply-To: <1490106791-3553-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 21 March 2017 at 15:33, Piotr Sroka <piotrs@cadence.com> wrote:
> DTS properties are used instead of fixed data
> because PHY settings can be different for different chips/boards.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>


Thanks, applied for next!

Kind regards
Uffe


> ---
> Changes for v2:
> - dts part was removed from this patch
> - most delays were moved from dts file
>   to data associated with an SoC specific compatible
> - remove unrelated changes
> ---
> Changes for v3:
> - move all delays back to dts because they are also boards dependent
> - prefix all of the Cadence-specific properties with cdns prefix
> - put checking delay properties inside the for loop
>   instead of using a lot of single if expressions
> ---
> Changes for v4:
> - remove unecessary declaration of sdhci_cdns_match
> - format fix (blank line removed)
> ---
> Changes for v5:
> - use driver version from next branch, with applied enhanced strobe feature support.
> - change name of property to be consistent with timing modes
>   available in Linux
> ---
>  drivers/mmc/host/sdhci-cadence.c | 53 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 83c3b55..c3c7090 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/of.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -55,6 +56,9 @@
>  #define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY 0x06
>  #define SDHCI_CDNS_PHY_DLY_EMMC_SDR    0x07
>  #define SDHCI_CDNS_PHY_DLY_EMMC_DDR    0x08
> +#define SDHCI_CDNS_PHY_DLY_SDCLK       0x0b
> +#define SDHCI_CDNS_PHY_DLY_HSMMC       0x0c
> +#define SDHCI_CDNS_PHY_DLY_STROBE      0x0d
>
>  /*
>   * The tuned val register is 6 bit-wide, but not the whole of the range is
> @@ -68,6 +72,25 @@ struct sdhci_cdns_priv {
>         bool enhanced_strobe;
>  };
>
> +struct sdhci_cdns_phy_cfg {
> +       const char *property;
> +       u8 addr;
> +};
> +
> +static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> +       { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
> +       { "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> +       { "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> +       { "cdns,phy-input-delay-sd-uhs-sdr25", SDHCI_CDNS_PHY_DLY_UHS_SDR25, },
> +       { "cdns,phy-input-delay-sd-uhs-sdr50", SDHCI_CDNS_PHY_DLY_UHS_SDR50, },
> +       { "cdns,phy-input-delay-sd-uhs-ddr50", SDHCI_CDNS_PHY_DLY_UHS_DDR50, },
> +       { "cdns,phy-input-delay-mmc-highspeed", SDHCI_CDNS_PHY_DLY_EMMC_SDR, },
> +       { "cdns,phy-input-delay-mmc-ddr", SDHCI_CDNS_PHY_DLY_EMMC_DDR, },
> +       { "cdns,phy-dll-delay-sdclk", SDHCI_CDNS_PHY_DLY_SDCLK, },
> +       { "cdns,phy-dll-delay-sdclk-hsmmc", SDHCI_CDNS_PHY_DLY_HSMMC, },
> +       { "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
> +};
> +
>  static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>                                     u8 addr, u8 data)
>  {
> @@ -92,13 +115,26 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         return 0;
>  }
>
> -static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns_phy_init(struct device_node *np,
> +                              struct sdhci_cdns_priv *priv)
>  {
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS, 4);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT, 4);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY, 9);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR, 2);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR, 3);
> +       u32 val;
> +       int ret, i;
> +
> +       for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
> +               ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
> +                                          &val);
> +               if (ret)
> +                       continue;
> +
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              sdhci_cdns_phy_cfgs[i].addr,
> +                                              val);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> @@ -267,6 +303,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
>         int ret;
> +       struct device *dev = &pdev->dev;
>
>         clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(clk))
> @@ -297,7 +334,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> -       sdhci_cdns_phy_init(priv);
> +       ret = sdhci_cdns_phy_init(dev->of_node, priv);
> +       if (ret)
> +               goto free;
>
>         ret = sdhci_add_host(host);
>         if (ret)
> --
> 2.2.2
>
