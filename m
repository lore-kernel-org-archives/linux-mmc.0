From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Mon, 21 Oct 2013 08:40:31 +0530
Message-ID: <CAK9yfHwhpAera9jFf=A31zvfZJ2cocZWmt94w=WShD2wyu=AYw@mail.gmail.com>
References: <1378976643-26717-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61593 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3JUDKb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 23:10:31 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so6336441pbc.17
        for <linux-mmc@vger.kernel.org>; Sun, 20 Oct 2013 20:10:31 -0700 (PDT)
In-Reply-To: <1378976643-26717-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 12 September 2013 14:34, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> pdata could be NULL if cd_gpio = -1. Dereference pdata only
> if it is not NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Compile tested.
> Changes since v1:
> * Moved the pdata assignment inside if condition.
> ---
>  drivers/mmc/host/sdhci-spear.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 2dba9f8..76ddd89 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -84,14 +84,12 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
>         /* If pdata is required */
>         if (cd_gpio != -1) {
>                 pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> -               if (!pdata) {
> +               if (!pdata)
>                         dev_err(&pdev->dev, "DT: kzalloc failed\n");
> -                       return ERR_PTR(-ENOMEM);
> -               }
> +               else
> +                       pdata->card_int_gpio = cd_gpio;
>         }
>
> -       pdata->card_int_gpio = cd_gpio;
> -
>         return pdata;
>  }
>  #else
> --
> 1.7.9.5
>

Gentle ping, Chris.


-- 
With warm regards,
Sachin
