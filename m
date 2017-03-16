From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 08/14] mmc: sunxi: simplify optional reset handling
Date: Thu, 16 Mar 2017 15:46:58 +0100
Message-ID: <CAPDyKFqpDQ0+Dn8cFSkg5UWRGB3A-UKsL6Y0+BKx8U-R6h56_w@mail.gmail.com>
References: <20170315113146.27303-1-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35770 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754188AbdCPOrA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 10:47:00 -0400
Received: by mail-ua0-f169.google.com with SMTP id q7so27519701uaf.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 07:46:59 -0700 (PDT)
In-Reply-To: <20170315113146.27303-1-p.zabel@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 15 March 2017 at 12:31, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6ffcd2838272c..4dbdcdfaeb86a 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1177,7 +1177,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         }
>
>         host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
> -       if (PTR_ERR(host->reset) == -EPROBE_DEFER)
> +       if (IS_ERR(host->reset))
>                 return PTR_ERR(host->reset);
>
>         ret = clk_prepare_enable(host->clk_ahb);
> @@ -1204,12 +1204,10 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                 goto error_disable_clk_output;
>         }
>
> -       if (!IS_ERR(host->reset)) {
> -               ret = reset_control_deassert(host->reset);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "reset err %d\n", ret);
> -                       goto error_disable_clk_sample;
> -               }
> +       ret = reset_control_deassert(host->reset);
> +       if (ret) {
> +               dev_err(&pdev->dev, "reset err %d\n", ret);
> +               goto error_disable_clk_sample;
>         }
>
>         /*
> @@ -1225,8 +1223,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                         sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
>
>  error_assert_reset:
> -       if (!IS_ERR(host->reset))
> -               reset_control_assert(host->reset);
> +       reset_control_assert(host->reset);
>  error_disable_clk_sample:
>         clk_disable_unprepare(host->clk_sample);
>  error_disable_clk_output:
> @@ -1309,8 +1306,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>         disable_irq(host->irq);
>         sunxi_mmc_reset_host(host);
>
> -       if (!IS_ERR(host->reset))
> -               reset_control_assert(host->reset);
> +       reset_control_assert(host->reset);
>
>         clk_disable_unprepare(host->clk_sample);
>         clk_disable_unprepare(host->clk_output);
> --
> 2.11.0
>
