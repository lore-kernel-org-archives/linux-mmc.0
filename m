From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
Date: Wed, 12 Apr 2017 16:11:49 +0200
Message-ID: <CAPDyKFooBobLN8p9kH2Tm9KM9HQXuN87PU4PmyNb+EJN1vTNww@mail.gmail.com>
References: <20170410135417.GD1918@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36730 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdDLOLz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 10:11:55 -0400
Received: by mail-ua0-f180.google.com with SMTP id a1so16821761uaf.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2017 07:11:50 -0700 (PDT)
In-Reply-To: <20170410135417.GD1918@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Ravikumar Kattekola <rk@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 10 April 2017 at 15:54, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> devm_pinctrl_get() returns error pointers, it never returns NULL.
>
> Fixes: 455e5cd6f736 ("mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied for next!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index bf64cf23aa59..8c39dccacf39 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1761,8 +1761,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>          */
>         if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
>                 struct pinctrl *p = devm_pinctrl_get(host->dev);
> -               if (!p) {
> -                       ret = -ENODEV;
> +               if (IS_ERR(p)) {
> +                       ret = PTR_ERR(p);
>                         goto err_free_irq;
>                 }
>                 if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
