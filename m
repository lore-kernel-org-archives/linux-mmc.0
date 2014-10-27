From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: don't exit in case of no pinctrl states
Date: Mon, 27 Oct 2014 13:24:23 +0100
Message-ID: <CAPDyKFq+Rqrbrs6Rkq2x8dTsbYd8fyfK7ULdfynNWmcwZcn7sQ@mail.gmail.com>
References: <1412155532-32504-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:54377 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaJ0MYe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 08:24:34 -0400
Received: by mail-qa0-f44.google.com with SMTP id w8so3730899qac.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 05:24:32 -0700 (PDT)
In-Reply-To: <1412155532-32504-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 1 October 2014 11:25, Andrew Gabbasov <andrew_gabbasov@mentor.com> wrote:
> From: Dirk Behme <dirk.behme@de.bosch.com>
>
> The commit ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl state
> according to uhs mode") exits the probe in case there are no valid
> pinctrl states found.
>
> As there are configurations doing the pin mux properly in the boot
> loader, don't exit. Just warn, but go on in case if there are no
> pinctrl states in the device tree.
>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Thanks! Applied for next with a minor fix, see below!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ccec0e3..b714b9d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1012,9 +1012,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 PINCTRL_STATE_DEFAULT);
>         if (IS_ERR(imx_data->pins_default)) {
> -               err = PTR_ERR(imx_data->pins_default);
> -               dev_err(mmc_dev(host->mmc), "could not get default state\n");
> -               goto disable_clk;
> +               dev_warn(mmc_dev(host->mmc), "could not get default state\n");

This "if" don't need the brackets any more. I removed them.

>         }
>
>         host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> @@ -1103,7 +1101,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         }
>
>         /* sdr50 and sdr104 needs work on 1.8v signal voltage */
> -       if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data)) {
> +       if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
> +           !IS_ERR(imx_data->pins_default)) {
>                 imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
