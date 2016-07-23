From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-pci: Convert to use managed functions
 pcim_* and devm_*
Date: Sat, 23 Jul 2016 11:37:14 +0200
Message-ID: <CAPDyKFoPjTBPr+2DmZKQoD8=pUD4kq+pzGCXW8wFEw1vAROdqg@mail.gmail.com>
References: <1468071703-77301-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35739 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcGWJhR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Jul 2016 05:37:17 -0400
Received: by mail-wm0-f53.google.com with SMTP id f65so82043293wmi.0
        for <linux-mmc@vger.kernel.org>; Sat, 23 Jul 2016 02:37:16 -0700 (PDT)
In-Reply-To: <1468071703-77301-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 July 2016 at 15:41, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> This makes the error handling much more simpler than open-coding everything
> and in addition makes the probe function smaller an tidier.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 42 ++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 6fbf708..773532d 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1819,15 +1819,13 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>                 return -ENODEV;
>         }
>
> -       ret = pci_enable_device(pdev);
> +       ret = pcim_enable_device(pdev);
>         if (ret)
>                 return ret;
>
> -       chip = kzalloc(sizeof(struct sdhci_pci_chip), GFP_KERNEL);
> -       if (!chip) {
> -               ret = -ENOMEM;
> -               goto err;
> -       }
> +       chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;
>
>         chip->pdev = pdev;
>         chip->fixes = (const struct sdhci_pci_fixes *)ent->driver_data;
> @@ -1843,7 +1841,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>         if (chip->fixes && chip->fixes->probe) {
>                 ret = chip->fixes->probe(chip);
>                 if (ret)
> -                       goto free;
> +                       return ret;
>         }
>
>         slots = chip->num_slots;        /* Quirk may have changed this */
> @@ -1853,8 +1851,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>                 if (IS_ERR(slot)) {
>                         for (i--; i >= 0; i--)
>                                 sdhci_pci_remove_slot(chip->slots[i]);
> -                       ret = PTR_ERR(slot);
> -                       goto free;
> +                       return PTR_ERR(slot);
>                 }
>
>                 chip->slots[i] = slot;
> @@ -1864,35 +1861,18 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>                 sdhci_pci_runtime_pm_allow(&pdev->dev);
>
>         return 0;
> -
> -free:
> -       pci_set_drvdata(pdev, NULL);
> -       kfree(chip);
> -
> -err:
> -       pci_disable_device(pdev);
> -       return ret;
>  }
>
>  static void sdhci_pci_remove(struct pci_dev *pdev)
>  {
>         int i;
> -       struct sdhci_pci_chip *chip;
> -
> -       chip = pci_get_drvdata(pdev);
> -
> -       if (chip) {
> -               if (chip->allow_runtime_pm)
> -                       sdhci_pci_runtime_pm_forbid(&pdev->dev);
> +       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
>
> -               for (i = 0; i < chip->num_slots; i++)
> -                       sdhci_pci_remove_slot(chip->slots[i]);
> -
> -               pci_set_drvdata(pdev, NULL);
> -               kfree(chip);
> -       }
> +       if (chip->allow_runtime_pm)
> +               sdhci_pci_runtime_pm_forbid(&pdev->dev);
>
> -       pci_disable_device(pdev);
> +       for (i = 0; i < chip->num_slots; i++)
> +               sdhci_pci_remove_slot(chip->slots[i]);
>  }
>
>  static struct pci_driver sdhci_driver = {
> --
> 2.8.1
>
