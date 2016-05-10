From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/23] mmc: sdhci: removed unneeded function wrappers
Date: Tue, 10 May 2016 11:46:58 +0200
Message-ID: <CAPDyKFrr2753H=6kUOSxVJdUczsFufhhySKTpsk6VTSLy5_ULw@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38671 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbcEJJrA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 05:47:00 -0400
Received: by mail-wm0-f46.google.com with SMTP id g17so17154542wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 02:46:59 -0700 (PDT)
In-Reply-To: <1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <dongas86@gmail.com>

On 15 April 2016 at 19:29, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> After commit d6463f170cf0 ("mmc: sdhci: Remove redundant runtime PM calls"),
> some of original sdhci_do_xx() function wrappers becomes meaningless,
> so remove them.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 60 ++++++++++++------------------------------------
>  1 file changed, 15 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8e74e75..be52a3a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -53,7 +53,7 @@ static void sdhci_finish_data(struct sdhci_host *);
>  static void sdhci_finish_command(struct sdhci_host *);
>  static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> -static int sdhci_do_get_cd(struct sdhci_host *host);
> +static int sdhci_get_cd(struct mmc_host *mmc);
>
>  #ifdef CONFIG_PM
>  static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
> @@ -194,7 +194,7 @@ EXPORT_SYMBOL_GPL(sdhci_reset);
>  static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  {
>         if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> -               if (!sdhci_do_get_cd(host))
> +               if (!sdhci_get_cd(host->mmc))
>                         return;
>         }
>
> @@ -1393,11 +1393,11 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
>
> -static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
> +static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> +       struct sdhci_host *host = mmc_priv(mmc);
>         unsigned long flags;
>         u8 ctrl;
> -       struct mmc_host *mmc = host->mmc;
>
>         spin_lock_irqsave(&host->lock, flags);
>
> @@ -1551,16 +1551,10 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +static int sdhci_get_cd(struct mmc_host *mmc)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> -
> -       sdhci_do_set_ios(host, ios);
> -}
> -
> -static int sdhci_do_get_cd(struct sdhci_host *host)
> -{
> -       int gpio_cd = mmc_gpio_get_cd(host->mmc);
> +       int gpio_cd = mmc_gpio_get_cd(mmc);
>
>         if (host->flags & SDHCI_DEVICE_DEAD)
>                 return 0;
> @@ -1584,13 +1578,6 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
>         return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
>
> -static int sdhci_get_cd(struct mmc_host *mmc)
> -{
> -       struct sdhci_host *host = mmc_priv(mmc);
> -
> -       return sdhci_do_get_cd(host);
> -}
> -
>  static int sdhci_check_ro(struct sdhci_host *host)
>  {
>         unsigned long flags;
> @@ -1615,8 +1602,9 @@ static int sdhci_check_ro(struct sdhci_host *host)
>
>  #define SAMPLE_COUNT   5
>
> -static int sdhci_do_get_ro(struct sdhci_host *host)
> +static int sdhci_get_ro(struct mmc_host *mmc)
>  {
> +       struct sdhci_host *host = mmc_priv(mmc);
>         int i, ro_count;
>
>         if (!(host->quirks & SDHCI_QUIRK_UNSTABLE_RO_DETECT))
> @@ -1641,13 +1629,6 @@ static void sdhci_hw_reset(struct mmc_host *mmc)
>                 host->ops->hw_reset(host);
>  }
>
> -static int sdhci_get_ro(struct mmc_host *mmc)
> -{
> -       struct sdhci_host *host = mmc_priv(mmc);
> -
> -       return sdhci_do_get_ro(host);
> -}
> -
>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>  {
>         if (!(host->flags & SDHCI_DEVICE_DEAD)) {
> @@ -1677,10 +1658,10 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> -static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
> -                                               struct mmc_ios *ios)
> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +                                            struct mmc_ios *ios)
>  {
> -       struct mmc_host *mmc = host->mmc;
> +       struct sdhci_host *host = mmc_priv(mmc);
>         u16 ctrl;
>         int ret;
>
> @@ -1768,17 +1749,6 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>         }
>  }
>
> -static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> -       struct mmc_ios *ios)
> -{
> -       struct sdhci_host *host = mmc_priv(mmc);
> -
> -       if (host->version < SDHCI_SPEC_300)
> -               return 0;
> -
> -       return sdhci_do_start_signal_voltage_switch(host, ios);
> -}
> -
>  static int sdhci_card_busy(struct mmc_host *mmc)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -2070,7 +2040,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
>         if (host->ops->card_event)
>                 host->ops->card_event(host);
>
> -       present = sdhci_do_get_cd(host);
> +       present = sdhci_get_cd(host->mmc);
>
>         spin_lock_irqsave(&host->lock, flags);
>
> @@ -2643,7 +2613,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 sdhci_init(host, 0);
>                 host->pwr = 0;
>                 host->clock = 0;
> -               sdhci_do_set_ios(host, &host->mmc->ios);
> +               sdhci_set_ios(host->mmc, &host->mmc->ios);
>         } else {
>                 sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
>                 mmiowb();
> @@ -2721,8 +2691,8 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>         /* Force clock and power re-program */
>         host->pwr = 0;
>         host->clock = 0;
> -       sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
> -       sdhci_do_set_ios(host, &host->mmc->ios);
> +       sdhci_start_signal_voltage_switch(host->mmc, &host->mmc->ios);
> +       sdhci_set_ios(host->mmc, &host->mmc->ios);
>
>         if ((host_flags & SDHCI_PV_ENABLED) &&
>                 !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
> --
> 1.9.1
>
