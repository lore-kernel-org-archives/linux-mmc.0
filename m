From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] mmc: sh-mmcif: update to print version and bus clock
 rate on probe
Date: Wed, 4 Jun 2014 14:57:16 +0200
Message-ID: <CAPDyKFqWQvBVFpuDzJt49Vn95Y77Pi0=s+cDkoP9HcpGt31hBg@mail.gmail.com>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
	<1401882133-11050-2-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:52192 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbaFDM5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 08:57:17 -0400
Received: by mail-qg0-f52.google.com with SMTP id a108so15878854qge.11
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 05:57:16 -0700 (PDT)
In-Reply-To: <1401882133-11050-2-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Chris Ball <chris@printf.net>, magnus.damm@opensource.se, linus-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On 4 June 2014 13:42, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Change the initial print to show chip version and the bus rate it is
> working at instead of the driver version. This is more useful information
> as we already know which driver version from the kernel it is in.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sh_mmcif.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 54730f4..7f819f1 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1468,16 +1468,17 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>
>         mutex_init(&host->thread_lock);
>
> -       clk_disable_unprepare(host->hclk);
>         ret = mmc_add_host(mmc);
>         if (ret < 0)
>                 goto emmcaddh;
>
>         dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
>
> -       dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
> -       dev_dbg(&pdev->dev, "chip ver H'%04x\n",
> -               sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
> +       dev_info(&pdev->dev, "Chip version 0x%04x, clock rate %luMHz\n",
> +                sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0xffff,
> +                clk_get_rate(host->hclk) / 1000000UL);
> +
> +       clk_disable_unprepare(host->hclk);
>         return ret;
>
>  emmcaddh:
> --
> 2.0.0.rc2
>
