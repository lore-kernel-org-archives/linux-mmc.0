From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH-v2 5/7] mmc: sdhci-pxav3: Fix HS200 mode support
Date: Tue, 8 Sep 2015 14:53:48 +0800
Message-ID: <20150908145348.6ce640b1@xhacker>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1441624721-15612-6-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441624721-15612-6-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Tim Wang <wangtt-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 7 Sep 2015 16:48:39 +0530
Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> From: Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> IN case of MMC HS200 mode, current code does not enable
> SD_CE_ATA_2.MMC_HS200 & SD_CE_ATA_2.MMC_CARD bit configurations.
> 
> So this patch updates the above bit fields correctly.
> 
> Signed-off-by: Tim Wang <wangtt-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kevin Liu <kliu5-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Note: Unfortunately I do not have access to any other datasheets
> which uses sdhci-pxav3 driver, so quite not sure whether this would
> break any existing platform, probably NOT, as I do not see any
> references for this change.
> If anyone can confirm that would be really great.
> 
>  drivers/mmc/host/sdhci-pxav3.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index d933f75..6978810 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -57,6 +57,8 @@
>  #define SD_CE_ATA_1			0x10C
>  
>  #define SD_CE_ATA_2			0x10E
> +#define  SD_CE_ATA2_HS200_EN		BIT(10)
> +#define  SD_CE_ATA2_MMC_MODE		BIT(12)
>  #define  SDCE_MISC_INT			BIT(2)
>  #define  SDCE_MISC_INT_EN		BIT(1)
>  
> @@ -330,6 +332,17 @@ static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
>  	return pinctrl_select_state(pxa->pinctrl, pinctrl);
>  }
>  
> +static int pxav3_select_hs200(struct sdhci_host *host)

I didn't see why we need the return value, make it void would be better?

> +{
> +	u16 reg = 0;
> +
> +	reg = sdhci_readw(host, SD_CE_ATA_2);
> +	reg |= SD_CE_ATA2_HS200_EN | SD_CE_ATA2_MMC_MODE;
> +	sdhci_writew(host, reg, SD_CE_ATA_2);
> +
> +	return 0;
> +}
> +
>  static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -361,6 +374,10 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  	case MMC_TIMING_UHS_DDR50:
>  		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
>  		break;
> +	case MMC_TIMING_MMC_HS200:
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
> +		pxav3_select_hs200(host);
> +		break;
>  	}
>  
>  	/*

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
