From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: Call mmc_of_parse()
Date: Thu, 9 Apr 2015 09:16:52 +0200
Message-ID: <CAPDyKFqz_FstT=HpgsNWac1t+tThRPq+KCtz=2ozFTy3izXEsQ@mail.gmail.com>
References: <1428499065-25544-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35716 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbDIHQx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Apr 2015 03:16:53 -0400
Received: by qkhg7 with SMTP id g7so113707061qkh.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2015 00:16:52 -0700 (PDT)
In-Reply-To: <1428499065-25544-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Otavio Salvador <otavio@ossystems.com.br>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dong Aisheng <b29396@freescale.com>, Fabio Estevam <fabio.estevam@freescale.com>

On 8 April 2015 at 15:17, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Currently it is not possible to use 'mmc-pwrseq-simple' property with this
> driver because mmc_of_parse() is never called.
>
> mmc_of_parse() calls mmc_pwrseq_alloc() that manages MMC power sequence and
> allows passing GPIOs in the devicetree to properly power/reset the Wifi
> chipset.
>
> When using mmc_of_parse() we no longer need to have custom code to request
> card-detect and write-protect pins, as this can now be handled by the mmc
> core.
>
> Tested on a imx6sl-warp board where BT/Wifi is functional and also on a
> imx6q-sabresd.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks! Applied.

Kind regards
Uffe

> ---
> Change since v2:
> - Use mmc_of_parse() and remove custom code to retrieve CD/WP GPIOs.
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7ee8312..82f512d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1013,40 +1013,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                                         host->mmc->parent->platform_data);
>         }
>
> -       /* write_protect */
> -       if (boarddata->wp_type == ESDHC_WP_GPIO) {
> -               err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
> -               if (err) {
> -                       dev_err(mmc_dev(host->mmc),
> -                               "failed to request write-protect gpio!\n");
> -                       goto disable_clk;
> -               }
> -               host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> -       }
> -
>         /* card_detect */
> -       switch (boarddata->cd_type) {
> -       case ESDHC_CD_GPIO:
> -               err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);
> -               if (err) {
> -                       dev_err(mmc_dev(host->mmc),
> -                               "failed to request card-detect gpio!\n");
> -                       goto disable_clk;
> -               }
> -               /* fall through */
> -
> -       case ESDHC_CD_CONTROLLER:
> -               /* we have a working card_detect back */
> +       if (boarddata->cd_type == ESDHC_CD_CONTROLLER)
>                 host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> -               break;
> -
> -       case ESDHC_CD_PERMANENT:
> -               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> -               break;
> -
> -       case ESDHC_CD_NONE:
> -               break;
> -       }
>
>         switch (boarddata->max_bus_width) {
>         case 8:
> @@ -1079,6 +1048,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
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
