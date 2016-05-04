From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc: mmc: Attempt to flush cache before reset
Date: Wed, 4 May 2016 13:13:57 +0200
Message-ID: <CAPDyKFrFq5wDgr+FpTLH275BF3MQeW9MET3AsQ6HcKtCS9rhHg@mail.gmail.com>
References: <1461829739-19772-1-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrzfoR9xDVvSnVuwMFQRABh3jfgRGbjPp=754F3hn8bZQ@mail.gmail.com>
	<5729A6ED.4010009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35104 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197AbcEDLN7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 07:13:59 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so183082062wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2016 04:13:58 -0700 (PDT)
In-Reply-To: <5729A6ED.4010009@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 4 May 2016 at 09:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
> CMD0 or hardware reset may invalidate the cache, so it needs to be
> flushed before reset.
>
> In the case of recovery, we can't expect flushing the cache to work
> always, but have a go and ignore errors.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>
> Changes in V2:
>
>         Do flush in mmc_reset() instead of mmc_hw_reset()
>
>
>  drivers/mmc/core/mmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0cf42af33d0f..d4d1b77c1c1e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1965,6 +1965,12 @@ static int mmc_reset(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
>
> +       /*
> +        * In the case of recovery, we can't expect flushing the cache to work
> +        * always, but we have a go and ignore errors.
> +        */
> +       mmc_flush_cache(host->card);
> +
>         if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
>              mmc_can_reset(card)) {
>                 /* If the card accept RST_n signal, send it. */
> --
> 1.9.1
>
>
