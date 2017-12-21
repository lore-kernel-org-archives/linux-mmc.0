From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
Date: Thu, 21 Dec 2017 15:15:03 +0100
Message-ID: <CAPDyKFoHPdYaorR38LaS5Hzs8CC99Smki8uZW8aDanboLRV3QA@mail.gmail.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com> <1513757933-11232-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:46734 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdLUOPF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 09:15:05 -0500
Received: by mail-it0-f65.google.com with SMTP id t1so10795562ite.5
        for <linux-mmc@vger.kernel.org>; Thu, 21 Dec 2017 06:15:04 -0800 (PST)
In-Reply-To: <1513757933-11232-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

On 20 December 2017 at 09:18, Adrian Hunter <adrian.hunter@intel.com> wrote:
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
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 58 ++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 110c634cfb43..2ffc09f088ee 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -39,10 +39,29 @@
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

A couple of comments here.

Wakeup settings shouldn't be changed during system suspend. That means
we shouldn't call device_init_wakeup() (or device_set_wakeup_enable()
for that matter) here.

Instead, device_init_wakeup() should be called during ->probe(), while
device_set_wakeup_enable() should normally *not* have to be called at
all by drivers. There are a exceptions for device_set_wakeup_enable(),
however it should not have to be called during system suspend, at
least.

Of course, I realize that you are not changing the behavior in this
regards in this patch, so I am fine this anyway.

My point is, that the end result while doing this improvements in this
series, should strive to that device_init_wakeup() and
device_set_wakeup_enable() becomes used correctly. I don't think that
is the case, or is it?

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
> @@ -58,9 +77,6 @@ static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>                 ret = sdhci_suspend_host(host);
>                 if (ret)
>                         goto err_pci_suspend;
> -
> -               if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
> -                       sdhci_enable_irq_wakeups(host);
>         }
>
>         return 0;
> @@ -71,36 +87,6 @@ static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
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
> @@ -1108,7 +1094,7 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
>  {
>         int i, ret;
>
> -       ret = __sdhci_pci_suspend_host(chip);
> +       ret = sdhci_pci_suspend_host(chip);
>         if (ret)
>                 return ret;
>
> @@ -1118,8 +1104,6 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip)
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

Kind regards
Uffe
