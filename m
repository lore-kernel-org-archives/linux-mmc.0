From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-at91: add presets setup
Date: Mon, 2 May 2016 10:40:27 +0200
Message-ID: <CAPDyKFoQ5eADXMAm25h7AjfgqkCL9DHDC+fcHr1aTMEy-1HLfg@mail.gmail.com>
References: <1461848366-32562-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36166 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbcEBIk3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2016 04:40:29 -0400
Received: by mail-wm0-f47.google.com with SMTP id n129so98501382wmn.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 May 2016 01:40:28 -0700 (PDT)
In-Reply-To: <1461848366-32562-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On 28 April 2016 at 14:59, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> The controller claims to support SDR104. In fact, it only supports a
> degraded SDR104 since the maximum frequency of the SD clock is 120 MHz
> instead of 208 MHz.
> The sdhci core is unaware of it and will compute a wrong clock divider.
> We can deal with this specific case by using presets.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes:
> - v2:
>   - use a define for preset_common since it's a constant
>
>  drivers/mmc/host/sdhci-of-at91.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index c1923c0..25f779e 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
> @@ -32,6 +33,8 @@
>  #define                SDMMC_CACR_CAPWREN      BIT(0)
>  #define                SDMMC_CACR_KEY          (0x46 << 8)
>
> +#define SDHCI_AT91_PRESET_COMMON_CONF  0x400 /* drv type B, programmable clock mode */
> +
>  struct sdhci_at91_priv {
>         struct clk *hclock;
>         struct clk *gck;
> @@ -163,6 +166,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         unsigned int                    clk_base, clk_mul;
>         unsigned int                    gck_rate, real_gck_rate;
>         int                             ret;
> +       unsigned int                    preset_div;
>
>         match = of_match_device(sdhci_at91_dt_match, &pdev->dev);
>         if (!match)
> @@ -230,6 +234,28 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>                          clk_mul, real_gck_rate);
>         }
>
> +       /*
> +        * We have to set preset values because it depends on the clk_mul
> +        * value. Moreover, SDR104 is supported in a degraded mode since the
> +        * maximum sd clock value is 120 MHz instead of 208 MHz. For that
> +        * reason, we need to use presets to support SDR104.
> +        */
> +       preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
> +       writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +              host->ioaddr + SDHCI_PRESET_FOR_SDR12);
> +       preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +       writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +              host->ioaddr + SDHCI_PRESET_FOR_SDR25);
> +       preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
> +       writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +              host->ioaddr + SDHCI_PRESET_FOR_SDR50);
> +       preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
> +       writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +              host->ioaddr + SDHCI_PRESET_FOR_SDR104);
> +       preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
> +       writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> +              host->ioaddr + SDHCI_PRESET_FOR_DDR50);
> +
>         clk_prepare_enable(priv->mainck);
>         clk_prepare_enable(priv->gck);
>
> --
> 2.5.0
>
