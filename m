From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Fri, 6 Mar 2015 13:51:23 +0100
Message-ID: <CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33580 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbCFMvY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2015 07:51:24 -0500
Received: by qgef51 with SMTP id f51so12157707qge.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2015 04:51:24 -0800 (PST)
In-Reply-To: <1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 29 January 2015 at 10:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Make use of mmc core support for re-tuning instead
> of doing it all in the sdhci driver.
>
> This patch also changes to flag the need for re-tuning
> always after runtime suspend when tuning has been used
> at initialization. Previously it was only done if
> the re-tuning timer was in use.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c  | 113 ++++++----------------------------------------
>  include/linux/mmc/sdhci.h |   3 --
>  2 files changed, 14 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c9881ca..dd0be76 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -51,7 +51,6 @@ static void sdhci_finish_data(struct sdhci_host *);
>
>  static void sdhci_finish_command(struct sdhci_host *);
>  static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> -static void sdhci_tuning_timer(unsigned long data);
>  static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>  static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>                                         struct mmc_data *data,
> @@ -252,17 +251,6 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
>         sdhci_init(host, 0);
> -       /*
> -        * Retuning stuffs are affected by different cards inserted and only
> -        * applicable to UHS-I cards. So reset these fields to their initial
> -        * value when card is removed.
> -        */
> -       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> -               host->flags &= ~SDHCI_USING_RETUNING_TIMER;
> -
> -               del_timer_sync(&host->tuning_timer);
> -               host->flags &= ~SDHCI_NEEDS_RETUNING;
> -       }
>         sdhci_enable_card_detection(host);
>  }
>
> @@ -1350,7 +1338,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         struct sdhci_host *host;
>         int present;
>         unsigned long flags;
> -       u32 tuning_opcode;
>
>         host = mmc_priv(mmc);
>
> @@ -1399,39 +1386,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 host->mrq->cmd->error = -ENOMEDIUM;
>                 tasklet_schedule(&host->finish_tasklet);
>         } else {
> -               u32 present_state;
> -
> -               present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -               /*
> -                * Check if the re-tuning timer has already expired and there
> -                * is no on-going data transfer and DAT0 is not busy. If so,
> -                * we need to execute tuning procedure before sending command.
> -                */
> -               if ((host->flags & SDHCI_NEEDS_RETUNING) &&
> -                   !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ)) &&
> -                   (present_state & SDHCI_DATA_0_LVL_MASK)) {
> -                       if (mmc->card) {
> -                               /* eMMC uses cmd21 but sd and sdio use cmd19 */
> -                               tuning_opcode =
> -                                       mmc->card->type == MMC_TYPE_MMC ?
> -                                       MMC_SEND_TUNING_BLOCK_HS200 :
> -                                       MMC_SEND_TUNING_BLOCK;
> -
> -                               /* Here we need to set the host->mrq to NULL,
> -                                * in case the pending finish_tasklet
> -                                * finishes it incorrectly.
> -                                */
> -                               host->mrq = NULL;
> -
> -                               spin_unlock_irqrestore(&host->lock, flags);
> -                               sdhci_execute_tuning(mmc, tuning_opcode);
> -                               spin_lock_irqsave(&host->lock, flags);
> -
> -                               /* Restore original mmc_request structure */
> -                               host->mrq = mrq;
> -                       }
> -               }
> -
>                 if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
>                         sdhci_send_command(host, mrq->sbc);
>                 else
> @@ -2077,23 +2031,19 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         }
>
>  out:
> -       host->flags &= ~SDHCI_NEEDS_RETUNING;
> -
>         if (tuning_count) {
> -               host->flags |= SDHCI_USING_RETUNING_TIMER;
> -               mod_timer(&host->tuning_timer, jiffies + tuning_count * HZ);
> +               /*
> +                * In case tuning fails, host controllers which support
> +                * re-tuning can try tuning again at a later time, when the
> +                * re-tuning timer expires.  So for these controllers, we
> +                * return 0. Since there might be other controllers who do not
> +                * have this capability, we return error for them.
> +                */
> +               err = 0;
>         }
>
> -       /*
> -        * In case tuning fails, host controllers which support re-tuning can
> -        * try tuning again at a later time, when the re-tuning timer expires.
> -        * So for these controllers, we return 0. Since there might be other
> -        * controllers who do not have this capability, we return error for
> -        * them. SDHCI_USING_RETUNING_TIMER means the host is currently using
> -        * a retuning timer to do the retuning for the card.
> -        */
> -       if (err && (host->flags & SDHCI_USING_RETUNING_TIMER))
> -               err = 0;
> +       if (!err)
> +               mmc_retune_enable(host->mmc, tuning_count);
>
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> @@ -2349,20 +2299,6 @@ static void sdhci_timeout_timer(unsigned long data)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> -static void sdhci_tuning_timer(unsigned long data)
> -{
> -       struct sdhci_host *host;
> -       unsigned long flags;
> -
> -       host = (struct sdhci_host *)data;
> -
> -       spin_lock_irqsave(&host->lock, flags);
> -
> -       host->flags |= SDHCI_NEEDS_RETUNING;
> -
> -       spin_unlock_irqrestore(&host->lock, flags);
> -}
> -
>  /*****************************************************************************\
>   *                                                                           *
>   * Interrupt handling                                                        *
> @@ -2740,11 +2676,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  {
>         sdhci_disable_card_detection(host);
>
> -       /* Disable tuning since we are suspending */
> -       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> -               del_timer_sync(&host->tuning_timer);
> -               host->flags &= ~SDHCI_NEEDS_RETUNING;
> -       }
> +       mmc_retune_timer_stop(host->mmc);
> +       mmc_retune_needed(host->mmc);
>
>         if (!device_may_wakeup(mmc_dev(host->mmc))) {
>                 host->ier = 0;
> @@ -2794,10 +2727,6 @@ int sdhci_resume_host(struct sdhci_host *host)
>
>         sdhci_enable_card_detection(host);
>
> -       /* Set the re-tuning expiration flag */
> -       if (host->flags & SDHCI_USING_RETUNING_TIMER)
> -               host->flags |= SDHCI_NEEDS_RETUNING;
> -
>         return ret;
>  }
>
> @@ -2834,11 +2763,8 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  {
>         unsigned long flags;
>
> -       /* Disable tuning since we are suspending */
> -       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> -               del_timer_sync(&host->tuning_timer);
> -               host->flags &= ~SDHCI_NEEDS_RETUNING;
> -       }
> +       mmc_retune_timer_stop(host->mmc);

