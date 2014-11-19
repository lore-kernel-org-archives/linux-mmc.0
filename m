From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Simplify PM hooks
Date: Wed, 19 Nov 2014 12:00:51 +0100
Message-ID: <CAPDyKFpJzebPbm0wM0P9SpFm4Rh_H6F4mqEA5d4+88KX9wyioQ@mail.gmail.com>
References: <1416278619-1831-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:45019 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbaKSLAw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 06:00:52 -0500
Received: by mail-qg0-f48.google.com with SMTP id q107so192520qgd.7
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 03:00:51 -0800 (PST)
In-Reply-To: <1416278619-1831-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 18 November 2014 03:43, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> By using SIMPLE_DEV_PM_OPS we can make the code smaller and cleaner.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 339059a..c049ac7 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -702,7 +702,7 @@ static int mxs_mmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int mxs_mmc_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
> @@ -722,22 +722,17 @@ static int mxs_mmc_resume(struct device *dev)
>         clk_prepare_enable(ssp->clk);
>         return 0;
>  }
> -
> -static const struct dev_pm_ops mxs_mmc_pm_ops = {
> -       .suspend        = mxs_mmc_suspend,
> -       .resume         = mxs_mmc_resume,
> -};
>  #endif
>
> +static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
> +
>  static struct platform_driver mxs_mmc_driver = {
>         .probe          = mxs_mmc_probe,
>         .remove         = mxs_mmc_remove,
>         .id_table       = mxs_ssp_ids,
>         .driver         = {
>                 .name   = DRIVER_NAME,
> -#ifdef CONFIG_PM
>                 .pm     = &mxs_mmc_pm_ops,
> -#endif
>                 .of_match_table = mxs_mmc_dt_ids,
>         },
>  };
> --
> 1.9.1
>
