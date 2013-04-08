From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 2/2] mmc: core: fix performance regression initializing
 MMC host controllers
Date: Mon, 8 Apr 2013 11:41:09 +0200
Message-ID: <CAPDyKFqMjZ_b+YapO60z=3eaKQ4ggdK-7CHfiqWg=d+WVFa94Q@mail.gmail.com>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com>
	<1365082866-28404-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFry9CUmguXw0u4Vxa6YXixF-vVzGrvT_MorFjg=1wS+pA@mail.gmail.com>
	<515E7CB2.9020602@intel.com>
	<CAPDyKFp2gKuJNY-X5obsDZVvj1V=JN2rnyfkpNKB=HZQd+_pJg@mail.gmail.com>
	<515ED220.5050105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43421 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934848Ab3DHJlK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 05:41:10 -0400
Received: by mail-vc0-f174.google.com with SMTP id kw10so2443798vcb.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2013 02:41:09 -0700 (PDT)
In-Reply-To: <515ED220.5050105@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Sergey Yanovich <ynvich@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 5 April 2013 15:31, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Commit fa5501890d8974301042e0202d342a6cbe8609f4 introduced a boot time
> performance regression by adding mmc_power_up() to mmc_start_host().
> mmc_power_up() is not necessary to host controller initialization, it is
> part of card initialization and is performed anyway asynchronously.
> Please see the original commit for an explanation of the use of
> mmc_power_up() in mmc_start_host().
>
> This patch allows a driver to leave the power up in asynchronous code
> (as it was before).
>
> On my current target platform this reduces driver initialization from:
>
> [    1.313220] initcall sdhci_acpi_driver_init+0x0/0x12 returned 0 after 102008 usecs
>
> to this:
>
> [    1.217209] initcall sdhci_acpi_driver_init+0x0/0x12 returned 0 after 8331 usecs
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c       | 3 ++-
>  drivers/mmc/host/sdhci-acpi.c | 2 ++
>  include/linux/mmc/host.h      | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3bf1c46..c1893c9 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2416,7 +2416,8 @@ void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(freqs[0], host->f_min);
>         host->rescan_disable = 0;
> -       mmc_power_up(host);
> +       if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP))
> +               mmc_power_up(host);
>         mmc_detect_change(host, 0);
>  }
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 2592ddd..7bcf74b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -195,6 +195,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>                 host->mmc->pm_caps  |= c->slot->pm_caps;
>         }
>
> +       host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto err_free;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 17d7148..8873e83 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -280,6 +280,7 @@ struct mmc_host {
>  #define MMC_CAP2_PACKED_WR     (1 << 13)       /* Allow packed write */
>  #define MMC_CAP2_PACKED_CMD    (MMC_CAP2_PACKED_RD | \
>                                  MMC_CAP2_PACKED_WR)
> +#define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power up before scan */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> --
> 1.7.11.7
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
