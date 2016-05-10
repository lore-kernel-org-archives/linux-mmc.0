From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 18/23] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 STD_TUNING
Date: Tue, 10 May 2016 14:19:40 +0300
Message-ID: <5731C3CC.1000806@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-19-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51279 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbcEJLYn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 07:24:43 -0400
In-Reply-To: <1460741387-23815-19-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> Enable HW auto retuning when set SDHCI_CTRL_EXEC_TUNING and clear it
> when clear SDHCI_CTRL_TUNED_CLK.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

I presume this patch should wait for patch 17, but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 9f9be3f..a582a83 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -44,6 +44,7 @@
>  #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
>  #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
>  #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
> +#define  ESDHC_MIX_CTRL_AUTO_TUNE_EN	(1 << 24)
>  #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
>  #define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
>  /* Bits 3 and 6 are not SDHCI standard definitions */
> @@ -484,11 +485,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  			} else {
>  				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>  				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +				m &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  			}
>  
>  			if (val & SDHCI_CTRL_EXEC_TUNING) {
>  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
>  				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> +				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
>  				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT;
>  				if (imx_data->boarddata.tuning_start_tap) {
> 

