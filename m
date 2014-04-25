From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Use mmc core regulator infrastucture
Date: Fri, 25 Apr 2014 10:15:25 +0200
Message-ID: <CAPDyKFoZQUNCX7Y4C=kr-JDUF3WRxjxeNU4eJRwhZ+cFbmx7iw@mail.gmail.com>
References: <1398378989-14575-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:42268 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaDYIP1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 04:15:27 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so3684750qcx.13
        for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2014 01:15:26 -0700 (PDT)
In-Reply-To: <1398378989-14575-1-git-send-email-tim.kryger@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Chris Ball <chris@printf.net>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 25 April 2014 00:36, Tim Kryger <tim.kryger@linaro.org> wrote:
> Switch the common SDHCI code over to use mmc_host's regulator pointers
> and remove the ones in the sdhci_host structure.  Additionally, use the
> common mmc_regulator_get_supply function to get the regulators and set
> the ocr_avail mask.
>
> This change sets the ocr_avail directly based upon the voltage ranges
> supported which ensures ocr_avail is set correctly while allowing the
> use of regulators that can't provide exactly 1.8v, 3.0v, or 3.3v.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>

This looks good to me!

I plan to get Russell's sdhci patchset merged, prior to this patch. So
likely we need to rebase this patch on top of that soon.

Kind regards
Ulf Hansson

