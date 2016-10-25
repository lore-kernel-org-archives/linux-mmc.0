From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Tue, 25 Oct 2016 12:03:38 +0200
Message-ID: <CAPDyKFoO1JX2-jpux+f-1O8kDC+jumspXapA0PZvKMBUE3YhSA@mail.gmail.com>
References: <1475504388-31304-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34853 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbcJYKDk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 06:03:40 -0400
Received: by mail-wm0-f45.google.com with SMTP id c78so153356333wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2016 03:03:40 -0700 (PDT)
In-Reply-To: <1475504388-31304-1-git-send-email-thierry.escande@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Escande <thierry.escande@collabora.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 3 October 2016 at 16:19, Thierry Escande
<thierry.escande@collabora.com> wrote:
> From: zhaojohn <john.zhao@intel.com>
>
> Hynix eMMC devices sometimes take 50% longer to resume from sleep.
> Based on a recommendation from Hynix, send a Power-Off Notification
> before going to S3 to restore a resume time consistently within spec.

Could you also share what mmc controller and SoC you get this results from?

More precisely, are you using MMC_CAP_WAIT_WHILE_BUSY?

>
> Signed-off-by: zhaojohn <john.zhao@intel.com>
> Signed-off-by: Arindam Roy <arindam.roy@intel.com>
> Tested-by: Freddy Paul <freddy.paul@intel.com>
> Reviewed-by: Icarus W Sparry <icarus.w.sparry@intel.com>
> Reviewed-by: Marc Herbert <marc.herbert@intel.com>
> Reviewed-by: Eric Caruso <ejcaruso@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  drivers/mmc/card/block.c | 8 ++++++++
>  drivers/mmc/core/mmc.c   | 8 +++++++-
>  include/linux/mmc/card.h | 2 ++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 2206d44..cbc2d97 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2572,6 +2572,14 @@ static const struct mmc_fixup blk_fixups[] =
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Hynix eMMC devices sometimes take 50% longer to resume from sleep.
> +        * Based on a recommendation from Hynix, send a Power-Off Notification
> +        * before going to S3 to restore a resume time consistently within spec.
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_HYNIX, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP),
> +
>         END_FIXUP
>  };
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f2d185c..46a4562 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1925,8 +1925,14 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         if (mmc_can_poweroff_notify(host->card) &&
>                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>                 err = mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> +       else if (mmc_can_sleep(host->card)) {
> +               if (host->card->quirks & MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP) {
> +                       err = mmc_poweroff_notify(host->card, notify_type);
> +                       if (err)
> +                               goto out;
> +               }

So, I am curious to know from a power management point of view; how
does the card behave comparing the sleep and power off notification
command?

Is the card in a low power state after the power off notification has
been received? If so, did you manage to do some measurement for that
or perhaps the data-sheet tells about this? It would be interesting to
know if there were any differences between sleep and power off
notification in this regards.

[...]

Kind regards
Uffe
