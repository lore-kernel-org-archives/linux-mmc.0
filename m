From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 1/3] mmc: esdhc: enable polling to detect card by
 itself
Date: Wed, 31 Oct 2012 23:20:37 +0800
Message-ID: <20121031152030.GE8100@S2100-06.ap.freescale.net>
References: <1351589403-26398-1-git-send-email-yongd@marvell.com>
 <1351589403-26398-2-git-send-email-yongd@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351589403-26398-2-git-send-email-yongd@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yongd <yongd@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>, zhangfei.gao@marvell.com, kevin.liu@marvell.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 30, 2012 at 05:30:01PM +0800, yongd wrote:
> In the current code logic, sdhci_add_host() will enable the polling
> method (set MMC_CAP_NEEDS_POLL) for a removable card (MMC_CAP_
> NONREMOVABLE is not set) whose host's internal card detection method
> is disabled for some reason (SDHCI_QUIRK_BROKEN_CARD_DETECTION is set).
> 
> However, this is improper since we can have some other card detection
> methods besides host internal card detection and polling method. For
> example, if the card detection type is ESDHC_CD_GPIO (external gpio pin
> for CD), we should keep SDHCI_QUIRK_BROKEN_CARD_DETECTION set, or host
> internal card detection interrupt will still be enabled. So, here comes
> the 1st change in this patch to keep SDHCI_QUIRK_BROKEN_CARD_DETECTION
> set for ESDHC_CD_GPIO type. But, after the 1st change, just as above
> said, sdhci_add_host() will still enable polling for such a card.This
> is redundant.
> 
This actually results in an unpleasant rather than redundant behavior.
Right after this patch gets applied and before patch #3 gets applied,
driver sdhci-esdhc-imx will use polling even for ESDHC_CD_GPIO case.

> On the other hand, for the card with ESDHC_CD_NONE detection type(no CD,
> neither controller nor gpio, so use polling), we currently rely on
> sdhci_add_host() to enable polling for us.
> 
> Here propose the 2nd change in this patch for such an embarrassing case.

Besides above, this is another sign that the patch (and series) should
be better partitioned.

> 1st, this patch will de-couple polling enabling with sdhci_add_host() by
> doing this in host driver itself, just as some other vendors. 2nd, one
> more patch will remove such improper MMC_CAP_NEEDS_POLL enabling in
> sdhci_add_host().
> 
> Change-Id: Ia7525009d8fd188e3f0169f225e4a76ff9e94b47

Remove this, please.

> Signed-off-by: yongd <yongd@marvell.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index effc2ac..ff201a5 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -557,7 +557,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  			dev_err(mmc_dev(host->mmc), "request irq error\n");
>  			goto no_card_detect_irq;
>  		}
> -		/* fall through */
> +		break;

The current sdhci-esdhc-imx implementation clears flag
SDHCI_QUIRK_BROKEN_CARD_DETECTION even for ESDHC_CD_GPIO case
and then emulate flag SDHCI_CARD_PRESENT by reading CD gpio state in
esdhc_readl_le().  Obviously, simply setting the flag for gpio case
does not provide an equal behavior as before.

Shawn

>  
>  	case ESDHC_CD_CONTROLLER:
>  		/* we have a working card_detect back */
> @@ -569,6 +569,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		break;
>  
>  	case ESDHC_CD_NONE:
> +		host->mmc->caps = MMC_CAP_NEEDS_POLL;
>  		break;
>  	}
>  
> -- 
> 1.7.9.5
> 
