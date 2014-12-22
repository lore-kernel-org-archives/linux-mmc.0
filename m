From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [patch] mmc: mxs-mmc: remove unneeded NULL check
Date: Mon, 22 Dec 2014 10:57:38 +0100
Message-ID: <CAPDyKFopZTP9pegoKUJ70UPVJYp4b-BF0QTzcWGEv68J6hDxJw@mail.gmail.com>
References: <20141216235749.GH31467@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:40421 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbaLVJ5j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 04:57:39 -0500
Received: by mail-qg0-f51.google.com with SMTP id i50so3034149qgf.38
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2014 01:57:39 -0800 (PST)
In-Reply-To: <20141216235749.GH31467@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, Roman Peniaev <r.peniaev@gmail.com>, Peter Griffin <peter.griffin@linaro.org>, Daniel Willmann <daniel@totalueberwachung.de>, linux-mmc <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 17 December 2014 at 00:57, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Static checkers complain about the inconsistent NULL checking here:
>
>         drivers/mmc/host/mxs-mmc.c:680 mxs_mmc_probe()
>         warn: variable dereferenced before check 'ssp->dmach' (see line 660)
>
> The variable can't actually be NULL so we can remove the check.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks! Applied for next.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 60c4ca9..a82411a 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -677,8 +677,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         return 0;
>
>  out_free_dma:
> -       if (ssp->dmach)
> -               dma_release_channel(ssp->dmach);
> +       dma_release_channel(ssp->dmach);
>  out_clk_disable:
>         clk_disable_unprepare(ssp->clk);
>  out_mmc_free:
