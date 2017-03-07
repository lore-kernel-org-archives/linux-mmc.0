From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Tue, 7 Mar 2017 17:02:56 +0900
Message-ID: <CAK7LNATAa7svo_DrotgM0XKMhLbZ2Qum8qe6fJxxf4Z+ouH_wA@mail.gmail.com>
References: <1488807587-5375-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from condef-08.nifty.com ([202.248.20.73]:51333 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdCGIHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Mar 2017 03:07:45 -0500
In-Reply-To: <1488807587-5375-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Piotr,

2017-03-06 22:39 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> PHY settings can be different for different platforms and SoCs.
> Fixed PHY input delays was replaced with SoC specific compatible data.
> DTS properties are used for configuration new PHY DLL delays.


Probably you are familiar with this IP.

Please teach me this.

With this patch, we will have two groups for PHY parameters.

(A) specified via a data array associated with a compatible string
SDHCI_CDNS_PHY_DLY_SD_HS
SDHCI_CDNS_PHY_DLY_SD_DEFAULT
SDHCI_CDNS_PHY_DLY_UHS_SDR12
SDHCI_CDNS_PHY_DLY_UHS_SDR25
SDHCI_CDNS_PHY_DLY_UHS_SDR50
SDHCI_CDNS_PHY_DLY_UHS_DDR50
SDHCI_CDNS_PHY_DLY_EMMC_LEGACY
SDHCI_CDNS_PHY_DLY_EMMC_SDR
SDHCI_CDNS_PHY_DLY_EMMC_DDR

(B) specified with DT property
SDHCI_CDNS_PHY_DLY_SDCLK
SDHCI_CDNS_PHY_DLY_HSMMC
SDHCI_CDNS_PHY_DLY_STROBE


I am confused.
What is the difference between (A) and (B)?


A little more minor issues below.


>
>  /*
>   * The tuned val register is 6 bit-wide, but not the whole of the range is
> @@ -62,10 +66,24 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP     40
>
> +static const struct of_device_id sdhci_cdns_match[];
> +

You need not add this declaration
if you use of_device_get_match_data().
(please see below)





> @@ -90,13 +108,77 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         return 0;
>  }
>
> -static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns_phy_in_delay_init(struct sdhci_cdns_priv *priv,
> +                                       const struct sdhci_cdns_config *config)
> +{
> +       int ret = 0;


The initializer "= 0" is unneeded here
because the variable is re-assigned with a return value of functions.




> @@ -254,7 +338,16 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> -       sdhci_cdns_phy_init(priv);
> +       match = of_match_node(sdhci_cdns_match, dev->of_node);
> +       if (match && match->data) {
> +               ret = sdhci_cdns_phy_in_delay_init(priv, match->data);
> +               if (ret)
> +                       goto free;
> +       }

You can simplify the code with of_device_get_match_data():

     config = of_device_get_match_data(dev);
     if (config) {
             ret = sdhci_cdns_phy_in_delay_init(priv, config);
             if (ret)
                     goto free;
     }




>  static const struct of_device_id sdhci_cdns_match[] = {
> -       { .compatible = "socionext,uniphier-sd4hc" },
> +       {
> +               .compatible = "socionext,uniphier-sd4hc",
> +               .data = &sdhci_cdns_uniphier_config
> +       },
>         { .compatible = "cdns,sd4hc" },


I prefer cdns,sd4hc indented in the same way:

          {
                  .compatible = "cdns,sd4hc",
          },





-- 
Best Regards
Masahiro Yamada
