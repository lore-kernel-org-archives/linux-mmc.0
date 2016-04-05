From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: pass omap_hsmmc_host pointer directly
Date: Tue, 5 Apr 2016 13:12:03 +0200
Message-ID: <CAPDyKFrDSxqOs4g9cvcXk92=5iQOadZti_QFUmxggePSG=OTOA@mail.gmail.com>
References: <1458518288-22774-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34698 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbcDELMF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 07:12:05 -0400
Received: by mail-wm0-f42.google.com with SMTP id l6so18732432wml.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2016 04:12:04 -0700 (PDT)
In-Reply-To: <1458518288-22774-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 21 March 2016 at 00:58, Andreas Fenkart <afenkart@gmail.com> wrote:
> unnecessary indirection via 'struct device' back to omap_hsmmc_host
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d2b2525..898878d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -357,15 +357,14 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
>         return 0;
>  }
>
> -static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
> +static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
> +                               int vdd)
>  {
> -       struct omap_hsmmc_host *host =
> -               platform_get_drvdata(to_platform_device(dev));
>         struct mmc_host *mmc = host->mmc;
>         int ret = 0;
>
>         if (mmc_pdata(host)->set_power)
> -               return mmc_pdata(host)->set_power(dev, power_on, vdd);
> +               return mmc_pdata(host)->set_power(host->dev, power_on, vdd);
>
>         /*
>          * If we don't see a Vcc regulator, assume it's a fixed
> @@ -375,7 +374,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
>                 return 0;
>
>         if (mmc_pdata(host)->before_set_reg)
> -               mmc_pdata(host)->before_set_reg(dev, power_on, vdd);
> +               mmc_pdata(host)->before_set_reg(host->dev, power_on, vdd);
>
>         ret = omap_hsmmc_set_pbias(host, false, 0);
>         if (ret)
> @@ -409,7 +408,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
>         }
>
>         if (mmc_pdata(host)->after_set_reg)
> -               mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
> +               mmc_pdata(host)->after_set_reg(host->dev, power_on, vdd);
>
>         return 0;
>
> @@ -1278,11 +1277,11 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
>                 clk_disable_unprepare(host->dbclk);
>
>         /* Turn the power off */
> -       ret = omap_hsmmc_set_power(host->dev, 0, 0);
> +       ret = omap_hsmmc_set_power(host, 0, 0);
>
>         /* Turn the power ON with given VDD 1.8 or 3.0v */
>         if (!ret)
> -               ret = omap_hsmmc_set_power(host->dev, 1, vdd);
> +               ret = omap_hsmmc_set_power(host, 1, vdd);
>         pm_runtime_get_sync(host->dev);
>         if (host->dbclk)
>                 clk_prepare_enable(host->dbclk);
> @@ -1722,10 +1721,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         if (ios->power_mode != host->power_mode) {
>                 switch (ios->power_mode) {
>                 case MMC_POWER_OFF:
> -                       omap_hsmmc_set_power(host->dev, 0, 0);
> +                       omap_hsmmc_set_power(host, 0, 0);
>                         break;
>                 case MMC_POWER_UP:
> -                       omap_hsmmc_set_power(host->dev, 1, ios->vdd);
> +                       omap_hsmmc_set_power(host, 1, ios->vdd);
>                         break;
>                 case MMC_POWER_ON:
>                         do_send_init_stream = 1;
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
