From: Haibo Chen <haibo.chen-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC PATCH 14/21] mmc: sdhci-esdhc-imx: remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 06:54:44 +0000
Message-ID: <DB3PR04MB05535012DD334E9A534407D390D90@DB3PR04MB0553.eurprd04.prod.outlook.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <1453871318-3888-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1453871318-3888-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn, 

Comments below.



> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org]
> Sent: Wednesday, January 27, 2016 1:09 PM
> To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; linux-rpi-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>; Dong
> Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>; Haibo Chen
> <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Subject: [RFC PATCH 14/21] mmc: sdhci-esdhc-imx: remove
> SDHCI_QUIRK_BROKEN_CARD_DETECTION
> 
> sdhci_esdhc_imx_pdata need SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> so we replace it with MMC_CAP_NEEDS_POLL while probing. For other cases,
> we directly remove SDHCI_QUIRK_BROKEN_CARD_DETECTION.
> 
> Cc: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index f25f292..5705be1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -952,8 +952,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {  static const
> struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
>  	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
>  			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> -			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
> -			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> +			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
>  	.ops = &sdhci_esdhc_ops,
>  };
> 
> @@ -1012,7 +1011,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device
> *pdev,
>  		return ret;
> 
>  	if (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
> -		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +		host->mmc->caps &= MMC_CAP_NEEDS_POLL;

You miss ' ~', seems you need to change to:
host->mmc->caps &=~ MMC_CAP_NEEDS_POLL;

> 
>  	return 0;
>  }
> @@ -1064,7 +1063,7 @@ static int sdhci_esdhc_imx_probe_nondt(struct
> platform_device *pdev,
> 
>  	case ESDHC_CD_CONTROLLER:
>  		/* we have a working card_detect back */
> -		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +		host->mmc->caps &= MMC_CAP_NEEDS_POLL;

The same issue.

>  		break;
> 
>  	case ESDHC_CD_PERMANENT:
> @@ -1104,6 +1103,8 @@ static int sdhci_esdhc_imx_probe(struct
> platform_device *pdev)
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
> 
> +	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +
>  	pltfm_host = sdhci_priv(host);
> 
>  	imx_data = devm_kzalloc(&pdev->dev, sizeof(*imx_data),
> GFP_KERNEL);
> --
> 2.3.7
> 
