From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: core: fix error path in mmc_host_alloc
Date: Mon, 30 Jan 2017 11:05:40 +0100
Message-ID: <CAPDyKFrkj-OZtFr_fxJvFzwB73ugYX8Qz96rt15H5mFuEhnv_A@mail.gmail.com>
References: <dfed7598-7c82-c7d4-1f0b-3c5548adb377@gmail.com> <92cb6f74-a354-d4ab-6e40-1d985526e68f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37981 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbdA3Lvl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 06:51:41 -0500
Received: by mail-wm0-f44.google.com with SMTP id r141so29537688wmg.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 03:50:39 -0800 (PST)
In-Reply-To: <92cb6f74-a354-d4ab-6e40-1d985526e68f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 28 January 2017 at 09:32, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Properly reverse everything if mmc_gpio_alloc(host) fails.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0a26c8b6..19c68bf2 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -369,6 +369,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>
>         if (mmc_gpio_alloc(host)) {
>                 put_device(&host->class_dev);
> +               ida_simple_remove(&mmc_host_ida, host->index);
> +               kfree(host);
>                 return NULL;
>         }
>
> --
> 2.11.0
>
>
