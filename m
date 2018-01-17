From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 1/9] mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
Date: Wed, 17 Jan 2018 12:48:16 +0100
Message-ID: <CAPDyKFp1N1oj3u=LTVUTTej+Diq=FE9S2pZJcmOmwDaJHVhA8g@mail.gmail.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com> <1515484346-800-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:45248 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeAQLsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jan 2018 06:48:18 -0500
Received: by mail-io0-f194.google.com with SMTP id p188so7791397ioe.12
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jan 2018 03:48:18 -0800 (PST)
In-Reply-To: <1515484346-800-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

On 9 January 2018 at 08:52, Adrian Hunter <adrian.hunter@intel.com> wrote:
> sdhci_enable_irq_wakeups() is already called by sdhci_suspend_host() so
> sdhci-pci should not need to call it. However sdhci_suspend_host() only
> calls it if wakeups are enabled, and sdhci-pci does not enable them until
> after calling sdhci_suspend_host(). So move the calls to
> sdhci_pci_init_wakeup() before calling sdhci_suspend_host(), and
> stop calling sdhci_enable_irq_wakeups(). That results in some
> simplification because sdhci_pci_suspend_host() and
> __sdhci_pci_suspend_host() no longer need to be separate functions.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 58 ++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index c5b229b46314..1711b1815630 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -38,10 +38,29 @@
>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
>
>  #ifdef CONFIG_PM_SLEEP
> -static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> +static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
> +{
> +       mmc_pm_flag_t pm_flags = 0;
> +       int i;
> +
> +       for (i = 0; i < chip->num_slots; i++) {
> +               struct sdhci_pci_slot *slot = chip->slots[i];
> +
> +               if (slot)
> +                       pm_flags |= slot->host->mmc->pm_flags;
> +       }
> +
> +       return device_init_wakeup(&chip->pdev->dev,
> +                                 (pm_flags & MMC_PM_KEEP_POWER) &&
> +                                 (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
> +}
> +
> +static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>  {
>         int i, ret;
>
> +       sdhci_pci_init_wakeup(chip);
> +
>         for (i = 0; i < chip->num_slots; i++) {
>                 struct sdhci_pci_slot *slot = chip->slots[i];
>                 struct sdhci_host *host;
> @@ -57,9 +76,6 @@ static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>                 ret = sdhci_suspend_host(host);
>                 if (ret)
>                         goto err_pci_suspend;
> -
> -               if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
> -                       sdhci_enable_irq_wakeups(host);
>         }
>
>         return 0;
> @@ -70,36 +86,6 @@ static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>         return ret;
>  }
>
> -static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
> -{
> -       mmc_pm_flag_t pm_flags = 0;
> -       int i;
> -
> -       for (i = 0; i < chip->num_slots; i++) {
> -               struct sdhci_pci_slot *slot = chip->slots[i];
> -
> -               if (slot)
> -                       pm_flags |= slot->host->mmc->pm_flags;
> -       }
> -
> -       return device_init_wakeup(&chip->pdev->dev,
> -                                 (pm_flags & MMC_PM_KEEP_POWER) &&
> -                                 (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
> -}
> -
> -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> -{
> -       int ret;
> -
> -       ret = __sdhci_pci_suspend_host(chip);
> -       if (ret)
> -               return ret;
> -
> -       sdhci_pci_init_wakeup(chip);
> -
> -       return 0;
> -}
> -
>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot;
> @@ -1107,7 +1093,7 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
>  {
>         int i, ret;
>
> -       ret = __sdhci_pci_suspend_host(chip);
> +       ret = sdhci_pci_suspend_host(chip);
>         if (ret)
>                 return ret;
>
> @@ -1117,8 +1103,6 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
>                         jmicron_enable_mmc(chip->slots[i]->host, 0);
>         }
>
> -       sdhci_pci_init_wakeup(chip);
> -
>         return 0;
>  }
>
> --
> 1.9.1
>
