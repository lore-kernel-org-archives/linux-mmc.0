From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] mmc: Fix use of wrong device in mmc_gpiod_free_cd()
Date: Mon, 29 Sep 2014 11:44:11 +0200
Message-ID: <CAPDyKFqz5NZKFPAAcv3HZ=FUtDn_WODHzgv6s3VLrwUd082krQ@mail.gmail.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
	<1411502430-25535-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:65100 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaI2JoM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 05:44:12 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so10382991qgd.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Sep 2014 02:44:11 -0700 (PDT)
In-Reply-To: <1411502430-25535-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> mmc_gpiod_free_cd() is paired with mmc_gpiod_request_cd()
> and both must reference the same device which is the
> actual host controller device not the mmc_host class
> device.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/slot-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index e3fce44..06616cd 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -392,7 +392,7 @@ void mmc_gpiod_free_cd(struct mmc_host *host)
>                 host->slot.cd_irq = -EINVAL;
>         }
>
> -       devm_gpiod_put(&host->class_dev, ctx->cd_gpio);
> +       devm_gpiod_put(host->parent, ctx->cd_gpio);
>
>         ctx->cd_gpio = NULL;
>  }
> --
> 1.8.3.2
>
