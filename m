From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/7] mmc: dw_mmc: replace the bus_hz checking point
Date: Thu, 6 Mar 2014 08:27:14 +0100
Message-ID: <CAPDyKFpANEoruo66+vTnFXN9aYx8GRQsPgNKtdCB_J2e8xAJkg@mail.gmail.com>
References: <5313EABA.8020103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:54692 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaCFHdF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 02:33:05 -0500
Received: by mail-qa0-f52.google.com with SMTP id m5so2138869qaj.11
        for <linux-mmc@vger.kernel.org>; Wed, 05 Mar 2014 23:33:04 -0800 (PST)
In-Reply-To: <5313EABA.8020103@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

On 3 March 2014 03:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> It's right that check immediately whether host->bus_hz is assigned or not.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Changelog V4:
>         - Fixed the compile warning.
> Changelog V3:
>         - Maintained original place for the drv_data->setup_clock
> Changelog V2:
>         - When drv_data->setup_clock is present, set to bus_hz with it.
>
>  drivers/mmc/host/dw_mmc.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8193e21..3970fc3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2427,12 +2427,19 @@ int dw_mci_probe(struct dw_mci *host)
>                         ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
>                         if (ret)
>                                 dev_warn(host->dev,
> -                                        "Unable to set bus rate to %ul\n",
> +                                        "Unable to set bus rate to %uHz\n",
>                                          host->pdata->bus_hz);
>                 }
>                 host->bus_hz = clk_get_rate(host->ciu_clk);
>         }
>
> +       if (!host->bus_hz) {
> +               dev_err(host->dev,
> +                       "Platform data must supply bus speed\n");
> +               ret = -ENODEV;
> +               goto err_clk_ciu;
> +       }
> +
>         if (drv_data && drv_data->init) {
>                 ret = drv_data->init(host);
>                 if (ret) {
> @@ -2469,13 +2476,6 @@ int dw_mci_probe(struct dw_mci *host)
>                 }
>         }
>
> -       if (!host->bus_hz) {
> -               dev_err(host->dev,
> -                       "Platform data must supply bus speed\n");
> -               ret = -ENODEV;
> -               goto err_regulator;
> -       }
> -
>         host->quirks = host->pdata->quirks;
>
>         spin_lock_init(&host->lock);
> @@ -2619,8 +2619,6 @@ err_workqueue:
>  err_dmaunmap:
>         if (host->use_dma && host->dma_ops->exit)
>                 host->dma_ops->exit(host);
> -
> -err_regulator:
>         if (host->vmmc)
>                 regulator_disable(host->vmmc);
>
> --
> 1.7.9.5
