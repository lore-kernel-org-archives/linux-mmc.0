From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdio: Keep card runtime resumed while adding
 function devices
Date: Wed, 7 Jun 2017 16:45:36 +0200
Message-ID: <CAPDyKFp5--WEeBsUrEzDUwgraY7stEV1cHxdp3tbk=wwJr9w7A@mail.gmail.com>
References: <1495107722-13444-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32884 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdFGOpi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jun 2017 10:45:38 -0400
Received: by mail-qk0-f178.google.com with SMTP id r62so8548666qkf.0
        for <linux-mmc@vger.kernel.org>; Wed, 07 Jun 2017 07:45:37 -0700 (PDT)
In-Reply-To: <1495107722-13444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 18 May 2017 at 13:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Drivers core will runtime suspend a device with no driver. That means the
> SDIO card will be runtime suspended as soon as it is added. It is then
> runtime resumed to add each function. That is entirely pointless, so add
> pm runtime get/put to keep the SDIO card runtime resumed until the function
> devices have been added.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Adrian, apologize for the delay!

> ---
>  drivers/mmc/core/sdio.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index fae732c870a9..97bedde0610c 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1110,6 +1110,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>                 if (err)
>                         goto remove;
>
> +               pm_runtime_get_noresume(&card->dev);

Please move this above pm_runtime_set_active(), just to be really sure
the device remains active. Thus you also need to update the error
path.

> +
>                 /*
>                  * Enable runtime PM for this card
>                  */
> @@ -1129,7 +1131,7 @@ int mmc_attach_sdio(struct mmc_host *host)
>         for (i = 0; i < funcs; i++, card->sdio_funcs++) {
>                 err = sdio_init_func(host->card, i + 1);
>                 if (err)
> -                       goto remove;
> +                       goto remove_get;
>
>                 /*
>                  * Enable Runtime PM for this func (if supported)
> @@ -1156,6 +1158,10 @@ int mmc_attach_sdio(struct mmc_host *host)
>         }
>
>         mmc_claim_host(host);
> +
> +       if (host->caps & MMC_CAP_POWER_OFF_CARD)
> +               pm_runtime_put(&card->dev);
> +
>         return 0;
>
>
> @@ -1163,6 +1169,9 @@ int mmc_attach_sdio(struct mmc_host *host)
>         /* Remove without lock if the device has been added. */
>         mmc_sdio_remove(host);
>         mmc_claim_host(host);
> +remove_get:
> +       if (host->caps & MMC_CAP_POWER_OFF_CARD)
> +               pm_runtime_put(&card->dev);

Looking in the error path, I also notice that there is a
pm_runtime_disable missing. Would you mind fixing that (as a separate
change of course) as well?

>  remove:
>         /* And with lock if it hasn't been added. */
>         mmc_release_host(host);
> --
> 1.9.1
>

Kind regards
Uffe
