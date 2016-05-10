From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 14/23] mmc: sdhci-esdhci-imx: disable DLL delay line
 settings explicitly
Date: Tue, 10 May 2016 14:02:50 +0300
Message-ID: <5731BFDA.2000504@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-15-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55772 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbcEJLGp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 07:06:45 -0400
In-Reply-To: <1460741387-23815-15-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> From: Dong Aisheng <aisheng.dong@freescale.com>
> 
> Disable DLL delay line settings explicitly during driver initialization
> in case ROM/uBoot had set an invalid delay.
> e.g. MX6DL ROM has set the default delay line(DLLCTRL) to 0x1000021,
> the uSDHC clock timing will become marginal when works on DDR mode
> due to default delay and will possibly see CRC errors in case the board
> is not perfectly designed on the eMMC chip layout.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 4c28fbb..d02db66 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1186,6 +1186,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		*/
>  		writel(readl(host->ioaddr + 0x6c) | BIT(7),
>  			host->ioaddr + 0x6c);
> +
> +		/* disable DLL_CTRL delay line settings */
> +		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
>  	}
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
> 

