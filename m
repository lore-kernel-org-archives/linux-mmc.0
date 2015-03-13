From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Call mmc_of_parse()
Date: Fri, 13 Mar 2015 11:15:21 +0100
Message-ID: <CAPDyKFp2NPGatzi93uZ6oc_1dThVLYYxcxOyL_O1ANV=0sYguQ@mail.gmail.com>
References: <1426198535-21312-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:46371 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbbCMKPW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 06:15:22 -0400
Received: by qcyl6 with SMTP id l6so25253083qcy.13
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 03:15:21 -0700 (PDT)
In-Reply-To: <1426198535-21312-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Otavio Salvador <otavio@ossystems.com.br>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 12 March 2015 at 23:15, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Currently it is not possible to use 'mmc-pwrseq-simple' property with this
> driver because mmc_of_parse() is never called.
>
> mmc_of_parse() calls mmc_pwrseq_alloc() that manages MMC power sequence.
>
> Call the generic mmc_of_parse() so that we can use 'mmc-pwrseq-simple' to
> provide reset GPIO to the Wifi/BT chip.
>
> Tested on a imx6sl-warp board.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, applied!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 9cce5cf..d714d8f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1075,6 +1075,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>         }
>
> +       /* call to generic mmc_of_parse to support additional capabilities */
> +       err = mmc_of_parse(host->mmc);
> +       if (err)
> +               goto disable_clk;
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto disable_clk;
> --
> 1.9.1
>
