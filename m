From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: Do not break platform data boards
Date: Fri, 8 May 2015 13:46:45 +0200
Message-ID: <CAPDyKFr=y6Wjssv4K9ri281Su1ivY3DHwkMxJjFa-HoEOoWQ8w@mail.gmail.com>
References: <1431064569-5947-1-git-send-email-festevam@gmail.com>
	<1431064569-5947-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34003 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbEHLqq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 07:46:46 -0400
Received: by qkgx75 with SMTP id x75so45939095qkg.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2015 04:46:45 -0700 (PDT)
In-Reply-To: <1431064569-5947-2-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 8 May 2015 at 07:56, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> The only user of this driver that has not been converted to fully
> device tree is the i.MX35 SoC.
>
> There is a i.MX35-based board (mach-pcm043.c) that uses platform data
> to pass wp_gpio and cd_gpio information.
>
> Commit 8d86e4fcccf61ba ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
> broke the platform data case by removing mmc_gpio_request_ro() and
> mmc_gpio_request_cd(), so restore the functionality for the non-dt
> case.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a9980d7..812c670 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -918,6 +918,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         struct esdhc_platform_data *boarddata;
>         int err;
>         struct pltfm_imx_data *imx_data;
> +       bool dt = true;
>
>         host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
>         if (IS_ERR(host))
> @@ -1005,11 +1006,44 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 }
>                 imx_data->boarddata = *((struct esdhc_platform_data *)
>                                         host->mmc->parent->platform_data);
> +               dt = false;
> +       }
> +       /* write_protect */
> +       if (boarddata->wp_type == ESDHC_WP_GPIO && !dt) {
> +               err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
> +               if (err) {
> +                       dev_err(mmc_dev(host->mmc),
> +                               "failed to request write-protect gpio!\n");
> +                       goto disable_clk;
> +               }
> +               host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>         }
>
>         /* card_detect */
> -       if (boarddata->cd_type == ESDHC_CD_CONTROLLER)
> +       switch (boarddata->cd_type) {

I don't think you want to do this "switch" for dt case, right?

> +       case ESDHC_CD_GPIO:
> +               if (dt)
> +                       break;
> +               err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);
> +               if (err) {
> +                       dev_err(mmc_dev(host->mmc),
> +                               "failed to request card-detect gpio!\n");
> +                       goto disable_clk;
> +               }
> +               /* fall through */
> +
> +       case ESDHC_CD_CONTROLLER:
> +               /* we have a working card_detect back */
>                 host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +               break;
> +
> +       case ESDHC_CD_PERMANENT:
> +               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> +               break;
> +
> +       case ESDHC_CD_NONE:
> +               break;
> +       }
>
>         switch (boarddata->max_bus_width) {
>         case 8:
> --
> 1.9.1
>

Kind regards
Uffe
