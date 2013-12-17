From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC] mmc: add an option to unlimit erase group count
Date: Tue, 17 Dec 2013 12:19:37 +0100
Message-ID: <CAPDyKFqPORwQ2ADZdt5Bq81iS0pzZnnPkA2FaCv8ZvPeFx1J8A@mail.gmail.com>
References: <1387273586-6839-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:59737 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3LQLTi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 06:19:38 -0500
Received: by mail-qa0-f52.google.com with SMTP id cm18so2482391qab.18
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 03:19:38 -0800 (PST)
In-Reply-To: <1387273586-6839-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 17 December 2013 10:46, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> This change adds an option to overcome a hardcoded calculation of
> maximum erase groups to be used for erase/trim/discard operations.
> This calculation is plainly based on JEDEC spec, which defines
> too high erase timeout delays in comparison to SDHC data line timeout.

Too high? Should they lye about the timeout instead? :-)

>
> JEDEC specification defines quite high erase timeout value for 300ms
> multiplied by erase group number, and SD Host Controller specification
> data line timeout may be much less, e.g. (1 << 13) / 52Mhz ~ 160ms.
>
> From perfromance perspective it is desirable that thousands of erase
> groups are discarded at once, so there is no much sense to limit
> maximum erase timeout by data line timeout, if a controller handles
> correctly erase operation without indication of data line timeout.
>
> In addition setting of this option allows to erase/trim/discard MMC
> cards, for which previously it was reported that ioctl(BLKDISCARD) is
> not supported, because the currently implemented logic assumes that
> erase/trim/discard is supported only if data line timeout can be set
> higher than the erase timeout of one erase group.
>
> Note, it is possible to change mmc_core.limit_erase_groups after
> kernel load, but it will have no effect, because mmc block queue
> setup and timeout calculations are done only once during mmc_core
> initialization.

No, I don't believe this is the correct approach.

The timeout you refer to, is not a data line timeout and it is not cmd
timeout either. The timeout is the busy signalling timeout or in other
words, the maximum time the card is allowed to stay busy.

So I would suggest an approach which in the end will remove
"cmd_timeout_ms" from the mmc_cmd struct, since it should not be
needed. Additionally I think SDHCI is abusing it.

Instead a timeout should be used while polling the card status
(CMD13), to make sure the card has completed it's operation as
expected, typically handled from mmc_do_erase() and __mmc_switch().

Kind regards
Ulf Hansson


>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/Kconfig |   14 ++++++++++++++
>  drivers/mmc/core/core.c  |   11 +++++++++++
>  drivers/mmc/host/sdhci.c |   14 +++++++++++---
>  include/linux/mmc/host.h |    1 +
>  4 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 269d072..9ecdde1 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -26,3 +26,17 @@ config MMC_CLKGATE
>           support handling this in order for it to be of any use.
>
>           If unsure, say N.
> +
> +config MMC_UNLIMIT_ERASE_GROUPS
> +       bool "Assume fast erase/trim/discard operation (EXPERIMENTAL)"
> +       depends on EXPERIMENTAL
> +       help
> +         This option will disable limitation on maximum quantity of
> +         erase groups to be erased/trimmed/discarded safely without
> +         getting a timeout on DAT0 line. On old cards enabling of
> +         this option may be unsafe, but modern eMMC cards are capable
> +         to complete the operations in reasonable time regardless of
> +         extremely overestimated timeout for the operations specified
> +         by JEDEC standard.
> +
> +         If unsure, say N.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 57a2b40..40db797 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -81,6 +81,17 @@ MODULE_PARM_DESC(
>         removable,
>         "MMC/SD cards are removable and may be removed during suspend");
>
> +#ifdef MMC_UNLIMIT_ERASE_GROUPS
> +bool mmc_limit_erase_groups;
> +#else
> +bool mmc_limit_erase_groups = 1;
> +#endif
> +EXPORT_SYMBOL(mmc_limit_erase_groups);
> +module_param_named(limit_erase_groups, mmc_limit_erase_groups, bool, 0644);
> +MODULE_PARM_DESC(
> +       limit_erase_groups,
> +       "Erase group limitation is calculated from host's data line timeout");
> +
>  /*
>   * Internal function. Schedule delayed work in the MMC work queue.
>   */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..541e9af 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -736,8 +736,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>         WARN_ON(host->data);
>
>         if (data || (cmd->flags & MMC_RSP_BUSY)) {
> -               count = sdhci_calc_timeout(host, cmd);
> -               sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> +               if (cmd->opcode == MMC_ERASE && !mmc_limit_erase_groups) {
> +                       sdhci_mask_irqs(host, SDHCI_INT_TIMEOUT);
> +               } else {
> +                       sdhci_unmask_irqs(host, SDHCI_INT_TIMEOUT);
> +                       count = sdhci_calc_timeout(host, cmd);
> +                       sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> +               }
>         }
>
>         if (!data)
> @@ -2930,7 +2935,10 @@ int sdhci_add_host(struct sdhci_host *host)
>         if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>                 host->timeout_clk = mmc->f_max / 1000;
>
> -       mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +       if (mmc_limit_erase_groups)
> +               mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +       else
> +               mmc->max_discard_to = 0;
>
>         mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 99f5709..7c93bb8 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -426,6 +426,7 @@ int mmc_pm_notify(struct notifier_block *notify_block, unsigned long, void *);
>
>  /* Module parameter */
>  extern bool mmc_assume_removable;
> +extern bool mmc_limit_erase_groups;
>
>  static inline int mmc_card_is_removable(struct mmc_host *host)
>  {
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
