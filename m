From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: don't call bus_ops->power_restore if already on
Date: Mon, 11 May 2015 10:48:20 +0200
Message-ID: <CAPDyKFrF=6GRiSvDPnyV5mAozu1N54e+HrTvjRbH-FyTmj6hqA@mail.gmail.com>
References: <1430841827-7834-1-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34732 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbEKIsV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 04:48:21 -0400
Received: by qkgx75 with SMTP id x75so82458076qkg.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 01:48:20 -0700 (PDT)
In-Reply-To: <1430841827-7834-1-git-send-email-eliad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ido Yariv <ido@wizery.com>

On 5 May 2015 at 18:03, Eliad Peller <eliad@wizery.com> wrote:
> mmc_power_restore_host() calls mmc_power_up(), which
> returns immediately if power is already on.
>
> However, it still calls host->bus_ops->power_restore,
> which might result in various errors if the bus_ops
> doesn't handle it well (e.g. failing to run init
> sequence twice)
>
> Simply bail out in this case, without further calling
> bus_ops->power_restore.
>
> Specifically, this solves issue with wl18xx sdio card,
> where the mmc core powers on the card on resume (while
> MMC_PM_KEEP_POWER is not set), and the wl18xx device
> driver calls mmc_power_restore_host() once more.

Could you elaborate on why that driver calls mmc_power_restore_host()
after the system PM suspend sequence? I am trying to understand the
use case.

Kind regards
Uffe

>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> Signed-off-by: Ido Yariv <ido@wizery.com>
> ---
>  drivers/mmc/core/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c296bc0..797b574 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2604,6 +2604,11 @@ int mmc_power_restore_host(struct mmc_host *host)
>                 return -EINVAL;
>         }
>
> +       if (host->ios.power_mode == MMC_POWER_ON) {
> +               mmc_bus_put(host);
> +               return 0;
> +       }
> +
>         mmc_power_up(host, host->card->ocr);
>         ret = host->bus_ops->power_restore(host);
>
> --
> 1.8.5.2.229.g4448466.dirty
>
