From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: allow rescan of non-removable hosts on resume
Date: Mon, 11 Dec 2017 14:11:23 +0100
Message-ID: <CAPDyKFpuSMpS+Mz3ApQ_jXsR7ggaMv-nMF79Wmy-DzqhERXUcg@mail.gmail.com>
References: <20171206105724.5603-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:42503 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdLKNLY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Dec 2017 08:11:24 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so15722731itb.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2017 05:11:24 -0800 (PST)
In-Reply-To: <20171206105724.5603-1-drake@endlessm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux@endlessm.com, matthew.leeds@endlessm.com

On 6 December 2017 at 11:57, Daniel Drake <drake@endlessm.com> wrote:
> The Weibu F3C MiniPC has an onboard AP6255 module, presenting
> two SDIO functions on a single MMC host (Bluetooth/btsdio and
> WiFi/brcmfmac), and the mmc layer correctly detects this as
> non-removable.
>
> After suspend/resume, the wifi and bluetooth interfaces disappear
> and do not get probed again.
>
> The conditions here are:
>
>  1. During suspend, we reach mmc_pm_notify()
>
>  2. mmc_pm_notify() calls mmc_sdio_pre_suspend() to see if we can
>     suspend the SDIO host. However, mmc_sdio_pre_suspend() returns
>     -ENOSYS because btsdio_driver does not have a suspend method.
>
>  3. mmc_pm_notify() proceeds to remove the card
>
>  4. Upon resume, mmc_rescan() does nothing with this host, because of
>     the rescan_entered check which aims to only scan a non-removable
>     device a single time (i.e. during boot).

Thanks for detailed description of the problem, it really helps!

>
> Fix the loss of functionality by permitting another rescan of
> non-removable devices when we forcefully remove a card under these
> conditions.

No, I don't like this solution, simply because I think it's a
workaround rather than a proper fix.

I think the SDIO func drivers should implement the suspend/resume
callbacks instead.

One may argue that the mmc_pm_notify() then shouldn't have removed the
card in first place if the cards are non-removable. Maybe we should
just print a warning in that case instead.

>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/mmc/core/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1f0f44f4dd5f..e436cde50bc4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2966,6 +2966,10 @@ static int mmc_pm_notify(struct notifier_block *notify_block,
>                 mmc_power_off(host);
>                 mmc_release_host(host);
>                 host->pm_flags = 0;
> +
> +               /* Force a rescan on resume, even for non-removable cards */
> +               host->rescan_entered = 0;
> +
>                 break;
>
>         case PM_POST_SUSPEND:
> --
> 2.14.1
>

Kind regards
Uffe
