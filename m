From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Attempt to flush cache before reset
Date: Mon, 2 May 2016 10:31:06 +0200
Message-ID: <CAPDyKFrzfoR9xDVvSnVuwMFQRABh3jfgRGbjPp=754F3hn8bZQ@mail.gmail.com>
References: <1461829739-19772-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35111 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcEBIbI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2016 04:31:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so97886869wme.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 May 2016 01:31:07 -0700 (PDT)
In-Reply-To: <1461829739-19772-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 28 April 2016 at 09:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
> CMD0 or hardware reset may invalidate the cache, so it needs to be
> flushed before reset.
>
> In the case of recovery, we can't expect flushing the cache to work
> always, but have a go and ignore errors.

Makes sense!

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 99275e40bf2f..1b4e0ccb0885 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2453,6 +2453,12 @@ int mmc_hw_reset(struct mmc_host *host)
>                 return -EOPNOTSUPP;
>         }
>
> +       /*
> +        * In the case of recovery, we can't expect flushing the cache to work
> +        * always, but we have a go and ignore errors.
> +        */
> +       mmc_flush_cache(host->card);
> +

I prefer if you move this into mmc_reset() in drivers/mmc/core/mmc.c
instead, as it's an mmc specific operation.

>         ret = host->bus_ops->reset(host);
>         mmc_bus_put(host);
>
> --
> 1.9.1
>

Kind regards
Uffe
