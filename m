From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Thu, 13 Oct 2016 09:36:23 +0200
Message-ID: <CAPDyKFpmbwNvx+00h=Aq-UAb9OLDtxrwr7N408L2pokxX+zgug@mail.gmail.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com> <1472739890-3384-4-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35240 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbcJMHiN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 03:38:13 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so72073705qkc.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 00:36:25 -0700 (PDT)
In-Reply-To: <1472739890-3384-4-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alex lemberg <alex.lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Avi Shchislowski <avi.shchislowski@sandisk.com>

On 1 September 2016 at 16:24, alex lemberg <alex.lemberg@sandisk.com> wrote:
> Rescheduling Suspend in case of BKOPS Level >= 1
> in order to let eMMC device to complete its internal GC.
> Applicable for Runtime Suspend Only.
>
> Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/core/mmc.c  | 30 +++++++++++++++++++++++-------
>  include/linux/mmc/mmc.h |  1 +
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e2e987f..c4c6326 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1904,7 +1904,8 @@ static void mmc_detect(struct mmc_host *host)
>         }
>  }
>
> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> +       bool is_runtime_pm)
>  {
>         int err = 0;
>         unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
> @@ -1918,10 +1919,25 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         if (mmc_card_suspended(host->card))
>                 goto out;
>
> -       if (mmc_card_doing_bkops(host->card)) {
> -               err = mmc_stop_bkops(host->card);
> -               if (err)
> +       if (mmc_card_doing_bkops(host->card) ||
> +               host->card->ext_csd.auto_bkops_en) {
> +               err = mmc_read_bkops_status(host->card);
> +               if (err) {
> +                       pr_err("%s: error %d reading BKOPS Status\n",
> +                               mmc_hostname(host), err);
> +                       goto out;
> +               }

I would appreciate some simple comment of what you want to do here below.

> +               if (is_runtime_pm && host->card->ext_csd.raw_bkops_status >=
> +                               EXT_CSD_BKOPS_LEVEL_1) {
> +                       pm_schedule_suspend(&host->card->dev,
> +                               MMC_RUNTIME_SUSPEND_DELAY_MS);
>                         goto out;

If I understand correctly, you would like to abort the runtime suspend
and allow the background operations to complete. That seems
reasonable, although in such case you need to return -EBUSY from this
function.
Moreover, perhaps we should discuss at what BKOPS_LEVEL* we should
allow to abort.

> +               }
> +               if (mmc_card_doing_bkops(host->card)) {
> +                       err = mmc_stop_bkops(host->card);
> +                       if (err)
> +                               goto out;
> +               }
>         }
>
>         err = mmc_flush_cache(host->card);
> @@ -1952,7 +1968,7 @@ static int mmc_suspend(struct mmc_host *host)
>  {
>         int err;
>
> -       err = _mmc_suspend(host, true);
> +       err = _mmc_suspend(host, true, false);
>         if (!err) {
>                 pm_runtime_disable(&host->card->dev);
>                 pm_runtime_set_suspended(&host->card->dev);
> @@ -2002,7 +2018,7 @@ static int mmc_shutdown(struct mmc_host *host)
>                 err = _mmc_resume(host);
>
>         if (!err)
> -               err = _mmc_suspend(host, false);
> +               err = _mmc_suspend(host, false, false);
>
>         return err;
>  }
> @@ -2026,7 +2042,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
>         if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>                 return 0;
>
> -       err = _mmc_suspend(host, true);
> +       err = _mmc_suspend(host, true, true);
>         if (err)
>                 pr_err("%s: error %d doing aggressive suspend\n",
>                         mmc_hostname(host), err);
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 0fe3908..0f08d5c 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -430,6 +430,7 @@ struct _mmc_csd {
>  /*
>   * BKOPS status level
>   */
> +#define EXT_CSD_BKOPS_LEVEL_1          0x1
>  #define EXT_CSD_BKOPS_LEVEL_2          0x2
>
>  /*
> --
> 1.9.1
>

Another idea I had, was to actually make use of that we know the card
will be inactive. So instead of checking if there is an ongoing BKOPS
(mmc_card_doing_bkops()), in case of the manual BKOPS, we could
potentially check the needed BKOPS LEVEL and schedule a BKOPS to
start. In other words, do manual BKOPS when the card is idle.

Of course, one need to be able to interrupt/cancel the BKOPS if there
is a new request that needs to be managed. I am not sure how we can
achieve that, but I hope you get the idea.

Kind regards
Uffe
