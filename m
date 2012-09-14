From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: Enable only required bus clock
Date: Fri, 14 Sep 2012 18:55:40 +0900
Message-ID: <5052FF1C.3060803@samsung.com>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
 <1347613731-29428-2-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1347613731-29428-2-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Chander,

Could you add the error control for clk_enable()?

On 09/14/2012 06:08 PM, Chander Kashyap wrote:
> In case of multiple bus clock sources, all the clock sources were
> getting enabled. As only one clock source is needed at the time hence
> enable only the required bus clock.
> 
> This patch does as follows:
> 1.	In sdhci_s3c_probe enable only required bus clock source.
> 
> 2.	Handle the disabling of old bus clock and enables the
> 	best clock selected in sdhci_s3c_set_clock().
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 00969ba..0cbb4c2 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -203,10 +203,12 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
>  		 best_src, clock, best);
>  
>  	/* select the new clock source */
> -
>  	if (ourhost->cur_clk != best_src) {
>  		struct clk *clk = ourhost->clk_bus[best_src];
>  
> +		clk_enable(clk);
> +		clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
> +
Did you consider the case that set_clock is assigned the sdhci_cmu_set_clock()?

>  		/* turn clock off to card before changing clock source */
>  		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
>  
> @@ -501,8 +503,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  		 */
>  		sc->cur_clk = ptr;
>  
> -		clk_enable(clk);
> -
>  		dev_info(dev, "clock source %d: %s (%ld Hz)\n",
>  			 ptr, name, clk_get_rate(clk));
>  	}
> @@ -513,6 +513,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  		goto err_no_busclks;
>  	}
>  
> +	clk_enable(sc->clk_bus[sc->cur_clk]);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
>  	if (!host->ioaddr) {
> @@ -621,9 +623,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	return 0;
>  
>   err_req_regs:
> +	clk_disable(sc->clk_bus[sc->cur_clk]);
>  	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		if (sc->clk_bus[ptr]) {
> -			clk_disable(sc->clk_bus[ptr]);
>  			clk_put(sc->clk_bus[ptr]);
>  		}
>  	}
> @@ -658,9 +660,9 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> +	clk_disable(sc->clk_bus[sc->cur_clk]);
>  	for (ptr = 0; ptr < 3; ptr++) {
>  		if (sc->clk_bus[ptr]) {
> -			clk_disable(sc->clk_bus[ptr]);
>  			clk_put(sc->clk_bus[ptr]);
>  		}
>  	}
> 
