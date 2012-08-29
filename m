From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: fix checkpatch error and warnings
Date: Wed, 29 Aug 2012 15:22:29 +0900
Message-ID: <503DB525.5020203@samsung.com>
References: <002701cd85a8$0c35e130$24a1a390$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43220 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2H2GWg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 02:22:36 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9I004Q970V5TM0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Aug 2012 15:22:34 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9I009LS71LKE00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Aug 2012 15:22:34 +0900 (KST)
In-reply-to: <002701cd85a8$0c35e130$24a1a390$%han@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 08/29/2012 02:35 PM, Jingoo Han wrote:
> This patch fixes the checkpatch error and warnings listed below:
> 
> ERROR: return is not a function, parentheses are not required
> WARNING: Prefer pr_err(... to printk(KERN_ERR, ...
> WARNING: quoted string split across lines
> WARNING: line over 80 characters
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index a50c205..00969ba 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -166,7 +166,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>  	dev_dbg(&ourhost->pdev->dev, "clk %d: rate %ld, want %d, got %ld\n",
>  		src, rate, wanted, rate / div);
>  
> -	return (wanted - (rate / div));
> +	return wanted - (rate / div);
>  }
>  
>  /**
> @@ -288,6 +288,7 @@ static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
>  static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_s3c *ourhost = to_s3c(host);
> +	struct device *dev = &ourhost->pdev->dev;
>  	unsigned long timeout;
>  	u16 clk = 0;
>  
> @@ -309,8 +310,8 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>  		& SDHCI_CLOCK_INT_STABLE)) {
>  		if (timeout == 0) {
> -			printk(KERN_ERR "%s: Internal clock never "
> -				"stabilised.\n", mmc_hostname(host->mmc));
> +			dev_err(dev, "%s: Internal clock never stabilised.\n",
> +				mmc_hostname(host->mmc));
>  			return;
>  		}
>  		timeout--;
> @@ -404,7 +405,9 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
>  		if (sc->ext_cd_irq &&
>  		    request_threaded_irq(sc->ext_cd_irq, NULL,
>  					 sdhci_s3c_gpio_card_detect_thread,
> -					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					 IRQF_TRIGGER_RISING |
> +					 IRQF_TRIGGER_FALLING |
> +					 IRQF_ONESHOT,
>  					 dev_name(dev), sc) == 0) {
>  			int status = gpio_get_value(sc->ext_cd_gpio);
>  			if (pdata->ext_cd_gpio_invert)
> @@ -486,9 +489,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>  		snprintf(name, 14, "mmc_busclk.%d", ptr);
>  		clk = clk_get(dev, name);
> -		if (IS_ERR(clk)) {
> +		if (IS_ERR(clk))
>  			continue;
> -		}
>  
>  		clks++;
>  		sc->clk_bus[ptr] = clk;
> 

