From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: increase the pad I/O drive strength
 for DDR50 card
Date: Tue, 18 Apr 2017 10:01:15 +0300
Message-ID: <46db055c-73b8-5aa0-cc33-021d528ee816@intel.com>
References: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754706AbdDRHG5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 03:06:57 -0400
In-Reply-To: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, ulf.hansson@linaro.org, aisheng.dong@nxp.com
Cc: tharvey@gateworks.com, stable@vger.kernel.org, linux-mmc@vger.kernel.org

On 17/04/17 14:10, Haibo Chen wrote:
> Currently for DDR50 card, it need tuning in default. We meet tuning fail
> issue for DDR50 card and some data CRC error when DDR50 sd card works.
> 
> This is because the default pad I/O drive strength can't make sure DDR50
> card work stable. So increase the pad I/O drive strength for DDR50 card,
> and use pins_100mhz.
> 
> Tested-and-reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v4.4+

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index cf666a0..abad67a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -830,6 +830,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>  
>  	switch (uhs) {
>  	case MMC_TIMING_UHS_SDR50:
> +	case MMC_TIMING_UHS_DDR50:
>  		pinctrl = imx_data->pins_100mhz;
>  		break;
>  	case MMC_TIMING_UHS_SDR104:
> 

