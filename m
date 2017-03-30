From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection
Date: Thu, 30 Mar 2017 21:30:30 +0200
Message-ID: <CAPDyKFraFT-ML8uU-3xQNQGKUs-SaVi=wg6ULepRxTPUGRFxqA@mail.gmail.com>
References: <20170328090045.2133-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34460 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbdC3Tac (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:30:32 -0400
Received: by mail-vk0-f48.google.com with SMTP id z204so67223785vkd.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:30:31 -0700 (PDT)
In-Reply-To: <20170328090045.2133-1-ludovic.desroches@microchip.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nicolas.ferre@microchip.com, "# 4 . 4+" <stable@vger.kernel.org>

On 28 March 2017 at 11:00, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> The controller has different timings for MMC_TIMING_UHS_DDR50 and
> MMC_TIMING_MMC_DDR52. Configuring the controller with SDHCI_CTRL_UHS_DDR50,
> when MMC_TIMING_MMC_DDR52 timings are requested, is not correct and can
> lead to unexpected behavior.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
> Cc: <stable@vger.kernel.org> # 4.4+

Thanks, applied for fixes!

And thanks for really getting to bottom to fix this issue properly!

Kind regards
Uffe

> ---
>
> Hi,
>
> Here is the proper fix (I hope!) to the issue I have since commit e173f8911f09
> ("mmc: core: Update CMD13 polling policy when switch to HS DDR mode"). This
> commit was probably not the root cause but causes some side effect due to a
> bad timing configuration.
>
> I can't explain how it was working before but for sure I was not configuring
> properly the controller timings.
>
> Regards
>
>
>  drivers/mmc/host/sdhci-of-at91.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 814571f..7611fd6 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -29,6 +29,8 @@
>
>  #include "sdhci-pltfm.h"
>
> +#define SDMMC_MC1R     0x204
> +#define                SDMMC_MC1R_DDR          BIT(3)
>  #define SDMMC_CACR     0x230
>  #define                SDMMC_CACR_CAPWREN      BIT(0)
>  #define                SDMMC_CACR_KEY          (0x46 << 8)
> @@ -101,11 +103,18 @@ static void sdhci_at91_set_power(struct sdhci_host *host, unsigned char mode,
>         sdhci_set_power_noreg(host, mode, vdd);
>  }
>
> +void sdhci_at91_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +{
> +       if (timing == MMC_TIMING_MMC_DDR52)
> +               sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
> +       sdhci_set_uhs_signaling(host, timing);
> +}
> +
>  static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
>         .set_clock              = sdhci_at91_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
>         .reset                  = sdhci_reset,
> -       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> +       .set_uhs_signaling      = sdhci_at91_set_uhs_signaling,
>         .set_power              = sdhci_at91_set_power,
>  };
>
> --
> 2.9.0
>
