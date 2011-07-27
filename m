From: Lin Tony-B19295 <B19295@freescale.com>
Subject: RE: [PATCH 1/1] fix card interrupt losing issue on freescale eSDHC
Date: Wed, 27 Jul 2011 06:38:23 +0000
Message-ID: <97D3A72708D04647A5AC84A04996E5B5166970@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1310966402-12318-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:57963 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1G0GiZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2011 02:38:25 -0400
In-Reply-To: <1310966402-12318-1-git-send-email-tony.lin@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lin Tony-B19295 <B19295@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Does anybody have any comment?
Anybody tried this patch?

BR
Tony

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
> kernel-bounces@lists.infradead.org] On Behalf Of Tony Lin
> Sent: Monday, July 18, 2011 1:20 PM
> To: linux-mmc@vger.kernel.org
> Cc: cjb@laptop.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 1/1] fix card interrupt losing issue on freescale eSDHC
> 
> apply workaround for imx eSDHC controller to avoid missing card interrupt
> so that SDIO function is workable
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   39 +++++++++++++++++++++++++++---
> -----
>  1 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index a19967d..da77cae 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -32,6 +32,8 @@
>  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
> 
>  #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
> +
> +#define	SDHCI_CTRL_D3CD			0x08
>  /*
>   * The CMDTYPE of the CMD register (offset 0xE) should be set to
>   * "11" when the STOP CMD12 is issued on imx53 to abort one @@ -87,14
> +89,31 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val,
> int reg)  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> -
> -	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
> -			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
> -		/*
> -		 * these interrupts won't work with a custom card_detect gpio
> -		 * (only applied to mx25/35)
> -		 */
> -		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +	u32 data;
> +
> +	if (unlikely((reg == SDHCI_INT_ENABLE || reg ==
> SDHCI_SIGNAL_ENABLE))) {
> +		if (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)
> +			/*
> +			 * these interrupts won't work with a custom
> +			 * card_detect gpio (only applied to mx25/35)
> +			 */
> +			val &= ~(SDHCI_INT_CARD_REMOVE | \
> +				SDHCI_INT_CARD_INSERT);
> +
> +		if (val & SDHCI_INT_CARD_INT) {
> +			/*
> +			 * clear D3CD bit and set D3CD bit to avoid
> +			 * missing card interrupt
> +			 * this is a eSDHC controller problem so that
> +			 * we need to apply following workaround
> +			 */
> +			data = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> +			data &= ~SDHCI_CTRL_D3CD;
> +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> +			data |= SDHCI_CTRL_D3CD;
> +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> +		}
> +	}
> 
>  	if (unlikely((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
>  				&& (reg == SDHCI_INT_STATUS)
> @@ -165,7 +184,9 @@ static void esdhc_writeb_le(struct sdhci_host *host,
> u8 val, int reg)
>  		return;
>  	case SDHCI_HOST_CONTROL:
>  		/* FSL messed up here, so we can just keep those two */
> -		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
> +		new_val = val & (SDHCI_CTRL_LED | \
> +				SDHCI_CTRL_4BITBUS | \
> +				SDHCI_CTRL_D3CD);
>  		/* ensure the endianess */
>  		new_val |= ESDHC_HOST_CONTROL_LE;
>  		/* DMA mode bits are shifted */
> --
> 1.7.0.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


