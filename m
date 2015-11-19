From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/19] mmc: core/host: enable support for the standard
 "wakeup-source" property
Date: Thu, 19 Nov 2015 12:32:45 +0100
Message-ID: <CAPDyKFrB7-SsBt_C9hvgwY-NHL-S8pvXmKc70f2Z_G2RoEpk9Q@mail.gmail.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
	<1445422216-29375-6-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445422216-29375-6-git-send-email-sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 21 October 2015 at 12:10, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
> Though the mmc core driver should/will continue to support the legacy
> "enable-sdio-wakeup" property to enable SDIO as the wakeup source, we
> need to add support for the new standard property "wakeup-source".
>
> This patch adds support for "wakeup-source" property in addition to the
> existing "enable-sdio-wakeup" property.
>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c        | 3 ++-
>  drivers/mmc/host/sdhci-pltfm.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 5466f25f0281..85222bb56c73 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -513,7 +513,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
>         if (of_property_read_bool(np, "keep-power-in-suspend"))
>                 host->pm_caps |= MMC_PM_KEEP_POWER;
> -       if (of_property_read_bool(np, "enable-sdio-wakeup"))
> +       if (of_property_read_bool(np, "wakeup-source") ||
> +           of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>         if (of_property_read_bool(np, "mmc-ddr-1_8v"))
>                 host->caps |= MMC_CAP_1_8V_DDR;
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a207f5aaf62f..f00374bdafc9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -108,7 +108,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
>         if (of_find_property(np, "keep-power-in-suspend", NULL))
>                 host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
>
> -       if (of_find_property(np, "enable-sdio-wakeup", NULL))
> +       if (of_property_read_bool(np, "wakeup-source") ||
> +           of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
>                 host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>  }
>  #else
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
