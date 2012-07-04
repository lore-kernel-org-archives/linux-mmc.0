From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: A new flag SDHCI_USING_RETUNING_TIMER
Date: Wed, 4 Jul 2012 12:44:04 +0530
Message-ID: <CAGxe1ZGD1jVaMARAO2nu619Dj-ipb5x9c4zcu0ibyoycuaGiNw@mail.gmail.com>
References: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
	<1340957852-28936-3-git-send-email-aaron.lu@amd.com>
	<87vci45p5h.fsf@octavius.laptop.org>
	<20120704052909.GB2607@aarontestpc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35408 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab2GDHOF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jul 2012 03:14:05 -0400
Received: by qcro28 with SMTP id o28so4133953qcr.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jul 2012 00:14:04 -0700 (PDT)
In-Reply-To: <20120704052909.GB2607@aarontestpc.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Philip Rakity <prakity@marvell.com>

On 4 July 2012 10:59, Aaron Lu <aaron.lu@amd.com> wrote:
> Add a new flag of SDHCI_USING_RETUNING_TIMER to represent if the host
> is using a retuning timer for the card inserted.
>
> This flag is set when the host does tuning the first time for the card
> and the host's retuning mode is 1. This flag is used afterwards whenever
> needs to decide if the host is currently using a retuning timer.
>
> This flag is cleared when the card is removed in sdhci_reinit.
>
> The set/clear of the flag and the start/stop of the retuning timer is
> associated with the card's init/remove time, so there is no need to
> touch it when the host is to be removed as at that time the card should
> have already been removed.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> ---
> v3:
> Change the macro name from SDHCI_NEEDS_RETUNING_TIMER to
> SDHCI_USING_RETUNING_TIMER for better description of the flag as suggested
> by Chris Ball.
>
> v2:
> v1 mistakenly removed the line del_timer_sync(&host->timer) in
> sdhci_remove_host, fix this by adding back the code.
>
>  drivers/mmc/host/sdhci.c  | 30 ++++++++++++------------------
>  include/linux/mmc/sdhci.h |  1 +
>  2 files changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b0a5629..3ec4182 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -250,8 +250,9 @@ static void sdhci_reinit(struct sdhci_host *host)
>          * applicable to UHS-I cards. So reset these fields to their initial
>          * value when card is removed.
>          */
> -       if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
> -                       host->tuning_mode == SDHCI_TUNING_MODE_1) {
> +       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> +               host->flags &= ~SDHCI_USING_RETUNING_TIMER;
> +
>                 del_timer_sync(&host->tuning_timer);
>                 host->flags &= ~SDHCI_NEEDS_RETUNING;
>                 host->mmc->max_blk_count =
> @@ -1873,6 +1874,7 @@ out:
>          */
>         if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
>             (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
> +               host->flags |= SDHCI_USING_RETUNING_TIMER;
>                 mod_timer(&host->tuning_timer, jiffies +
>                         host->tuning_count * HZ);
>                 /* Tuning mode 1 limits the maximum data length to 4MB */
> @@ -1890,10 +1892,10 @@ out:
>          * try tuning again at a later time, when the re-tuning timer expires.
>          * So for these controllers, we return 0. Since there might be other
>          * controllers who do not have this capability, we return error for
> -        * them.
> +        * them. SDHCI_USING_RETUNING_TIMER means the host is currently using
> +        * a retuning timer to do the retuning for the card.
>          */
> -       if (err && host->tuning_count &&
> -           host->tuning_mode == SDHCI_TUNING_MODE_1)
> +       if (err && (host->flags & SDHCI_USING_RETUNING_TIMER))
>                 err = 0;
>
>         sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
> @@ -2400,7 +2402,6 @@ out:
>  int sdhci_suspend_host(struct sdhci_host *host)
>  {
>         int ret;
> -       bool has_tuning_timer;
>
>         if (host->ops->platform_suspend)
>                 host->ops->platform_suspend(host);
> @@ -2408,16 +2409,14 @@ int sdhci_suspend_host(struct sdhci_host *host)
>         sdhci_disable_card_detection(host);
>
>         /* Disable tuning since we are suspending */
> -       has_tuning_timer = host->version >= SDHCI_SPEC_300 &&
> -               host->tuning_count && host->tuning_mode == SDHCI_TUNING_MODE_1;
> -       if (has_tuning_timer) {
> +       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>                 del_timer_sync(&host->tuning_timer);
>                 host->flags &= ~SDHCI_NEEDS_RETUNING;
>         }
>
>         ret = mmc_suspend_host(host->mmc);
>         if (ret) {
> -               if (has_tuning_timer) {
> +               if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>                         host->flags |= SDHCI_NEEDS_RETUNING;
>                         mod_timer(&host->tuning_timer, jiffies +
>                                         host->tuning_count * HZ);
> @@ -2468,8 +2467,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 host->ops->platform_resume(host);
>
>         /* Set the re-tuning expiration flag */
> -       if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
> -           (host->tuning_mode == SDHCI_TUNING_MODE_1))
> +       if (host->flags & SDHCI_USING_RETUNING_TIMER)
>                 host->flags |= SDHCI_NEEDS_RETUNING;
>
>         return ret;
> @@ -2508,8 +2506,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>         int ret = 0;
>
>         /* Disable tuning since we are suspending */
> -       if (host->version >= SDHCI_SPEC_300 &&
> -           host->tuning_mode == SDHCI_TUNING_MODE_1) {
> +       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>                 del_timer_sync(&host->tuning_timer);
>                 host->flags &= ~SDHCI_NEEDS_RETUNING;
>         }
> @@ -2550,8 +2547,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>                 sdhci_do_enable_preset_value(host, true);
>
>         /* Set the re-tuning expiration flag */
> -       if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
> -           (host->tuning_mode == SDHCI_TUNING_MODE_1))
> +       if (host->flags & SDHCI_USING_RETUNING_TIMER)
>                 host->flags |= SDHCI_NEEDS_RETUNING;
>
>         spin_lock_irqsave(&host->lock, flags);
> @@ -3140,8 +3136,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>         free_irq(host->irq, host);
>
>         del_timer_sync(&host->timer);
> -       if (host->version >= SDHCI_SPEC_300)
> -               del_timer_sync(&host->tuning_timer);
>
>         tasklet_kill(&host->card_tasklet);
>         tasklet_kill(&host->finish_tasklet);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index d989b51..ac83b10 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -122,6 +122,7 @@ struct sdhci_host {
>  #define SDHCI_PV_ENABLED       (1<<8)  /* Preset value enabled */
>  #define SDHCI_SDIO_IRQ_ENABLED (1<<9)  /* SDIO irq enabled */
>  #define SDHCI_HS200_NEEDS_TUNING (1<<10)       /* HS200 needs tuning */
> +#define SDHCI_USING_RETUNING_TIMER (1<<11)     /* Host is using a retuning timer for the card */
>
>         unsigned int version;   /* SDHCI spec. version */
Looks good to me
Reviewed By:- Girish K S <girish.shivananjappa@linaro.org>
>
> --
> 1.7.11.1.3.g4c8a9db
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
