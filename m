From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] mmc: sh-mmcif: no need to call pm_runtime_suspend on error
Date: Wed, 4 Jun 2014 15:01:26 +0200
Message-ID: <CAPDyKFpJuFx_=3SeOQpeebkfs-sRcjy_5d-NtE_u1ZkKACZPiw@mail.gmail.com>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
	<1401882133-11050-6-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:59051 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbaFDNB1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 09:01:27 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so15402138qga.20
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 06:01:26 -0700 (PDT)
In-Reply-To: <1401882133-11050-6-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Chris Ball <chris@printf.net>, magnus.damm@opensource.se, linus-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On 4 June 2014 13:42, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The pm_runtime call should implicitly disable the device once the
> probe is over if there is no explicit reference gained. There is no
> need to call pm_runtime_suspend() before the pm_runtime_disable()
> call.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sh_mmcif.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index cc6858d..b378aa0 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1443,7 +1443,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>                                         sh_mmcif_irqt, 0, name, host);
>         if (ret) {
>                 dev_err(&pdev->dev, "request_irq error (%s)\n", name);
> -               goto err_irq;
> +               goto err_clk;
>         }
>         if (irq[1] >= 0) {
>                 ret = devm_request_threaded_irq(&pdev->dev, irq[1],
> @@ -1451,7 +1451,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>                                                 0, "sh_mmc:int", host);
>                 if (ret) {
>                         dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
> -                       goto err_irq;
> +                       goto err_clk;
>                 }
>         }
>
> @@ -1478,8 +1478,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>
>  emmcaddh:
>  erqcd:
> -err_irq:
> -       pm_runtime_suspend(&pdev->dev);
>  err_clk:
>         clk_disable_unprepare(host->hclk);
>  err_pm:
> --
> 2.0.0.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
