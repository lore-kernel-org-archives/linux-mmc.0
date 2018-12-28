From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: fix HS400 timing issue
Date: Fri, 28 Dec 2018 15:54:41 +0200
Message-ID: <a90f184d-39b2-32a6-b09d-91a07d398b35@intel.com>
References: <20181227112750.446-1-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181227112750.446-1-haibo.chen@nxp.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: BOUGH CHEN <haibo.chen@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 27/12/18 1:20 PM, BOUGH CHEN wrote:
> Now tuning reset will be done when the timing is MMC_TIMING_LEGACY/
> MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS. But for timing MMC_TIMING_MMC_HS,
> we can not do tuning reset, otherwise HS400 timing is not right.
> 
> Here is the process of init HS400, first finish tuning in HS200 mode,
> then switch to HS mode and 8 bit DDR mode, finally switch to HS400
> mode. If we do tuning reset in HS mode, this will cause HS400 mode
> lost the tuning setting, which will cause CRC error.
> 
> This fix commit d9370424c948 ("mmc: sdhci-esdhc-imx: reset tuning
> circuit when power on mmc card").
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v4.12+

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d0d319398a54..984cc1a788cb 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -979,6 +979,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  	case MMC_TIMING_UHS_SDR25:
>  	case MMC_TIMING_UHS_SDR50:
>  	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS:
>  	case MMC_TIMING_MMC_HS200:
>  		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>  		break;
> 
