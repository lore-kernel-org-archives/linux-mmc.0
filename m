From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Fix to handle MMC_POWER_UNDEFINED
Date: Tue, 20 Dec 2016 11:49:47 +0100
Message-ID: <CAPDyKFpdLb62ANfYB+Pc3L0pEfrcPmtKnuAotE8A8v-3+ezeuQ@mail.gmail.com>
References: <1482154391-17019-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:34278 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbcLTKtu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 05:49:50 -0500
Received: by mail-wj0-f172.google.com with SMTP id tg4so174157225wjb.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2016 02:49:49 -0800 (PST)
In-Reply-To: <1482154391-17019-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 December 2016 at 14:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Since commit c2c24819b280 ("mmc: core: Don't power off the card when
> starting the host"), the power state can still be MMC_POWER_UNDEFINED after
> mmc_start_host() is called. That can trigger a warning in SDHCI during
> runtime resume as it tries to restore the I/O state. Handle
> MMC_POWER_UNDEFINED simply by not updating the I/O state in that case.
>
> Fixes: c2c24819b280 ("mmc: core: Don't power off the card when starting the host")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Adrian, thanks for fixing this - my bad! Applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 111991e5b9a0..23909804ffb8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1576,6 +1576,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         unsigned long flags;
>         u8 ctrl;
>
> +       if (ios->power_mode == MMC_POWER_UNDEFINED)
> +               return;
> +
>         spin_lock_irqsave(&host->lock, flags);
>
>         if (host->flags & SDHCI_DEVICE_DEAD) {
> @@ -2938,22 +2941,24 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>
>         sdhci_init(host, 0);
>
> -       /* Force clock and power re-program */
> -       host->pwr = 0;
> -       host->clock = 0;
> -       mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
> -       mmc->ops->set_ios(mmc, &mmc->ios);
> +       if (mmc->ios.power_mode != MMC_POWER_UNDEFINED) {
> +               /* Force clock and power re-program */
> +               host->pwr = 0;
> +               host->clock = 0;
> +               mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
> +               mmc->ops->set_ios(mmc, &mmc->ios);
>
> -       if ((host_flags & SDHCI_PV_ENABLED) &&
> -               !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
> -               spin_lock_irqsave(&host->lock, flags);
> -               sdhci_enable_preset_value(host, true);
> -               spin_unlock_irqrestore(&host->lock, flags);
> -       }
> +               if ((host_flags & SDHCI_PV_ENABLED) &&
> +                   !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
> +                       spin_lock_irqsave(&host->lock, flags);
> +                       sdhci_enable_preset_value(host, true);
> +                       spin_unlock_irqrestore(&host->lock, flags);
> +               }
>
> -       if ((mmc->caps2 & MMC_CAP2_HS400_ES) &&
> -           mmc->ops->hs400_enhanced_strobe)
> -               mmc->ops->hs400_enhanced_strobe(mmc, &mmc->ios);
> +               if ((mmc->caps2 & MMC_CAP2_HS400_ES) &&
> +                   mmc->ops->hs400_enhanced_strobe)
> +                       mmc->ops->hs400_enhanced_strobe(mmc, &mmc->ios);
> +       }
>
>         spin_lock_irqsave(&host->lock, flags);
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
