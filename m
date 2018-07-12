From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
Date: Thu, 12 Jul 2018 15:51:47 +0300
Message-ID: <d3aba616-ea14-4148-4522-e4abf0998be3@intel.com>
References: <20180712080725.14250-1-stefan@agner.ch>
 <20180712080725.14250-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712080725.14250-2-stefan@agner.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, ulf.hansson@linaro.org
Cc: fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 12/07/18 11:07, Stefan Agner wrote:
> Fix indent. This also makes disable/enable clock blocks look
> alike.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index acacd8481473..aa48f4b2541a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  	if (esdhc_is_usdhc(imx_data)) {
>  		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>  		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -		host->ioaddr + ESDHC_VENDOR_SPEC);
> +			host->ioaddr + ESDHC_VENDOR_SPEC);
>  	}
>  
>  	mdelay(1);
> 
