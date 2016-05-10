From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/3] mmc: core: Add a facility to "pause" re-tuning
Date: Tue, 10 May 2016 14:24:32 +0200
Message-ID: <CAPDyKFrg3Fe8ypdzrbxD5DxHBNs7-6yVma-7X7NY4JfNzVzGPQ@mail.gmail.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
	<1462361893-11897-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35942 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcEJMYe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 08:24:34 -0400
Received: by mail-wm0-f41.google.com with SMTP id n129so176212038wmn.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 05:24:33 -0700 (PDT)
In-Reply-To: <1462361893-11897-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 4 May 2016 at 13:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
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
>  drivers/mmc/core/host.c  | 22 ++++++++++++++++++++++
>  include/linux/mmc/host.h |  4 ++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index e0a3ee16c0d3..302e5858755a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -68,8 +68,30 @@ void mmc_retune_enable(struct mmc_host *host)
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
> +

When the mmc block device driver is built as a module, this doesn't
build. I will drop the series from my next branch to sort this out.

Should we export these via EXPORT_SYMBOL_GPL, or implement them as
inline functions?

This also made me think about the SDIO/WLAN driver issue, during
system PM suspend/resume, which also needed temporary to disable
re-tuning.

*If* we are going to export these, I want to make it works for the
SDIO case well...

Kind regards
Uffe

> +void mmc_retune_unpause(struct mmc_host *host)
> +{
> +       if (host->retune_paused) {
> +               host->retune_paused = 0;
> +               mmc_retune_release(host);
> +       }
> +}
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
