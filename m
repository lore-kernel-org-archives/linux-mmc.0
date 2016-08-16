From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: do not touch other bit when config
 DTOCV
Date: Tue, 16 Aug 2016 15:30:50 +0800
Message-ID: <20160816073050.GA9211@shlinux2>
References: <1471249178-32204-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35614 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcHPHka (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2016 03:40:30 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so4857031pad.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Aug 2016 00:40:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1471249178-32204-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org

On Mon, Aug 15, 2016 at 04:19:38PM +0800, Haibo Chen wrote:
> Now, when call esdhc_set_timeout() to set the data timeout counter value,
> IPP_RST_N(bit 23) is wrongly affected. This patch add a mask to avoid this.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 99e0b33..437c448 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,7 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>  
> +#define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
>  #define	ESDHC_CTRL_D3CD			0x08
>  #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
>  /* VENDOR SPEC register */
> @@ -937,7 +938,8 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  
>  	/* use maximum timeout counter */
> -	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
> +	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
> +			esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
>  			SDHCI_TIMEOUT_CONTROL);
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
