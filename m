From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: Changes the order of how clocks
 are being re-enabled
Date: Tue, 9 Jan 2018 09:23:38 +0100
Message-ID: <CAPDyKFoYGToSMHX1gai-Rzedjq2c0O+iD+mmmNuNNDH1A8CxEw@mail.gmail.com>
References: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com> <1515079859-18401-2-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:42177 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755213AbeAIIXj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jan 2018 03:23:39 -0500
Received: by mail-it0-f66.google.com with SMTP id p139so10659303itb.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jan 2018 00:23:39 -0800 (PST)
In-Reply-To: <1515079859-18401-2-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 4 January 2018 at 16:30, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> runtime_resume() should re-enable the clocks in reverse order comparing with
> runtime_suspend()
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Thanks, applied for next!

Adrian, please tell me if you are not happy with this.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d08c21e..6d4e323 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1411,31 +1411,33 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int err;
>
> +       err = clk_prepare_enable(imx_data->clk_ahb);
> +       if (err)
> +               return err;
> +
>         if (!sdhci_sdio_irq_enabled(host)) {
>                 err = clk_prepare_enable(imx_data->clk_per);
>                 if (err)
> -                       return err;
> +                       goto disable_ahb_clk;
>                 err = clk_prepare_enable(imx_data->clk_ipg);
>                 if (err)
>                         goto disable_per_clk;
>         }
> -       err = clk_prepare_enable(imx_data->clk_ahb);
> -       if (err)
> -               goto disable_ipg_clk;
> +
>         err = sdhci_runtime_resume_host(host);
>         if (err)
> -               goto disable_ahb_clk;
> +               goto disable_ipg_clk;
>
>         return 0;
>
> -disable_ahb_clk:
> -       clk_disable_unprepare(imx_data->clk_ahb);
>  disable_ipg_clk:
>         if (!sdhci_sdio_irq_enabled(host))
>                 clk_disable_unprepare(imx_data->clk_ipg);
>  disable_per_clk:
>         if (!sdhci_sdio_irq_enabled(host))
>                 clk_disable_unprepare(imx_data->clk_per);
> +disable_ahb_clk:
> +       clk_disable_unprepare(imx_data->clk_ahb);
>         return err;
>  }
>  #endif
> --
> 2.7.4
>
