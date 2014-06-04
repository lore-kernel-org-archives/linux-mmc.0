From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/6] mmc: sh-mmcif: use devm_ for clock management
Date: Wed, 4 Jun 2014 14:59:01 +0200
Message-ID: <CAPDyKFpGQZt7ROKetPcqOJNkK2m67tQGP2DTynQDkDmZG_Rt5w@mail.gmail.com>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
	<1401882133-11050-4-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33695 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbaFDM7D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 08:59:03 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so15548139qgd.18
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 05:59:01 -0700 (PDT)
In-Reply-To: <1401882133-11050-4-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Chris Ball <chris@printf.net>, magnus.damm@opensource.se, linus-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On 4 June 2014 13:42, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Use the devm_clk_get() code to get the clock and allow it to be freed
> automatically on release.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sh_mmcif.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 3ed54c8..ae278a5 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1389,7 +1389,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(mmc);
>         if (ret < 0)
> -               goto eofparse;
> +               goto err_host;
>
>         host            = mmc_priv(mmc);
>         host->mmc       = mmc;
> @@ -1419,19 +1419,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         pm_runtime_enable(&pdev->dev);
>         host->power = false;
>
> -       host->hclk = clk_get(&pdev->dev, NULL);
> +       host->hclk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(host->hclk)) {
>                 ret = PTR_ERR(host->hclk);
>                 dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
> -               goto eclkget;
> +               goto err_pm;
>         }
>         ret = sh_mmcif_clk_update(host);
>         if (ret < 0)
> -               goto eclkupdate;
> +               goto err_pm;
>
>         ret = pm_runtime_resume(&pdev->dev);
>         if (ret < 0)
> -               goto eresume;
> +               goto err_clk;
>
>         INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
>
> @@ -1482,13 +1482,11 @@ ereqirq1:
>         free_irq(irq[0], host);
>  ereqirq0:
>         pm_runtime_suspend(&pdev->dev);
> -eresume:
> +err_clk:
>         clk_disable_unprepare(host->hclk);
> -eclkupdate:
> -       clk_put(host->hclk);
> -eclkget:
> +err_pm:
>         pm_runtime_disable(&pdev->dev);
> -eofparse:
> +err_host:
>         mmc_free_host(mmc);
>         return ret;
>  }
> --
> 2.0.0.rc2
>
