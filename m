From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv3 3/4] mmc: dw_mmc: remove the "supports-highspeed" property.
Date: Fri, 30 May 2014 10:01:16 +0200
Message-ID: <CAPDyKFpTTYHtkKjFmbPi6P_xfdfd8Fv8qfpKZMfpQBppRNZLwg@mail.gmail.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
	<1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:59173 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbaE3IBR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 May 2014 04:01:17 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so4373194qgd.10
        for <linux-mmc@vger.kernel.org>; Fri, 30 May 2014 01:01:16 -0700 (PDT)
In-Reply-To: <1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ludovic Desroches <ludovic.desroches@atmel.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

On 28 May 2014 07:35, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Removed the parser for "supports-highspeed".
> It can be parsed with "cap-mmc-highsped" or "cap-sd-highspeed" at
> mmc_of_parse().
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3285bdd..34b5210 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2281,9 +2281,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>                         return ERR_PTR(ret);
>         }
>
> -       if (of_find_property(np, "supports-highspeed", NULL))
> -               pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> -

According to DT guys, normally we shouldn't remove DT bindings. Thus,
you need to keep this, unless you can get some of the DT guys to ack
it.

Though, you still want to move the DTs to use common mmc bindings. And
you could mark the documentation of the above binding as deprecated.

Kind regards
Ulf Hansson
