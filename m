From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: reset tuning circuit when power
 on mmc card
Date: Tue, 18 Apr 2017 13:30:04 +0300
Message-ID: <8d59e986-785d-ec47-a6f4-af636be83f90@intel.com>
References: <1492509931-3388-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29950 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932733AbdDRKfv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 06:35:51 -0400
In-Reply-To: <1492509931-3388-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, ulf.hansson@linaro.org, aisheng.dong@nxp.com
Cc: linux-mmc@vger.kernel.org

On 18/04/17 13:05, Haibo Chen wrote:
> USDHC tuning circuit should be reset before every time card enumeration
> or re-enumeration.
> 
> SD3.0 card need tuning. For SDR104 card, when system suspend in standby
> mode, and then resume back, the IO timing is still SDR104(tuned) which
> may result in card re-enumeration fail in low card speed(400khz) for some
> cards. And we did meet the issue that in certain probability, SDR104
> card meet mmc command CRC/Timeout error when send CMD2 during mmc bus
> resume.
> 
> This patch reset the tuning circuit when the ios timing is
> MMC_TIMING_LEGACY/MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS, which means both
> mmc_power_up() and mmc_power_off() will reset the tuning circuit.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index abad67a..23d8b8a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -889,6 +889,28 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>  	}
>  }
>  
> +static void esdhc_reset_tuning(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 ctrl;
> +
> +	/* Rest the tuning circurt */
> +	if (esdhc_is_usdhc(imx_data)) {
> +		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> +			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> +			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> +			ctrl = readl(host->ioaddr + SDHCI_ACMD12_ERR);
> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
> +		}
> +	}
> +}
> +
>  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  {
>  	u32 m;
> @@ -932,6 +954,10 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		host->ops->set_clock(host, host->clock);
>  		esdhc_set_strobe_dll(host);
>  		break;
> +	case MMC_TIMING_LEGACY:
> +	default:
> +		esdhc_reset_tuning(host);
> +		break;
>  	}
>  
>  	esdhc_change_pinstate(host, timing);
> 

