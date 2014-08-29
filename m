From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: add probe_slot method for emmc/sd/sdio
Date: Fri, 29 Aug 2014 14:03:50 +0200
Message-ID: <CAPDyKFrBekJ-4W-LVE+6efG9Y75KP8ZrOd6vwfhH4LJSV9mcnA@mail.gmail.com>
References: <1409054455-7782-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:64290 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbaH2MDw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 08:03:52 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2468416lbi.15
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2014 05:03:50 -0700 (PDT)
In-Reply-To: <1409054455-7782-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 26 August 2014 14:00, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> Similar to sdhci-pci controller, also add probe_slot
> and remove_slot method in the sdhci-acpi driver.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

This one have checkpatch errors. Please fixup and resend a new version.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c |   58 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 8ce3c28..93dabf7 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -67,6 +67,8 @@ struct sdhci_acpi_slot {
>         unsigned int    caps2;
>         mmc_pm_flag_t   pm_caps;
>         unsigned int    flags;
> +       int (*probe_slot) (struct platform_device *);
> +       int (*remove_slot) (struct platform_device *);
>  };
>
>  struct sdhci_acpi_host {
> @@ -122,11 +124,57 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
>         .ops = &sdhci_acpi_ops_int,
>  };
>
> +static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev)
> +{
> +       struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
> +       struct sdhci_host *host;
> +
> +       if (!c || !c->host)
> +               return 0;
> +
> +       host = c->host;
> +
> +       /* Platform specific code during emmc proble slot goes here */
> +
> +       return 0;
> +}
> +
> +static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev)
> +{
> +       struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
> +       struct sdhci_host *host;
> +
> +       if (!c || !c->host)
> +               return 0;
> +
> +       host = c->host;
> +
> +       /* Platform specific code during emmc proble slot goes here */
> +
> +       return 0;
> +}
> +
> +static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev)
> +{
> +       struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
> +       struct sdhci_host *host;
> +
> +       if (!c || !c->host || !c->slot)
> +               return 0;
> +
> +       host = c->host;
> +
> +       /* Platform specific code during emmc proble slot goes here */
> +
> +       return 0;
> +}
> +
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>         .chip    = &sdhci_acpi_chip_int,
>         .caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE | MMC_CAP_HW_RESET,
>         .caps2   = MMC_CAP2_HC_ERASE_SZ,
>         .flags   = SDHCI_ACPI_RUNTIME_PM,
> +       .probe_slot     = sdhci_acpi_emmc_probe_slot,
>  };
>
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
> @@ -135,12 +183,14 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
>         .caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
>         .flags   = SDHCI_ACPI_RUNTIME_PM,
>         .pm_caps = MMC_PM_KEEP_POWER,
> +       .probe_slot     = sdhci_acpi_sdio_probe_slot,
>  };
>
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
>         .flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL |
>                    SDHCI_ACPI_RUNTIME_PM,
>         .quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
> +       .probe_slot     = sdhci_acpi_sd_probe_slot,
>  };
>
>  struct sdhci_acpi_uid_slot {
> @@ -275,6 +325,11 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         }
>
>         if (c->slot) {
> +               if (c->slot->probe_slot) {
> +                       err = c->slot->probe_slot(pdev);
> +                       if (err)
> +                               goto err_free;
> +               }
>                 if (c->slot->chip) {
>                         host->ops            = c->slot->chip->ops;
>                         host->quirks        |= c->slot->chip->quirks;
> @@ -332,6 +387,9 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
>                 pm_runtime_put_noidle(dev);
>         }
>
> +       if (c->slot && c->slot->remove_slot)
> +               c->slot->remove_slot(pdev);
> +
>         dead = (sdhci_readl(c->host, SDHCI_INT_STATUS) == ~0);
>         sdhci_remove_host(c->host, dead);
>         sdhci_free_host(c->host);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
