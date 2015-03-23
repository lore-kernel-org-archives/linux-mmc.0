From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4] mmc: sdio: support switching to 1-bit before turning
 off clocks
Date: Mon, 23 Mar 2015 10:10:18 +0100
Message-ID: <CAPDyKFrt-rhsh4XAHma=F083Y-XYxJbGyLUEEh1C6KUni-RZ7g@mail.gmail.com>
References: <20150224024023.22719.32436.stgit@notabene.brown>
	<20150224024223.22719.91536.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33626 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbbCWJKS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2015 05:10:18 -0400
Received: by qgfa8 with SMTP id a8so140621432qgf.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2015 02:10:18 -0700 (PDT)
In-Reply-To: <20150224024223.22719.91536.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 24 February 2015 at 03:42, NeilBrown <neilb@suse.de> wrote:
> According to section 7.1.2 of
>
> http://www.sandisk.com/media/File/OEM/Manuals/SD_SDIO_specsv1.pdf
>
>     In the case where the interrupt mechanism is used to wake the host while
>     the card is in a low power state (i.e. no clocks), Both the card and the
>     host shall be placed into the 1-bit SD mode prior to stopping the clock.
>
> This is particularly important for the Marvell "libertas" wifi chip
> in the GTA04.  While in 4-bit mode it will only signal an interrupt
> when the clock is running (which is why setting CLKEXTFREE is
> important).
> In 1-bit mode, the interrupt is asynchronous (explained in OMAP3
> TRM description of the CIRQ flag to MMCHS_STAT:
>
>   In 1-bit mode, interrupt source is asynchronous (can be a source of
>   asynchronous wakeup).
>   In 4-bit mode, interrupt source is sampled during the interrupt
>   cycle.
>
> )
>
> It is awkward to simply set 1-bit mode in ->runtime_suspend
> as that will call mmc_set_ios which calls ops->set_ios(),
> which will likely call pm_runtime_get_sync(), on the device that
> is currently suspending.  This deadlocks.
>
> So:
>  - create a work_struct to schedule setting of 1-bit mode
>  - introduce an 'sdio_narrowed' state flag which transitions:
>      0 (normal) -> 1 (convert to 1-bit pending) ->
>          2 (have switch to 1-bit mode) -> 0 (normal)
>  - create a function mmc_sdio_want_no_clocks() which can be called
>    when the driver wants to turn off clocks (presumably after an
>    idle timeout).  This either succeeds (in 1-bit mode) or fails
>    and schedules the work to switch to 1-bit mode.
>  - when the host is claimed, if sdio_narrowed is 2, restore the
>    4-bit bus
>  - When the host is released, if sdio_narrowed is 1, then some
>    caller other  than our worker claimed the host first, so
>    clear sdio_narrowed.
>
> This all allows a graceful and race-free switch to 1-bit mode
> before switching off the clocks, if SDIO interrupts are enabled.
>
> A host should call mmc_sdio_want_no_clocks() when about to turn off
> clocks if sdio interrupts are enabled, and the ->disable() function
> should not use a timeout (pm_runtime_put_autosuspend) if
> ->sdio_narrowed is 2.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Hi Neil,

Thanks for sending this patchset, and sorry for the delay in response.

Overall I like the approach taken in this patchset, though I have some
questions see below.

> ---
>  drivers/mmc/core/core.c  |   18 ++++++++++++++----
>  drivers/mmc/core/sdio.c  |   42 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/core.h |    2 ++
>  include/linux/mmc/host.h |    2 ++
>  4 files changed, 59 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 541c8903dc6b..0258fdf1a03d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -921,8 +921,14 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>                 wake_up(&host->wq);
>         spin_unlock_irqrestore(&host->lock, flags);
>         remove_wait_queue(&host->wq, &wait);
> -       if (host->ops->enable && !stop && host->claim_cnt == 1)
> -               host->ops->enable(host);
> +       if (!stop && host->claim_cnt == 1) {
> +               if (host->ops->enable)
> +                       host->ops->enable(host);
> +               if (atomic_read(&host->sdio_narrowed) == 2) {
> +                       sdio_enable_4bit_bus(host->card);
> +                       atomic_set(&host->sdio_narrowed, 0);
> +               }
> +       }
>         return stop;
>  }
>
> @@ -941,8 +947,12 @@ void mmc_release_host(struct mmc_host *host)
>
>         WARN_ON(!host->claimed);
>
> -       if (host->ops->disable && host->claim_cnt == 1)
> -               host->ops->disable(host);
> +       if (host->claim_cnt == 1) {
> +               if (atomic_read(&host->sdio_narrowed) == 1)
> +                       atomic_set(&host->sdio_narrowed, 0);
> +               if (host->ops->disable)
> +                       host->ops->disable(host);
> +       }

