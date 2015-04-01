From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Wed, 1 Apr 2015 11:50:52 +0200
Message-ID: <CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34150 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbDAJux (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2015 05:50:53 -0400
Received: by qgep97 with SMTP id p97so37571058qge.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2015 02:50:53 -0700 (PDT)
In-Reply-To: <1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 27 March 2015 at 21:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Currently, there is core support for tuning during
> initialization. There can also be a need to re-tune
> periodically (e.g. sdhci) or to re-tune after the
> host controller is powered off (e.g. after PM
> runtime suspend / resume) or to re-tune in response
> to CRC errors.
>
> The main requirements for re-tuning are:

It's a bit hard to follow why these requirements.

I am giving some comments below, also for my own reference. Please
tell me if I am way off.

>   - ability to enable / disable re-tuning

Handled internally by the mmc core.

Or maybe SDIO func drivers needs an API to control this?

>   - ability to flag that re-tuning is needed

Both from mmc core and mmc host point of view.

>   - ability to re-tune before any request

Internal mechanism by the core.

>   - ability to hold off re-tuning if the card is busy

What do you mean by "card is busy"?

Is this requirement due to that the re-tune timer may complete at any
point, which then flags that a re-tune is needed?

>   - ability to hold off re-tuning if re-tuning is in
>   progress

This I don't understand. How can a re-tune sequence be triggered when
there is already a request ongoing towards the host. I mean the host
is claimed during the re-tuning process, so why do we need one more
layer of protection?

>   - ability to run a re-tuning timer

As we discussed earlier, it's not obvious when it make sense to run this timer.

For the SDIO case, we should likely run it all the time, since we want
to prevent I/O errors as long as possible.

For MMC/SD, I would rather see that we perform re-tune as a part of an
"idle operation" and not from a timer (yes I know about the SDHCI
spec, but it doesn't make sense). We can do this because we are able
to re-cover from I/O errors (re-trying when getting CRC errors for
example).

I will continue to review the rest of series in more detail.

Kind regards
Uffe

>
> To support those requirements 6 members are added to struct
> mmc_host:
>
>   unsigned int          can_retune:1;   /* re-tuning can be used */
>   unsigned int          doing_retune:1; /* re-tuning in progress */
>   unsigned int          retune_now:1;   /* do re-tuning at next req */
>   int                   need_retune;    /* re-tuning is needed */
>   int                   hold_retune;    /* hold off re-tuning */
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
>  drivers/mmc/core/host.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h | 32 +++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8be0df7..ce0ddf7 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -301,6 +301,77 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
>
>  #endif
>
> +void mmc_retune_enable(struct mmc_host *host, unsigned int period)
> +{
> +       host->can_retune = 1;
> +       if (period)
> +               mod_timer(&host->retune_timer, jiffies + period * HZ);
> +}
> +EXPORT_SYMBOL(mmc_retune_enable);
> +
> +void mmc_retune_disable(struct mmc_host *host)
> +{
> +       host->can_retune = 0;
> +       del_timer_sync(&host->retune_timer);
> +       host->retune_now = 0;
> +       host->need_retune = 0;
> +}
> +EXPORT_SYMBOL(mmc_retune_disable);
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
> +EXPORT_SYMBOL(mmc_retune_hold);
> +
> +void mmc_retune_release(struct mmc_host *host)
> +{
> +       if (host->hold_retune)
> +               host->hold_retune -= 1;
> +       else
> +               WARN_ON(1);
> +}
> +EXPORT_SYMBOL(mmc_retune_release);
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
> +EXPORT_SYMBOL(mmc_retune);
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
> @@ -504,6 +575,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  #ifdef CONFIG_PM
>         host->pm_notify.notifier_call = mmc_pm_notify;
>  #endif
> +       setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
>
>         /*
>          * By default, hosts do not support SGIO or large requests.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index b5bedae..f8957eb 100644
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
> @@ -321,10 +322,17 @@ struct mmc_host {
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
> +       struct timer_list       retune_timer;   /* for periodic re-tuning */
> +
>         bool                    trigger_card_event; /* card_event necessary */
>
>         struct mmc_card         *card;          /* device attached to this host */
> @@ -513,4 +521,28 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
>         return card->host->ios.timing == MMC_TIMING_MMC_HS400;
>  }
>
> +void mmc_retune_enable(struct mmc_host *host, unsigned int period);
> +void mmc_retune_disable(struct mmc_host *host);
> +void mmc_retune_timer_stop(struct mmc_host *host);
> +void mmc_retune_hold(struct mmc_host *host);
> +void mmc_retune_release(struct mmc_host *host);
> +int mmc_retune(struct mmc_host *host);
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
> +
> +static inline void mmc_retune_recheck(struct mmc_host *host)
> +{
> +       if (host->hold_retune <= 1)
> +               host->retune_now = 1;
> +}
> +
>  #endif /* LINUX_MMC_HOST_H */
> --
> 1.9.1
>
