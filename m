From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/7] mmc: sdhci-esdhc-imx: add imx6sx support
Date: Thu, 18 Sep 2014 00:29:52 +0200
Message-ID: <CAPDyKFo5TfuQyb-ECDR+uzCfwio3guY+7LPxHzHXLNBacMbW_A@mail.gmail.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
	<1409745903-26550-7-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:53813 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbaIQW3x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Sep 2014 18:29:53 -0400
Received: by mail-qg0-f52.google.com with SMTP id i50so26496qgf.25
        for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2014 15:29:52 -0700 (PDT)
In-Reply-To: <1409745903-26550-7-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 3 September 2014 14:05, Dong Aisheng <b29396@freescale.com> wrote:
> The imx6sx usdhc is derived from imx6sl, the difference is minor.
> imx6sx have the errata ESDHC_FLAG_ERR004536 fixed.
> So introduce a new compatible string for imx6sx to distinguish them.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Hi Dong,

This one has checkpatch errors due to missing DT documentation.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index dc0e384..87179c4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -150,6 +150,11 @@ static struct esdhc_soc_data usdhc_imx6sl_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
>  };
>
> +static struct esdhc_soc_data usdhc_imx6sx_data = {
> +       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +                       | ESDHC_FLAG_HAVE_CAP1,
> +};
> +
>  struct pltfm_imx_data {
>         u32 scratchpad;
>         struct pinctrl *pinctrl;
> @@ -190,6 +195,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>         { .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
>         { .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
>         { .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
> +       { .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>         { .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
>         { .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
>         { /* sentinel */ }
> --
> 1.7.8
>