As omap_hsmmc in currently the only user of the
host_ops->enable|disable() callbacks, I wonder if this approach will
work "race-free" for those hosts that don't implement these callbacks?

Also, I was kind of hoping that we should be able to remove these
host_ops callbacks, when omap_hsmmc has moved away from using them. Do
you think that can be done?

Within this context, I am also reviewing Adrian Hunter's patchset
around "periodic re-tuning" [1] and to me, you guys are sharing a
similar issue.

The host driver's runtime PM suspend callback needs to be able to
notify the mmc core to take some specific actions, and in a
"race-free" manner.

I wonder whether we could have one common solution to that? Do you
think this approach will work for Adrian's "periodic re-tuning" as
well?

>
>         spin_lock_irqsave(&host->lock, flags);
>         if (--host->claim_cnt) {
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 5bc6c7dbbd60..9761e4d5f49b 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -288,7 +288,7 @@ static int sdio_disable_wide(struct mmc_card *card)
>  }
>
>
> -static int sdio_enable_4bit_bus(struct mmc_card *card)
> +int sdio_enable_4bit_bus(struct mmc_card *card)
>  {
>         int err;
>
> @@ -313,6 +313,45 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
>         return err;
>  }
>
> +static void mmc_sdio_width_work(struct work_struct *work)
> +{
> +       struct mmc_host *host = container_of(work, struct mmc_host,
> +                                            sdio_width_work);
> +       atomic_t noblock;
> +
> +       atomic_set(&noblock, 1);
> +       if (__mmc_claim_host(host, &noblock))
> +               return;
> +       if (atomic_read(&host->sdio_narrowed) != 1) {
> +               /* Nothing to do */
> +               mmc_release_host(host);
> +               return;
> +       }
> +       if (sdio_disable_wide(host->card) == 0)
> +               atomic_set(&host->sdio_narrowed, 2);
> +       else
> +               atomic_set(&host->sdio_narrowed, 0);
> +       mmc_release_host(host);
> +}
> +
> +int mmc_sdio_want_no_clocks(struct mmc_host *host)
> +{
> +       if (!(host->caps & MMC_CAP_SDIO_IRQ) ||
> +           host->ios.bus_width == MMC_BUS_WIDTH_1)
> +               /* Safe to turn off clocks */
> +               return 1;
> +
> +
> +       /* In 4-bit mode the card needs the clock
> +        * to deliver interrupts, so it isn't safe
> +        * to turn of clocks just yet
> +        */
> +       atomic_add_unless(&host->sdio_narrowed, 1, 1);
> +
> +       schedule_work(&host->sdio_width_work);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_sdio_want_no_clocks);
>
>  /*
>   * Test if the card supports high-speed mode and, if so, switch to it.
> @@ -1100,6 +1139,7 @@ int mmc_attach_sdio(struct mmc_host *host)
>                 goto err;
>         }
>
> +       INIT_WORK(&host->sdio_width_work, mmc_sdio_width_work);
>         /*
>          * Detect and init the card.
>          */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 160448f920ac..faf6d1be0971 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -212,4 +212,6 @@ struct device_node;
>  extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>  extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
>
> +extern int sdio_enable_4bit_bus(struct mmc_card *card);
> +extern int mmc_sdio_want_no_clocks(struct mmc_host *host);
>  #endif /* LINUX_MMC_CORE_H */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0c8cbe5d1550..7e6a54c49a15 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -350,6 +350,8 @@ struct mmc_host {
>         struct task_struct      *sdio_irq_thread;
>         bool                    sdio_irq_pending;
>         atomic_t                sdio_irq_thread_abort;
> +       struct work_struct      sdio_width_work;
> +       atomic_t                sdio_narrowed; /* 1==pending, 2==complete*/
>
>         mmc_pm_flag_t           pm_flags;       /* requested pm features */
>
>
>

Kind regards
Uffe

[1]
[PATCH V3 00/15] mmc: host: Add facility to support re-tuning
http://www.spinics.net/lists/linux-mmc/msg31020.html
