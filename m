From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 1/3] mmc: core: Add a facility to "pause" re-tuning
Date: Tue, 17 May 2016 17:06:08 +0200
Message-ID: <CAPDyKFpjoWHXp=H0R6pPM9pvF5BuP49MhwVzBQgr+01SXGGYQg@mail.gmail.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
	<1462361893-11897-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrg3Fe8ypdzrbxD5DxHBNs7-6yVma-7X7NY4JfNzVzGPQ@mail.gmail.com>
	<5731DC12.4090906@intel.com>
	<CAPDyKFozyrzAPcw3v=XUEkMevLxxZ_AgHWXkwkYPN=AJkTAgXQ@mail.gmail.com>
	<5732F498.6090203@intel.com>
	<57341F2D.1020703@intel.com>
	<CAPDyKFqGo_MgBo=Xc74O6yi_rpZUWyK00wnBi7Ebdda0ejrwcA@mail.gmail.com>
	<573482FD.6040906@intel.com>
	<5739BE8C.3010403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38603 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcEQPGK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2016 11:06:10 -0400
Received: by mail-wm0-f43.google.com with SMTP id g17so36290898wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2016 08:06:09 -0700 (PDT)
In-Reply-To: <5739BE8C.3010403@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 16 May 2016 at 14:35, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Re-tuning is not possible when switched to the RPMB
> partition.  However re-tuning should not be needed
> if re-tuning is done immediately before switching,
> a small set of operations is done, and then we
> immediately switch back to the main partition.
>
> To ensure that re-tuning can't be done for a short
> while, add a facility to "pause" re-tuning.
>
> The existing facility to hold / release re-tuning
> is used but it also flags re-tuning as needed to cause
> re-tuning before the next command (which will be the
> switch to RPMB).
>
> We also need to "unpause" in the recovery path, which
> is catered for by adding it to mmc_retune_disable().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Thanks, re-applied the series with this v3 version of patch 1/3.

If the tests from kernelci and in linux-next works out okay, I intend
to send this as fixes for 4.7 rc1.

Kind regards
Uffe

>
>
> Changes in V3:
>
>         Added:
>                 EXPORT_SYMBOL(mmc_retune_pause);
>                 EXPORT_SYMBOL(mmc_retune_unpause);
>
> Changes in V2:
>
>         New approach entirely
>
>
>  drivers/mmc/core/host.c  | 24 ++++++++++++++++++++++++
>  include/linux/mmc/host.h |  4 ++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index e0a3ee16c0d3..1be42fab1a30 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -68,8 +68,32 @@ void mmc_retune_enable(struct mmc_host *host)
>                           jiffies + host->retune_period * HZ);
>  }
>
> +/*
> + * Pause re-tuning for a small set of operations.  The pause begins after the
> + * next command and after first doing re-tuning.
> + */
> +void mmc_retune_pause(struct mmc_host *host)
> +{
> +       if (!host->retune_paused) {
> +               host->retune_paused = 1;
> +               mmc_retune_needed(host);
> +               mmc_retune_hold(host);
> +       }
> +}
> +EXPORT_SYMBOL(mmc_retune_pause);
> +
> +void mmc_retune_unpause(struct mmc_host *host)
> +{
> +       if (host->retune_paused) {
> +               host->retune_paused = 0;
> +               mmc_retune_release(host);
> +       }
> +}
> +EXPORT_SYMBOL(mmc_retune_unpause);
> +
>  void mmc_retune_disable(struct mmc_host *host)
>  {
> +       mmc_retune_unpause(host);
>         host->can_retune = 0;
>         del_timer_sync(&host->retune_timer);
>         host->retune_now = 0;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 85800b48241f..45cde8cd39f2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -329,6 +329,7 @@ struct mmc_host {
>         unsigned int            can_retune:1;   /* re-tuning can be used */
>         unsigned int            doing_retune:1; /* re-tuning in progress */
>         unsigned int            retune_now:1;   /* do re-tuning at next req */
> +       unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
>
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
> @@ -526,4 +527,7 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
>                 host->retune_now = 1;
>  }
>
> +void mmc_retune_pause(struct mmc_host *host);
> +void mmc_retune_unpause(struct mmc_host *host);
> +
>  #endif /* LINUX_MMC_HOST_H */
> --
> 1.9.1
>
>
