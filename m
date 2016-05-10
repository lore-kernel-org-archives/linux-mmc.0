From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 19/23] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
Date: Tue, 10 May 2016 14:24:40 +0300
Message-ID: <5731C4F8.4070604@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-20-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12411 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbcEJL2g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 07:28:36 -0400
In-Reply-To: <1460741387-23815-20-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> Indicating hw auto retuning support for mx6qdl in the fake caps_1
> register and enable auto retuning in post_tuning process after
> tuning completes.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

I presume this patch should wait for patch 17, but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a582a83..07b1144 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -301,7 +301,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  				/* imx6q/dl does not have cap_1 register, fake one */
>  				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
>  					| SDHCI_SUPPORT_SDR50
> -					| SDHCI_USE_SDR50_TUNING;
> +					| SDHCI_USE_SDR50_TUNING
> +					| (SDHCI_TUNING_MODE_3 << SDHCI_RETUNING_MODE_SHIFT);
>  
>  			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>  				val |= SDHCI_SUPPORT_HS400;
> @@ -471,10 +472,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
>  		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>  			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -			if (val & SDHCI_CTRL_TUNED_CLK)
> +			if (val & SDHCI_CTRL_TUNED_CLK) {
>  				new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			else
> +				new_val |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> +			} else {
>  				new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +				new_val &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> +			}
>  			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
> @@ -760,6 +764,7 @@ static void esdhc_post_tuning(struct sdhci_host *host)
>  
>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
>  	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> +	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  }
>  
> 

