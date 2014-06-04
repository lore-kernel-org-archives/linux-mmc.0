From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Date: Wed, 4 Jun 2014 14:58:13 +0200
Message-ID: <CAPDyKFrKTG569jLXygeXmd+=AH-V9Z69eNN-6EKBYmhFCdn5Vw@mail.gmail.com>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
	<1401882133-11050-3-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:56165 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaFDM6N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 08:58:13 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so15340773qgd.24
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 05:58:13 -0700 (PDT)
In-Reply-To: <1401882133-11050-3-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Chris Ball <chris@printf.net>, magnus.damm@opensource.se, linus-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On 4 June 2014 13:42, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Start tidying the probe/release code by using devm_ioremap_resource() to
> map the IO registers.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Fixes from v1:
>         - return the PTR_ERR() from devm_ioremap
>         - remove error print as it already shows an error
> ---
>  drivers/mmc/host/sh_mmcif.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7f819f1..3ed54c8 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1377,22 +1377,15 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "Get irq error\n");
>                 return -ENXIO;
>         }
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "platform_get_resource error.\n");
> -               return -ENXIO;
> -       }
> -       reg = ioremap(res->start, resource_size(res));
> -       if (!reg) {
> -               dev_err(&pdev->dev, "ioremap error.\n");
> -               return -ENOMEM;
> -       }
> +       reg = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(reg))
> +               return PTR_ERR(reg);
>
>         mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), &pdev->dev);
> -       if (!mmc) {
> -               ret = -ENOMEM;
> -               goto ealloch;
> -       }
> +       if (!mmc)
> +               return -ENOMEM;
>
>         ret = mmc_of_parse(mmc);
>         if (ret < 0)
> @@ -1497,8 +1490,6 @@ eclkget:
>         pm_runtime_disable(&pdev->dev);
>  eofparse:
>         mmc_free_host(mmc);
> -ealloch:
> -       iounmap(reg);
>         return ret;
>  }
>
> @@ -1523,9 +1514,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
>          */
>         cancel_delayed_work_sync(&host->timeout_work);
>
> -       if (host->addr)
> -               iounmap(host->addr);
> -
>         irq[0] = platform_get_irq(pdev, 0);
>         irq[1] = platform_get_irq(pdev, 1);
>
> --
> 2.0.0.rc2
>
