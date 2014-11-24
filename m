From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: mxs-mmc: Check for clk_prepare_enable() error
Date: Mon, 24 Nov 2014 09:36:35 +0100
Message-ID: <CAPDyKFqi2OOF3u0BTS4tFp2ckTW7_q5VZZMV1BGe_TniY=28ig@mail.gmail.com>
References: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
	<1416403019-6353-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:60827 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbaKXIgg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 03:36:36 -0500
Received: by mail-qa0-f49.google.com with SMTP id s7so6012487qap.36
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 00:36:35 -0800 (PST)
In-Reply-To: <1416403019-6353-3-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 19 November 2014 at 14:16, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> clk_prepare_enable() may fail and in this case we should propagate the error.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index f2c49e0..60c4ca9 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -619,7 +619,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>                 ret = PTR_ERR(ssp->clk);
>                 goto out_mmc_free;
>         }
> -       clk_prepare_enable(ssp->clk);
> +       ret = clk_prepare_enable(ssp->clk);
> +       if (ret)
> +               goto out_mmc_free;
>
>         ret = mxs_mmc_reset(host);
>         if (ret) {
> @@ -719,8 +721,7 @@ static int mxs_mmc_resume(struct device *dev)
>         struct mxs_mmc_host *host = mmc_priv(mmc);
>         struct mxs_ssp *ssp = &host->ssp;
>
> -       clk_prepare_enable(ssp->clk);
> -       return 0;
> +       return clk_prepare_enable(ssp->clk);
>  }
>  #endif
>
> --
> 1.9.1
>
