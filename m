From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: au1xmmc: fix error return code in au1xmmc_probe()
Date: Mon, 18 Aug 2014 11:20:57 +0200
Message-ID: <CAPDyKFrUAci5V3Pv-W_G-CGACOqwJtwyRdRfScUbLwXwzczf9A@mail.gmail.com>
References: <1407978019-15673-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:50087 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaHRJU6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 05:20:58 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so4279996qge.38
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 02:20:57 -0700 (PDT)
In-Reply-To: <1407978019-15673-1-git-send-email-weiyj_lk@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: weiyj_lk@163.com
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Chris Ball <chris@printf.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mmc <linux-mmc@vger.kernel.org>

On 14 August 2014 03:00,  <weiyj_lk@163.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/au1xmmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index 9c9f6af..725f6a6 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -1028,9 +1028,12 @@ static int au1xmmc_probe(struct platform_device *pdev)
>         host->clk = clk_get(&pdev->dev, ALCHEMY_PERIPH_CLK);
>         if (IS_ERR(host->clk)) {
>                 dev_err(&pdev->dev, "cannot find clock\n");
> +               ret = PTR_ERR(host->clk);
>                 goto out_irq;
>         }
> -       if (clk_prepare_enable(host->clk)) {
> +
> +       ret = clk_prepare_enable(host->clk);
> +       if (ret) {
>                 dev_err(&pdev->dev, "cannot enable clock\n");
>                 goto out_clk;
>         }
>
