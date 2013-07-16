From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Write only 4 bit in case of
 TIMEOUT_CONTROL
Date: Tue, 16 Jul 2013 15:38:28 +0800
Message-ID: <20130716073826.GH28375@S2101-09.ap.freescale.net>
References: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:58161
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752205Ab3GPHid (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2013 03:38:33 -0400
Content-Disposition: inline
In-Reply-To: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Dirk,

On Tue, Jul 16, 2013 at 08:36:11AM +0200, Dirk Behme wrote:
> In case of SDHCI_TIMEOUT_CONTROL write only 4 bits and not the
> whole byte to avoid touching other unrelated bits in the i.MX6
> SYS_CTRL register. E.g. IPP_RST_N shouldn't be touched accidently.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

I'm wondering if it fixes any issue in real life?

Shawn

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 1dd5ba8..1af3a2a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -362,6 +362,18 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  
>  		esdhc_clrset_le(host, mask, new_val, reg);
>  		return;
> +	case SDHCI_TIMEOUT_CONTROL:
> +		/*
> +		 * On i.MX6 the timeout value DTOCV is 4 bit large. Touch only
> +		 * these 4 bits (lower nibble of the byte), but not the upper
> +		 * nibble of the byte. The upper nibble of the byte contains
> +		 * IPP_RST_N which should keep the reset value, i.e. 1, and
> +		 * shouldn't be touched here.
> +		 */
> +		if (is_imx6q_usdhc(imx_data)) {
> +			esdhc_clrset_le(host, 0x0f, val, reg);
> +			return;
> +		}
>  	}
>  	esdhc_clrset_le(host, 0xff, val, reg);
>  
> -- 
> 1.8.2
> 

