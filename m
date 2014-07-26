From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: remove PCI PM functions in suspend/resume callback
Date: Sat, 26 Jul 2014 11:24:47 +0200
Message-ID: <CAPDyKFor4YrQGm5y47YqMfnrQex_V4gFGqsX5hpcp=ZCKzEuug@mail.gmail.com>
References: <20140715092805.GA27130@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:52705 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaGZJYr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Jul 2014 05:24:47 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so6190112qgd.0
        for <linux-mmc@vger.kernel.org>; Sat, 26 Jul 2014 02:24:47 -0700 (PDT)
In-Reply-To: <20140715092805.GA27130@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 15 July 2014 11:28, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> It is not required (in fact it even is not recommended) that a PCI
> driver's suspend() callback save the standard configuration registers
> of the device, prepare it for waking up the system, or put it into a
> low-power state.  All of these operations can very well be taken
> care of by the PCI subsystem, without the driver's participation. Thus
> remove these PCI functions.
>
> For the device which has wake up capability, use device_init_wakeup to
> init the wake up capability so that PCI core will help to enable the wakeup
> for it.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c |   23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 52c42fc..e536526 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1130,18 +1130,13 @@ static int sdhci_pci_suspend(struct device *dev)
>                         goto err_pci_suspend;
>         }
>
> -       pci_save_state(pdev);
>         if (pm_flags & MMC_PM_KEEP_POWER) {
> -               if (pm_flags & MMC_PM_WAKE_SDIO_IRQ) {
> -                       pci_pme_active(pdev, true);
> -                       pci_enable_wake(pdev, PCI_D3hot, 1);
> -               }
> -               pci_set_power_state(pdev, PCI_D3hot);
> -       } else {
> -               pci_enable_wake(pdev, PCI_D3hot, 0);
> -               pci_disable_device(pdev);
> -               pci_set_power_state(pdev, PCI_D3hot);
> -       }
> +               if (pm_flags & MMC_PM_WAKE_SDIO_IRQ)
> +                       device_init_wakeup(dev, true);
> +               else
> +                       device_init_wakeup(dev, false);
> +       } else
> +               device_init_wakeup(dev, false);
>
>         return 0;
>
> @@ -1162,12 +1157,6 @@ static int sdhci_pci_resume(struct device *dev)
>         if (!chip)
>                 return 0;
>
> -       pci_set_power_state(pdev, PCI_D0);
> -       pci_restore_state(pdev);
> -       ret = pci_enable_device(pdev);
> -       if (ret)
> -               return ret;
> -
>         if (chip->fixes && chip->fixes->resume) {
>                 ret = chip->fixes->resume(chip);
>                 if (ret)
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
