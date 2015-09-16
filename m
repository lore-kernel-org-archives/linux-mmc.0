From: Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH] mmc: sdhci-bcm-kona: fix logic to check for 8-bit data
 width
Date: Wed, 16 Sep 2015 10:20:11 -0700
Message-ID: <55F9A4CB.7070302@broadcom.com>
References: <1442397200-29731-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442397200-29731-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org



On 9/16/2015 2:53 AM, Javier Martinez Canillas wrote:
> The driver prints if the data width is 8-bit but it's using a
> binary OR instead of a binary AND so it will always report as
> "is_8bit=Y" regardless of the flags in host->mmc->caps.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 2bd90fb35c75..00a8a40a3729 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -273,7 +273,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  
>  	dev_dbg(dev, "is_8bit=%c\n",
> -		(host->mmc->caps | MMC_CAP_8_BIT_DATA) ? 'Y' : 'N');
> +		(host->mmc->caps & MMC_CAP_8_BIT_DATA) ? 'Y' : 'N');
>  

The fix looks good to me. Thanks.

Reviewed-by: Ray Jui <rjui@broadcom.com>

Ray