I think this could give a deadlock.

What if the retuning is just about to start and thus sdhci's
->execute_tuning() callback has been invoked, which is waiting for the
pm_runtime_get_sync() to return.

> +       mmc_retune_needed(host->mmc);

This seems racy.

What if a new request has already been started from the mmc core
(waiting for sdhci's ->request() callback to return). That would mean
the mmc core won't detect that a retune was needed.

>
>         spin_lock_irqsave(&host->lock, flags);
>         host->ier &= SDHCI_INT_CARD_INT;
> @@ -2881,10 +2807,6 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>                 spin_unlock_irqrestore(&host->lock, flags);
>         }
>
> -       /* Set the re-tuning expiration flag */
> -       if (host->flags & SDHCI_USING_RETUNING_TIMER)
> -               host->flags |= SDHCI_NEEDS_RETUNING;
> -
>         spin_lock_irqsave(&host->lock, flags);
>
>         host->runtime_suspended = false;
> @@ -3419,13 +3341,6 @@ int sdhci_add_host(struct sdhci_host *host)
>
>         init_waitqueue_head(&host->buf_ready_int);
>
> -       if (host->version >= SDHCI_SPEC_300) {
> -               /* Initialize re-tuning timer */
> -               init_timer(&host->tuning_timer);
> -               host->tuning_timer.data = (unsigned long)host;
> -               host->tuning_timer.function = sdhci_tuning_timer;
> -       }
> -
>         sdhci_init(host, 0);
>
>         ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index c3e3db1..c5b00be 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -138,13 +138,11 @@ struct sdhci_host {
>  #define SDHCI_REQ_USE_DMA      (1<<2)  /* Use DMA for this req. */
>  #define SDHCI_DEVICE_DEAD      (1<<3)  /* Device unresponsive */
>  #define SDHCI_SDR50_NEEDS_TUNING (1<<4)        /* SDR50 needs tuning */
> -#define SDHCI_NEEDS_RETUNING   (1<<5)  /* Host needs retuning */
>  #define SDHCI_AUTO_CMD12       (1<<6)  /* Auto CMD12 support */
>  #define SDHCI_AUTO_CMD23       (1<<7)  /* Auto CMD23 support */
>  #define SDHCI_PV_ENABLED       (1<<8)  /* Preset value enabled */
>  #define SDHCI_SDIO_IRQ_ENABLED (1<<9)  /* SDIO irq enabled */
>  #define SDHCI_SDR104_NEEDS_TUNING (1<<10)      /* SDR104/HS200 needs tuning */
> -#define SDHCI_USING_RETUNING_TIMER (1<<11)     /* Host is using a retuning timer for the card */
>  #define SDHCI_USE_64_BIT_DMA   (1<<12) /* Use 64-bit DMA */
>  #define SDHCI_HS400_TUNING     (1<<13) /* Tuning for HS400 */
>
> @@ -210,7 +208,6 @@ struct sdhci_host {
>         unsigned int            tuning_count;   /* Timer count for re-tuning */
>         unsigned int            tuning_mode;    /* Re-tuning mode supported by host */
>  #define SDHCI_TUNING_MODE_1    0
> -       struct timer_list       tuning_timer;   /* Timer for tuning */
>
>         struct sdhci_host_next  next_data;
>         unsigned long private[0] ____cacheline_aligned;
> --
> 1.9.1
>

Kind regards
Uffe
