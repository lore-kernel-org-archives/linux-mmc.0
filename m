From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6] mmc: sh-mmcif: final error path cleanup
Date: Wed, 4 Jun 2014 15:02:10 +0200
Message-ID: <CAPDyKFqa+nOxMMO49NcPuKzqPsAGWdp7=mjc-UuHYD=bp5_tgg@mail.gmail.com>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
	<1401882133-11050-7-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:50017 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbaFDNCM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 09:02:12 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so6833673qaq.23
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 06:02:11 -0700 (PDT)
In-Reply-To: <1401882133-11050-7-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Chris Ball <chris@printf.net>, magnus.damm@opensource.se, linus-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On 4 June 2014 13:42, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Remove the error path items that are no longer needed. The mmc card-detect
> code cleans up after itself (and registers with devm) and the host error
> is the same as the clock disable.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sh_mmcif.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index b378aa0..35c77ad 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1458,14 +1458,14 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         if (pd && pd->use_cd_gpio) {
>                 ret = mmc_gpio_request_cd(mmc, pd->cd_gpio, 0);
>                 if (ret < 0)
> -                       goto erqcd;
> +                       goto err_clk;
>         }
>
>         mutex_init(&host->thread_lock);
>
>         ret = mmc_add_host(mmc);
>         if (ret < 0)
> -               goto emmcaddh;
> +               goto err_clk;
>
>         dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
>
> @@ -1476,8 +1476,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         clk_disable_unprepare(host->hclk);
>         return ret;
>
> -emmcaddh:
> -erqcd:
>  err_clk:
>         clk_disable_unprepare(host->hclk);
>  err_pm:
> --
> 2.0.0.rc2
>