> ---
>
> This patch is the same as the following series only squashed together.
> https://lkml.org/lkml/2014/4/17/653
>
>  drivers/mmc/host/sdhci.c  |   96 +++++++++++++++++----------------------------
>  include/linux/mmc/sdhci.h |    3 --
>  2 files changed, 35 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9a79fc4..2d081d8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1429,6 +1429,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>  static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  {
> +       struct mmc_host *mmc = host->mmc;
>         unsigned long flags;
>         int vdd_bit = -1;
>         u8 ctrl;
> @@ -1437,8 +1438,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>
>         if (host->flags & SDHCI_DEVICE_DEAD) {
>                 spin_unlock_irqrestore(&host->lock, flags);
> -               if (host->vmmc && ios->power_mode == MMC_POWER_OFF)
> -                       mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
> +               if (!IS_ERR(mmc->supply.vmmc) &&
> +                   ios->power_mode == MMC_POWER_OFF)
> +                       mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
>                 return;
>         }
>
> @@ -1463,9 +1465,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>         else
>                 vdd_bit = sdhci_set_power(host, ios->vdd);
>
> -       if (host->vmmc && vdd_bit != -1) {
> +       if (!IS_ERR(mmc->supply.vmmc) && vdd_bit != -1) {
>                 spin_unlock_irqrestore(&host->lock, flags);
> -               mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd_bit);
> +               mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd_bit);
>                 spin_lock_irqsave(&host->lock, flags);
>         }
>
> @@ -1742,6 +1744,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>                                                 struct mmc_ios *ios)
>  {
> +       struct mmc_host *mmc = host->mmc;
>         u16 ctrl;
>         int ret;
>
> @@ -1760,8 +1763,9 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>                 ctrl &= ~SDHCI_CTRL_VDD_180;
>                 sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>
> -               if (host->vqmmc) {
> -                       ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
> +                                                   3600000);
>                         if (ret) {
>                                 pr_warning("%s: Switching to 3.3V signalling voltage "
>                                                 " failed\n", mmc_hostname(host->mmc));
> @@ -1781,8 +1785,8 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>
>                 return -EAGAIN;
>         case MMC_SIGNAL_VOLTAGE_180:
> -               if (host->vqmmc) {
> -                       ret = regulator_set_voltage(host->vqmmc,
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       ret = regulator_set_voltage(mmc->supply.vqmmc,
>                                         1700000, 1950000);
>                         if (ret) {
>                                 pr_warning("%s: Switching to 1.8V signalling voltage "
> @@ -1811,8 +1815,9 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>
>                 return -EAGAIN;
>         case MMC_SIGNAL_VOLTAGE_120:
> -               if (host->vqmmc) {
> -                       ret = regulator_set_voltage(host->vqmmc, 1100000, 1300000);
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
> +                                                   1300000);
>                         if (ret) {
>                                 pr_warning("%s: Switching to 1.2V signalling voltage "
>                                                 " failed\n", mmc_hostname(host->mmc));
> @@ -2975,25 +2980,22 @@ int sdhci_add_host(struct sdhci_host *host)
>             !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
> +       /* If there are external regulators, get them */
> +       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +
>         /* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
> -       host->vqmmc = regulator_get_optional(mmc_dev(mmc), "vqmmc");
> -       if (IS_ERR_OR_NULL(host->vqmmc)) {
> -               if (PTR_ERR(host->vqmmc) < 0) {
> -                       pr_info("%s: no vqmmc regulator found\n",
> -                               mmc_hostname(mmc));
> -                       host->vqmmc = NULL;
> -               }
> -       } else {
> -               ret = regulator_enable(host->vqmmc);
> -               if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
> -                       1950000))
> +       if (!IS_ERR(mmc->supply.vqmmc)) {
> +               ret = regulator_enable(mmc->supply.vqmmc);
> +               if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
> +                                                   1950000))
>                         caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
>                                         SDHCI_SUPPORT_SDR50 |
>                                         SDHCI_SUPPORT_DDR50);
>                 if (ret) {
>                         pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
>                                 mmc_hostname(mmc), ret);
> -                       host->vqmmc = NULL;
> +                       mmc->supply.vqmmc = NULL;
>                 }
>         }
>
> @@ -3054,34 +3056,6 @@ int sdhci_add_host(struct sdhci_host *host)
>
>         ocr_avail = 0;
>
> -       host->vmmc = regulator_get_optional(mmc_dev(mmc), "vmmc");
> -       if (IS_ERR_OR_NULL(host->vmmc)) {
> -               if (PTR_ERR(host->vmmc) < 0) {
> -                       pr_info("%s: no vmmc regulator found\n",
> -                               mmc_hostname(mmc));
> -                       host->vmmc = NULL;
> -               }
> -       }
> -
> -#ifdef CONFIG_REGULATOR
> -       /*
> -        * Voltage range check makes sense only if regulator reports
> -        * any voltage value.
> -        */
> -       if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
> -               ret = regulator_is_supported_voltage(host->vmmc, 2700000,
> -                       3600000);
> -               if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
> -                       caps[0] &= ~SDHCI_CAN_VDD_330;
> -               if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
> -                       caps[0] &= ~SDHCI_CAN_VDD_300;
> -               ret = regulator_is_supported_voltage(host->vmmc, 1700000,
> -                       1950000);
> -               if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
> -                       caps[0] &= ~SDHCI_CAN_VDD_180;
> -       }
> -#endif /* CONFIG_REGULATOR */
> -
>         /*
>          * According to SD Host Controller spec v3.00, if the Host System
>          * can afford more than 150mA, Host Driver should set XPC to 1. Also
> @@ -3090,8 +3064,8 @@ int sdhci_add_host(struct sdhci_host *host)
>          * value.
>          */
>         max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
> -       if (!max_current_caps && host->vmmc) {
> -               u32 curr = regulator_get_current_limit(host->vmmc);
> +       if (!max_current_caps && !IS_ERR(mmc->supply.vmmc)) {
> +               u32 curr = regulator_get_current_limit(mmc->supply.vmmc);
>                 if (curr > 0) {
>
>                         /* convert to SDHCI_MAX_CURRENT format */
> @@ -3131,8 +3105,11 @@ int sdhci_add_host(struct sdhci_host *host)
>                                    SDHCI_MAX_CURRENT_MULTIPLIER;
>         }
>
> +       if (mmc->ocr_avail)
> +               ocr_avail &= mmc->ocr_avail;
> +
>         if (host->ocr_mask)
> -               ocr_avail = host->ocr_mask;
> +               ocr_avail &= host->ocr_mask;
>
>         mmc->ocr_avail = ocr_avail;
>         mmc->ocr_avail_sdio = ocr_avail;
> @@ -3288,6 +3265,7 @@ EXPORT_SYMBOL_GPL(sdhci_add_host);
>
>  void sdhci_remove_host(struct sdhci_host *host, int dead)
>  {
> +       struct mmc_host *mmc = host->mmc;
>         unsigned long flags;
>
>         if (dead) {
> @@ -3325,15 +3303,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>         tasklet_kill(&host->card_tasklet);
>         tasklet_kill(&host->finish_tasklet);
>
> -       if (host->vmmc) {
> -               regulator_disable(host->vmmc);
> -               regulator_put(host->vmmc);
> -       }
> +       if (!IS_ERR(mmc->supply.vmmc))
> +               regulator_disable(mmc->supply.vmmc);
>
> -       if (host->vqmmc) {
> -               regulator_disable(host->vqmmc);
> -               regulator_put(host->vqmmc);
> -       }
> +       if (!IS_ERR(mmc->supply.vqmmc))
> +               regulator_disable(mmc->supply.vqmmc);
>
>         kfree(host->adma_desc);
>         kfree(host->align_buffer);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 7be12b8..0e3c3f8 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -108,9 +108,6 @@ struct sdhci_host {
>
>         const struct sdhci_ops *ops;    /* Low level hw interface */
>
> -       struct regulator *vmmc;         /* Power regulator (vmmc) */
> -       struct regulator *vqmmc;        /* Signaling regulator (vccq) */
> -
>         /* Internal data */
>         struct mmc_host *mmc;   /* MMC structure */
>         u64 dma_mask;           /* custom DMA mask */
> --
> 1.7.9.5
>
