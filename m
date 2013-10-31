From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: add eMMC HS200 mode support
Date: Thu, 31 Oct 2013 15:18:29 +0800
Message-ID: <20131031071826.GF23549@S2101-09.ap.freescale.net>
References: <1383142242-24989-1-git-send-email-b29396@freescale.com>
 <1383142242-24989-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:19984
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086Ab3JaHSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Oct 2013 03:18:22 -0400
Content-Disposition: inline
In-Reply-To: <1383142242-24989-3-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, wsa@the-dreams.de

On Wed, Oct 30, 2013 at 10:10:42PM +0800, Dong Aisheng wrote:
> Add support for eMMC 4.5 cards to work on hs200 mode.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ec25421..5816585 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -825,6 +825,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>  		pinctrl = imx_data->pins_100mhz;
>  		break;
>  	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS200:
>  		pinctrl = imx_data->pins_200mhz;
>  		break;
>  	default:
> @@ -852,6 +853,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR50;
>  		break;
>  	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS200:
>  		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
>  		break;
>  	case MMC_TIMING_UHS_DDR50:
> -- 
> 1.7.2.rc3
> 
> 

