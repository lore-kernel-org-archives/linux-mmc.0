From: Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH 5/7] mmc: sdhci-bcm-kona: kill the "external_clk" member
 in driver private struct
Date: Thu, 5 Feb 2015 21:51:17 -0800
Message-ID: <54D45655.4030908@broadcom.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com> <1423192522-6056-6-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:55779 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbBFFvT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Feb 2015 00:51:19 -0500
In-Reply-To: <1423192522-6056-6-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com



On 2/5/2015 7:15 PM, Kevin Hao wrote:
> Actually we can use the "clk" in the struct sdhci_pltfm_host.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 34bb8f92586e..01660344e414 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -54,7 +54,6 @@
>  
>  struct sdhci_bcm_kona_dev {
>  	struct mutex	write_lock; /* protect back to back writes */
> -	struct clk	*external_clk;
>  };
>  
>  
> @@ -265,19 +264,19 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get and enable the external clock */

Would you mind changing the above comment to "/* Get and enable the core
clock */?

> -	kona_dev->external_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(kona_dev->external_clk)) {
> +	pltfm_priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pltfm_priv->clk)) {
>  		dev_err(dev, "Failed to get external clock\n");

Change to "Failed to get the core clock"

> -		ret = PTR_ERR(kona_dev->external_clk);
> +		ret = PTR_ERR(pltfm_priv->clk);
>  		goto err_pltfm_free;
>  	}
>  
> -	if (clk_set_rate(kona_dev->external_clk, host->mmc->f_max) != 0) {
> +	if (clk_set_rate(pltfm_priv->clk, host->mmc->f_max) != 0) {
>  		dev_err(dev, "Failed to set rate external clock\n");
>  		goto err_pltfm_free;
>  	}
>  
> -	if (clk_prepare_enable(kona_dev->external_clk) != 0) {
> +	if (clk_prepare_enable(pltfm_priv->clk) != 0) {
>  		dev_err(dev, "Failed to enable external clock\n");
>  		goto err_pltfm_free;
>  	}
> @@ -333,7 +332,7 @@ err_reset:
>  	sdhci_bcm_kona_sd_reset(host);
>  
>  err_clk_disable:
> -	clk_disable_unprepare(kona_dev->external_clk);
> +	clk_disable_unprepare(pltfm_priv->clk);
>  
>  err_pltfm_free:
>  	sdhci_pltfm_free(pdev);
> @@ -346,12 +345,11 @@ static int sdhci_bcm_kona_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
> -	struct sdhci_bcm_kona_dev *kona_dev = sdhci_pltfm_priv(pltfm_priv);
>  	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
>  
>  	sdhci_remove_host(host, dead);
>  
> -	clk_disable_unprepare(kona_dev->external_clk);
> +	clk_disable_unprepare(pltfm_priv->clk);
>  
>  	sdhci_pltfm_free(pdev);
>  
> 
Not sure if this is relevant and should be done in the same patch. But
both callbacks get_max_clock and get_timeout_clock in this driver can be
set to sdhci_pltfm_clk_get_max_clock. That will help to get rid of two
redundant private functions in this driver.

Thanks,

Ray
