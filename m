From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 01/15] mmc: host: Add facility to support re-tuning
Date: Mon, 4 May 2015 15:14:22 +0200
Message-ID: <CAPDyKFpytH=Kh0N7hM988c5GGELpU45MRrocyewVx_hphzku2g@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32920 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbEDNOX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 09:14:23 -0400
Received: by qkx62 with SMTP id 62so84163918qkx.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2015 06:14:22 -0700 (PDT)
In-Reply-To: <1429531796-21987-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Currently, there is core support for tuning during
> initialization. There can also be a need to re-tune
> periodically (e.g. sdhci) or to re-tune after the
> host controller is powered off (e.g. after PM
> runtime suspend / resume) or to re-tune in response
> to CRC errors.
>
> The main requirements for re-tuning are:
>   - ability to enable / disable re-tuning
>   - ability to flag that re-tuning is needed
>   - ability to re-tune before any request
>   - ability to hold off re-tuning if the card is busy
>   - ability to hold off re-tuning if re-tuning is in
>   progress
>   - ability to run a re-tuning timer
>
> To support those requirements 7 members are added to struct
> mmc_host:
>
>   unsigned int          can_retune:1;   /* re-tuning can be used */
>   unsigned int          doing_retune:1; /* re-tuning in progress */
>   unsigned int          retune_now:1;   /* do re-tuning at next req */
>   int                   need_retune;    /* re-tuning is needed */
>   int                   hold_retune;    /* hold off re-tuning */
>   unsigned int          retune_period;  /* re-tuning period in secs */
>   struct timer_list     retune_timer;   /* for periodic re-tuning */
>
> need_retune is an integer so it can be set without needing
> synchronization. hold_retune is a integer to allow nesting.
>
> Various simple functions are provided to set / clear those
> variables.
>
> Subsequent patches take those functions into use.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/host.c  | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/host.h  |  6 +++++
>  include/linux/mmc/host.h | 28 ++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8be0df7..e90e02f 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -301,6 +301,73 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
>
>  #endif
>
> +void mmc_retune_enable(struct mmc_host *host)
> +{
> +       host->can_retune = 1;
> +       if (host->retune_period)
> +               mod_timer(&host->retune_timer,
> +                         jiffies + host->retune_period * HZ);
> +}
> +
> +void mmc_retune_disable(struct mmc_host *host)
> +{
> +       host->can_retune = 0;
> +       del_timer_sync(&host->retune_timer);
> +       host->retune_now = 0;
> +       host->need_retune = 0;
> +}
> +
> +void mmc_retune_timer_stop(struct mmc_host *host)
> +{
> +       del_timer_sync(&host->retune_timer);
> +}
> +EXPORT_SYMBOL(mmc_retune_timer_stop);
> +
> +void mmc_retune_hold(struct mmc_host *host)
> +{
> +       if (!host->hold_retune)
> +               host->retune_now = 1;
> +       host->hold_retune += 1;
> +}
> +
> +void mmc_retune_release(struct mmc_host *host)
> +{
> +       if (host->hold_retune)
> +               host->hold_retune -= 1;
> +       else
> +               WARN_ON(1);
> +}
> +
> +int mmc_retune(struct mmc_host *host)
> +{
> +       int err;
> +
> +       if (host->retune_now)
> +               host->retune_now = 0;
> +       else
> +               return 0;
> +
> +       if (!host->need_retune || host->doing_retune || !host->card)
> +               return 0;
> +
> +       host->need_retune = 0;
> +
> +       host->doing_retune = 1;
> +
> +       err = mmc_execute_tuning(host->card);
> +
> +       host->doing_retune = 0;
> +
> +       return err;
> +}
> +
> +static void mmc_retune_timer(unsigned long data)
> +{
> +       struct mmc_host *host = (struct mmc_host *)data;
> +
> +       mmc_retune_needed(host);
> +}
> +
>  /**
>   *     mmc_of_parse() - parse host's device-tree node
>   *     @host: host whose node should be parsed.
> @@ -504,6 +571,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  #ifdef CONFIG_PM
>         host->pm_notify.notifier_call = mmc_pm_notify;
>  #endif
> +       setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
>
>         /*
>          * By default, hosts do not support SGIO or large requests.
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index f2ab9e5..992bf53 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -15,5 +15,11 @@
>  int mmc_register_host_class(void);
>  void mmc_unregister_host_class(void);
>
> +void mmc_retune_enable(struct mmc_host *host);
> +void mmc_retune_disable(struct mmc_host *host);
> +void mmc_retune_hold(struct mmc_host *host);
> +void mmc_retune_release(struct mmc_host *host);
> +int mmc_retune(struct mmc_host *host);
> +
>  #endif
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index b5bedae..9c9e51b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -12,6 +12,7 @@
>
>  #include <linux/leds.h>
>  #include <linux/mutex.h>
> +#include <linux/timer.h>
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/fault-inject.h>
> @@ -321,10 +322,18 @@ struct mmc_host {
>  #ifdef CONFIG_MMC_DEBUG
>         unsigned int            removed:1;      /* host is being removed */
>  #endif
> +       unsigned int            can_retune:1;   /* re-tuning can be used */
> +       unsigned int            doing_retune:1; /* re-tuning in progress */
> +       unsigned int            retune_now:1;   /* do re-tuning at next req */
>
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
>
> +       int                     need_retune;    /* re-tuning is needed */
> +       int                     hold_retune;    /* hold off re-tuning */
> +       unsigned int            retune_period;  /* re-tuning period in secs */
> +       struct timer_list       retune_timer;   /* for periodic re-tuning */
> +
>         bool                    trigger_card_event; /* card_event necessary */
>
>         struct mmc_card         *card;          /* device attached to this host */
> @@ -513,4 +522,23 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
>         return card->host->ios.timing == MMC_TIMING_MMC_HS400;
>  }
>
> +void mmc_retune_timer_stop(struct mmc_host *host);
> +
> +static inline void mmc_retune_needed(struct mmc_host *host)
> +{
> +       if (host->can_retune)
> +               host->need_retune = 1;
> +}
> +
> +static inline void mmc_retune_not_needed(struct mmc_host *host)
> +{
> +       host->need_retune = 0;
> +}

This function isn't required and has no users. Let's remove it.

> +
> +static inline void mmc_retune_recheck(struct mmc_host *host)
> +{
> +       if (host->hold_retune <= 1)
> +               host->retune_now = 1;
> +}
> +
>  #endif /* LINUX_MMC_HOST_H */

Kind regards
Uffe
