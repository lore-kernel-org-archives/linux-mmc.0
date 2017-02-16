From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] [2/2] mmc: sdhci-cadence: Update PHY delay configuration
Date: Thu, 16 Feb 2017 16:09:59 +0100
Message-ID: <CAPDyKFqsuzT9NXARMJtey_kZ0y2GsdOxZGsjbodWA1EXw_ZSzw@mail.gmail.com>
References: <1487250413-5769-1-git-send-email-piotrs@cadence.com> <1487250413-5769-2-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487250413-5769-2-git-send-email-piotrs-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Piotr Sroka <piotrs-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 16 February 2017 at 14:06, Piotr Sroka <piotrs-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org> wrote:
> DTS properties are used instead of fixed data
> because PHY settings can be different for different platforms.
> Configuration of new three PHY delays were added
>
> Signed-off-by: Piotr Sroka <piotrs-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-cadence.txt      | 54 ++++++++++++++

Please split this patch.

DT docs should be a separate patch and make sure it precedes the
changes where the new bindings are being parsed in the driver code.

>  drivers/mmc/host/sdhci-cadence.c                   | 83 +++++++++++++++++++---
>  2 files changed, 129 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> index c0f37cb..221d3fe 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> @@ -19,6 +19,59 @@ if supported.  See mmc.txt for details.
>  - mmc-hs400-1_8v
>  - mmc-hs400-1_2v
>
> +- phy-input-delay-sd-hs:
> +  Value of the delay in the input path for High Speed work mode.
> +  Valid range = [0:0x1F].

Please specify what unit this in. And then also a suffix, like "-ns"
to the name of the binding.

Similar comment applies to all new bindings below.

> +  Delay configuration stay unchanged if this property is not provided.

I would remove this information from the DT doc, it's just confusion
when you refer to something that should remain "unchanged".

Similar comment applies to all new bindings below.

> +- phy-input-delay-sd-default:
> +  Value of the delay in the input path for Default Speed work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-sd-sdr12:
> +  Value of the delay in the input path for SDR12 work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-sd-sdr25:
> +  Value of the delay in the input path for SDR25 work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-sd-sdr50:
> +  Value of the delay in the input path for SDR50 work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-sd-ddr50:
> +  Value of the delay in the input path for DDR50 work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-emmc-legacy:

Legacy? As in legacy speed mode?

> +  Value of the delay in the input path for eMMC legacy work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-emmc-sdr:
> +  Value of the delay in the input path for eMMC SDR work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-input-delay-emmc-ddr:
> +  Value of the delay in the input path for eMMC DDR work mode.
> +  Valid range = [0:0x1F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-dll-delay-sdclk:
> +  Value of the delay introduced on the sdclk output
> +  for all modes except HS200, HS400 and HS400_ES.
> +  Valid range = [0:0x7F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-dll-delay-sdclk-hsmmc:
> +  Value of the delay introduced on the sdclk output
> +  for HS200, HS400 and HS400_ES speed modes.
> +  Valid range = [0:0x7F].
> +  Delay configuration stay unchanged if this property is not provided.
> +- phy-dll-delay-strobe:
> +  Value of the delay introduced on the dat_strobe input
> +  used in HS400 / HS400_ES speed modes.
> +  Valid range = [0:0x7F].
> +  Delay configuration stay unchanged if this property is not provided.

A general comment, is that I suggest you look at the generic mmc DT
bindings for the different speedmodes, and align these new names of DT
bindings to those.

> +
> +
>  Example:
>         emmc: sdhci@5a000000 {
>                 compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> @@ -29,4 +82,5 @@ Example:
>                 mmc-ddr-1_8v;
>                 mmc-hs200-1_8v;
>                 mmc-hs400-1_8v;
> +               phy-input-delay-sd-hs = <0>;
>         };
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c946e45..6c338d2 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -17,6 +17,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> +#include <linux/of.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -53,6 +54,9 @@
>  #define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY 0x06
>  #define SDHCI_CDNS_PHY_DLY_EMMC_SDR    0x07
>  #define SDHCI_CDNS_PHY_DLY_EMMC_DDR    0x08
> +#define SDHCI_CDNS_PHY_DLY_SDCLK       0x0b
> +#define SDHCI_CDNS_PHY_DLY_HSMMC       0x0c
> +#define SDHCI_CDNS_PHY_DLY_STROBE      0x0d
>
>  /*
>   * The tuned val register is 6 bit-wide, but not the whole of the range is
> @@ -89,13 +93,73 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         return 0;
>  }
>
> -static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns_phy_parse_dt(struct device_node *np,
> +                                  struct sdhci_cdns_priv *priv)
>  {
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS, 4);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT, 4);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY, 9);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR, 2);
> -       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR, 3);
> +       u32 tmp;
> +       int ret;
> +
> +       if (!of_property_read_u32(np, "phy-input-delay-sd-hs", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_SD_HS, tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-input-delay-sd-default", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_SD_DEFAULT,
> +                                              tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-input-delay-sd-sdr12", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_UHS_SDR12,
> +                                              tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-input-delay-sd-sdr25", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_UHS_SDR25,
> +                                              tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-input-delay-sd-sdr50", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_UHS_SDR50,
> +                                              tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-input-delay-sd-ddr50", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_UHS_DDR50,
> +                                              tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-dll-delay-sdclk", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_SDCLK, tmp);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-dll-delay-sdclk-hsmmc", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_HSMMC, tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (!of_property_read_u32(np, "phy-dll-delay-strobe", &tmp)) {
> +               ret = sdhci_cdns_write_phy_reg(priv,
> +                                              SDHCI_CDNS_PHY_DLY_STROBE, tmp);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;

This all looks very weird. Should you write all this to the phy
register, even before you know anything about what kind of
eMMC/MMC/SD/SDIO card that is attached? Does that even work?

>  }
>
>  static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> @@ -224,10 +288,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         struct sdhci_host *host;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_cdns_priv *priv;
> +       struct device *dev = &pdev->dev;
>         struct clk *clk;
>         int ret;
>
> -       clk = devm_clk_get(&pdev->dev, NULL);
> +       clk = devm_clk_get(dev, NULL);

This seems like and unrelated change. Please remove this change from the patch.

>         if (IS_ERR(clk))
>                 return PTR_ERR(clk);
>
> @@ -253,7 +318,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> -       sdhci_cdns_phy_init(priv);
> +       ret = sdhci_cdns_phy_parse_dt(dev->of_node, priv);
> +       if (ret)
> +               goto free;
>
>         ret = sdhci_add_host(host);
>         if (ret)
> --
> 2.2.2
>

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
