From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: don't exit in case of no pinctrl states
Date: Mon, 13 Oct 2014 16:02:53 +0400
Message-ID: <000201cfe6dd$9e6e3fa0$db4abee0$@mentor.com>
References: <1412155532-32504-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:46419 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaJMMDA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Oct 2014 08:03:00 -0400
In-Reply-To: <1412155532-32504-1-git-send-email-andrew_gabbasov@mentor.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Any comments on this?

> -----Original Message-----
> From: Andrew Gabbasov [mailto:andrew_gabbasov@mentor.com] 
> Sent: Wednesday, October 01, 2014 1:26 PM
> To: linux-mmc@vger.kernel.org
> Subject: [PATCH] mmc: sdhci-esdhc-imx: don't exit in case of no pinctrl
states
> 
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
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ccec0e3..b714b9d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1012,9 +1012,7 @@ static int sdhci_esdhc_imx_probe(struct
platform_device *pdev)
>  	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
>  						PINCTRL_STATE_DEFAULT);
>  	if (IS_ERR(imx_data->pins_default)) {
> -		err = PTR_ERR(imx_data->pins_default);
> -		dev_err(mmc_dev(host->mmc), "could not get default
state\n");
> -		goto disable_clk;
> +		dev_warn(mmc_dev(host->mmc), "could not get default
state\n");
>  	}
>  
>  	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> @@ -1103,7 +1101,8 @@ static int sdhci_esdhc_imx_probe(struct
platform_device *pdev)
>  	}
>  
>  	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
> -	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data)) {
> +	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
> +	    !IS_ERR(imx_data->pins_default)) {
>  		imx_data->pins_100mhz =
pinctrl_lookup_state(imx_data->pinctrl,
>  						ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz =
pinctrl_lookup_state(imx_data->pinctrl,
> -- 
> 2.1.0

Thanks.

Best regards,
Andrew Gabbasov


